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
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    width: w / 2,
                    height: h / 2,
                    decoration: new BoxDecoration(
                      color: Color(0xff8E2D50),
                      borderRadius: new BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child:
                        _adminHandler.createState().getTotalUserNumber(context),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    width: w / 2,
                    height: h / 2,
                    decoration: new BoxDecoration(
                      color: Color(0xffC56CFF),
                      borderRadius: new BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: _adminHandler.createState().getTotalCovidPositive(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Text(
              'User\'s Personal & Health Details',
              style: Theme.of(context).primaryTextTheme.headline2,
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 0,
              color: Color(0xffF0F0F0),
              child: _adminHandler.createState().getUserDetails(),
            ),
            SizedBox(
              height: 20,
            ),
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
