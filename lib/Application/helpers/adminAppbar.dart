import 'package:flutter/material.dart';
import 'package:utmccta/Application/helpers/main_button.dart';
import 'package:utmccta/DLL/adminDA.dart';

class AdminAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _AdminAppBarState createState() => _AdminAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _AdminAppBarState extends State<AdminAppBar> {
  AdminDA _adminDA = AdminDA();
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
                });
              },
              child: Container(
                height: 35,
                width: MediaQuery.of(context).size.width / 12,
                decoration: mainButton(),
                child: Center(
                    child: Text('Sign Out',
                        style: TextStyle(color: Colors.white, fontSize: 15))),
              )),
        ),
      ],
    );
  }
}
