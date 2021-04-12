import 'package:flutter/material.dart';
import 'package:utmccta/DLL/userDA.dart';
import 'package:utmccta/main.dart';

class ManageProfile extends StatefulWidget {
  @override
  _ManageProfileState createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  UserDA _userDA = UserDA();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: ListTile(
        tileColor: Color(0xff131313),
        onTap: () {
          _userDA.signOutUser();
          Navigator.pushReplacementNamed(context, '/authManagement');
        },
        leading: Icon(
          Icons.exit_to_app,
          color: Colors.white,
        ),
        title: Text(
          'Log Out',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
