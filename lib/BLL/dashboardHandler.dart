import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:utmccta/Application/helpers/DashboardSideNavAdmin.dart';
import 'package:utmccta/Application/helpers/DashboardSideNavClinic.dart';
import 'package:utmccta/Application/loginForm.dart';

class DashboardHandler extends StatefulWidget {
  @override
  _DashboardHandlerState createState() => _DashboardHandlerState();
}

class _DashboardHandlerState extends State<DashboardHandler> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // manages login based on who is using
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _auth.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data is User && snapshot.data != null) {
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('System Administrators')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .snapshots(),
              builder: (context, snapshot1) {
                if (snapshot1.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot1.data != null) {
                  //print(FirebaseAuth.instance.currentUser.uid);
                  final u = snapshot1.data.data();
                  if (u['role'] == 'admin') {
                    return DashBoardSideNavAdmin();
                  } else if (u['role'] == 'healthauthority') {
                    return DashBoardSideNavClinic();
                  }
                }
                return Center(
                  child: Text('${FirebaseAuth.instance.currentUser.uid}'),
                );
              },
            );
          }
          return LogIn();
        });
  }
}
