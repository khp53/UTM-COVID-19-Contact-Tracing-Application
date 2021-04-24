import 'package:flutter/material.dart';
import 'package:utmccta/DLL/adminDA.dart';

class AdminAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _AdminAppBarState createState() => _AdminAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _AdminAppBarState extends State<AdminAppBar> {
  AdminDA _adminDA = AdminDA();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      title: Text(
        'Admin Dashboard  UTM CCTA',
        style: Theme.of(context).primaryTextTheme.headline2,
      ),
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
      ),
      actions: [
        MaterialButton(
          elevation: 0,
          color: Theme.of(context).accentColor,
          onPressed: () {
            setState(() {
              _adminDA.signOutAdmin();
            });
          },
          child: Text(
            'Sign Out',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
