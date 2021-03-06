import 'package:flutter/material.dart';
import 'package:utmccta/DLL/locationEntryDA.dart';

class LocationEntryHandler extends StatefulWidget {
  @override
  _LocationEntryHandlerState createState() => _LocationEntryHandlerState();
}

class _LocationEntryHandlerState extends State<LocationEntryHandler> {
  LocationEntryDA _locationEntryDA = new LocationEntryDA();
  // upload data from location form to firebase using dll
  uploadLoacationEntryData(
      locationName, fullAddress, visitTime, visitDate, entryDate) async {
    Map<String, dynamic> locationMap = {
      "locationName": locationName,
      "fullAddress": fullAddress,
      "visitTime": visitTime,
      "visitDate": visitDate,
      "entryDate": entryDate,
    };
    await _locationEntryDA.setUserLocationEntry(locationMap);
    //await _locationEntryDA.updateUserLocationEntry(locationMap);
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
