import 'package:flutter/material.dart';
import 'package:utmccta/BLL/adminHandler.dart';
import 'package:utmccta/BLL/googleMapsAPIHandler.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  GoogleMapsAPIHandler _googleMapsAPIHandler = new GoogleMapsAPIHandler();
  AdminHandler _adminHandler = new AdminHandler();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Location of Contact of All COVID-19 Positive Users',
            style: Theme.of(context).primaryTextTheme.headline2,
          ),
          SizedBox(
            height: 30,
          ),
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              child: _googleMapsAPIHandler),
          SizedBox(
            height: 40,
          ),
          Text(
            'All User\'s Location Entires',
            style: Theme.of(context).primaryTextTheme.headline2,
          ),
          SizedBox(
            height: 30,
          ),
          Card(
            elevation: 0,
            color: Color(0xffF0F0F0),
            child: _adminHandler.createState().getLocationEntry(context),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}
