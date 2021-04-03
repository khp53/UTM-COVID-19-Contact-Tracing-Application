import 'package:flutter/material.dart';
import 'package:utmccta/DLL/loginDA.dart';
import 'package:utmccta/DLL/adminDA.dart';

class Homepage extends StatefulWidget {
  final String id = 'Homepage';
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  AdminDA _adminDA = AdminDA();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextButton(
          onPressed: () => _adminDA.signOutAdmin(),
          child: Text('Log out'),
        ),
      ),
    );
  }
}
