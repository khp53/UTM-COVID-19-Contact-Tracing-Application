import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:utmccta/Application/locationPage.dart';
import 'package:utmccta/BLL/adminHandler.dart';
import 'package:utmccta/BLL/users.dart';
import 'package:utmccta/DLL/adminDA.dart';
import 'package:utmccta/Application/helpers/adminAppbar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  AdminDA _adminDA = AdminDA();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DashBoadrdAdmin(),
      ),
    );
  }
}

class DashBoadrdAdmin extends StatefulWidget {
  @override
  _DashBoadrdAdminState createState() => _DashBoadrdAdminState();
}

class _DashBoadrdAdminState extends State<DashBoadrdAdmin> {
  AdminHandler _adminHandler = AdminHandler();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'User\'s Personal Details',
              style: Theme.of(context).primaryTextTheme.headline1,
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              child: _adminHandler.createState().getUserDetails(),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'User\'s Health Details',
              style: Theme.of(context).primaryTextTheme.headline1,
            ),
            Card(
              child: _adminHandler.createState().getUserHealthDetails(),
            )
          ],
        ),
      ),
    );
  }
}

class UserDetails extends StatelessWidget {
  final String userID;
  final String mobileNumber;
  final String email;
  final String address;
  final String icNo;
  final String img;
  final String name;
  final int postcode;
  final String riskStatus;
  final bool closeContact;
  final bool covidStatus;
  final bool covidSymptoms;
  final bool generalSymptoms;
  final bool immunocompromised;
  final bool traveled;

  UserDetails(
      {this.name,
      this.img,
      this.riskStatus,
      this.userID,
      this.mobileNumber,
      this.email,
      this.address,
      this.icNo,
      this.postcode,
      this.closeContact,
      this.covidStatus,
      this.covidSymptoms,
      this.generalSymptoms,
      this.immunocompromised,
      this.traveled});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
