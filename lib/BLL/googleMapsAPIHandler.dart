import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:utmccta/DLL/locationEntryDA.dart';

class GoogleMapsAPIHandler extends StatefulWidget {
  @override
  _GoogleMapsAPIHandlerState createState() => _GoogleMapsAPIHandlerState();
}

class _GoogleMapsAPIHandlerState extends State<GoogleMapsAPIHandler> {
  LocationEntryDA _locationEntryDA = LocationEntryDA();

  static final LatLng _kMapCenter = LatLng(23.703379, 90.3958962);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 17, tilt: 0, bearing: 0);
  @override
  void initState() {
    getMapMarkerData();
    super.initState();
  }

  getMapMarkerData() {
    _locationEntryDA
        .getUsersLatLang()
        .where('contactCovidStatus', isEqualTo: true)
        .get()
        .then((docs) {
      if (docs.docs.isNotEmpty) {
        for (int i = 0; i < docs.docs.length; i++) {
          initMarker(docs.docs[i].data(), docs.docs[i].id);
        }
      }
    });
  }

  void initMarker(contactMarker, mID) {
    var markerIdVal = mID;
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(contactMarker['contactLocationLatitude'],
          contactMarker['contactLocationLongitudee']),
      infoWindow: InfoWindow(
          title: contactMarker['contactName'],
          snippet: contactMarker['contactNumber']),
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: GoogleMap(
        markers: Set<Marker>.of(markers.values),
        initialCameraPosition: _kInitialPosition,
      ),
    );
  }
}
