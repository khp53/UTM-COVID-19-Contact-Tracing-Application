import 'package:flutter/material.dart';
import 'package:utmccta/BLL/adminHandler.dart';

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

class DashboardHealthAuthorities extends StatefulWidget {
  @override
  _DashboardHealthAuthoritiesState createState() =>
      _DashboardHealthAuthoritiesState();
}

class _DashboardHealthAuthoritiesState
    extends State<DashboardHealthAuthorities> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      height: 500,
      width: 500,
    );
  }
}
