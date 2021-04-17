import 'package:flutter/material.dart';
import 'package:utmccta/BLL/adminHandler.dart';

class SideNav extends StatefulWidget {
  @override
  _SideNavState createState() => _SideNavState();
}

class _SideNavState extends State<SideNav> {
  AdminHandler _adminHandler = AdminHandler();

  bool isClickedHome = false;
  bool isClickedLocation = false;
  bool isClickedNotification = false;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).primaryColorDark,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
        child: Column(
          children: [
            _adminHandler.createState().getAdminProfileImage(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            Divider(
              color: Colors.white,
              thickness: 3,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            Container(
              child: InkWell(
                onTap: () {
                  setState(() {
                    isClickedHome = true;
                  });
                },
                child: Icon(
                  Icons.home,
                  color: (isClickedHome)
                      ? Theme.of(context).accentColor
                      : Colors.white,
                  size: 40,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Container(
              child: InkWell(
                onTap: () {
                  setState(() {
                    isClickedLocation = true;
                  });
                },
                child: Icon(
                  Icons.location_on,
                  color: (isClickedLocation)
                      ? Theme.of(context).accentColor
                      : Colors.white,
                  size: 40,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Container(
              child: InkWell(
                onTap: () {
                  setState(() {
                    isClickedNotification = true;
                  });
                },
                child: Icon(
                  Icons.notifications,
                  color: (isClickedNotification)
                      ? Theme.of(context).accentColor
                      : Colors.white,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
