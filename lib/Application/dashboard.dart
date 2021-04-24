import 'package:flutter/material.dart';
import 'package:utmccta/BLL/adminHandler.dart';
import 'package:utmccta/DLL/adminDA.dart';

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
