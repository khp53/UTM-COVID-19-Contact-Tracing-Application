import 'package:flutter/material.dart';
import 'package:utmccta/Application/helpers/adminAppbar.dart';
import 'package:utmccta/Application/helpers/sidenav.dart';

class FirebaseCloudMessagingConsole extends StatefulWidget {
  @override
  _FirebaseCloudMessagingConsoleState createState() =>
      _FirebaseCloudMessagingConsoleState();
}

class _FirebaseCloudMessagingConsoleState
    extends State<FirebaseCloudMessagingConsole> {
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
