import 'package:flutter/material.dart';
import 'package:utmccta/DLL/userDA.dart';

class ManageProfile extends StatefulWidget {
  @override
  _ManageProfileState createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  UserDA _userDA = UserDA();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UTM CCTA',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: Container(
        child: Center(
          child: TextButton(
            onPressed: () {
              _userDA.signOutUser();
              Navigator.of(context).pop();
            },
            child: Text('Log Out'),
          ),
        ),
      ),
    );
  }
}
