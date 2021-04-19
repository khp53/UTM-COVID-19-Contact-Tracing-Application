import 'package:flutter/material.dart';
import 'package:utmccta/Application/helpers/adminAppbar.dart';
import 'package:utmccta/Application/helpers/sideNav.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 500,
        width: 500,
        color: Colors.amber,
      ),
    );
  }
}
