import 'package:flutter/material.dart';
import 'package:utmccta/BLL/adminHandler.dart';
import 'package:utmccta/DLL/adminDA.dart';
import 'package:utmccta/Application/helpers/sideNav.dart';
import 'package:utmccta/Application/helpers/adminAppbar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  AdminHandler _adminHandler = AdminHandler();
  AdminDA _adminDA = AdminDA();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            SideNav(),
            Flexible(
              flex: 12,
              child: Scaffold(
                  appBar: AdminAppBar(),
                  body: Container(
                    child: Center(
                      child: Text('Admin Dashboard'),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
