import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:utmccta/Application/dashboard.dart';
import 'package:utmccta/Application/homepage.dart';
import 'package:utmccta/BLL/admin.dart';
import 'package:utmccta/DLL/adminDA.dart';

class DashboardHandler extends StatefulWidget {
  @override
  _DashboardHandlerState createState() => _DashboardHandlerState();
}

class _DashboardHandlerState extends State<DashboardHandler> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // manages login based on who is using
  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser.email == "admin@utm.my") {
      return Dashboard();
    } else {
      return Homepage();
    }
  }
}
