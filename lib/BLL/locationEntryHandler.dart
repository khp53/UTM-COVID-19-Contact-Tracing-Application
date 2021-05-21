import 'package:cloud_firestore/cloud_firestore.dart';
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
      locationName, fullAddress, visitTime, visitDate, entryDate) {
    Map<String, dynamic> locationMap = {
      "locationEntry": FieldValue.arrayUnion([
        {
          "locationName": locationName,
          "fullAddress": fullAddress,
          "visitTime": visitTime,
          "visitDate": visitDate,
          "entryDate": entryDate,
        }
      ])
    };
    _locationEntryDA.uploadUserLocationEntry(locationMap);
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
