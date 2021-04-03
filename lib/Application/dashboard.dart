import 'package:flutter/material.dart';
import 'package:utmccta/DLL/adminDA.dart';
import 'package:utmccta/main.dart';

import 'helpers/main_button.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  AdminDA _adminDA = AdminDA();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            'Admin Dashboard  UTM CCTA',
            style: Theme.of(context).primaryTextTheme.headline2,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      _adminDA.signOutAdmin();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StateMangement()));
                    });
                  },
                  child: Container(
                    height: 35,
                    width: MediaQuery.of(context).size.width / 12,
                    decoration: mainButton(),
                    child: Center(
                        child: Text('Sign Out',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15))),
                  )),
            ),
          ],
        ),
        body: Container(
          child: Center(
            child: Text('Admin Dashboard'),
          ),
        ));
  }
}
