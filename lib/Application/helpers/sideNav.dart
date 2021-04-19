import 'package:flutter/material.dart';
import 'package:utmccta/Application/dashboard.dart';
import 'package:utmccta/Application/firebaseCloudMessagingConsole.dart';
import 'package:utmccta/Application/helpers/adminAppbar.dart';
import 'package:utmccta/Application/helpers/main_button.dart';
import 'package:utmccta/Application/locationPage.dart';
import 'package:utmccta/BLL/adminHandler.dart';
import 'package:utmccta/DLL/adminDA.dart';

class SideNav extends StatefulWidget {
  @override
  _SideNavState createState() => _SideNavState();
}

class _SideNavState extends State<SideNav> with SingleTickerProviderStateMixin {
  AdminHandler _adminHandler = AdminHandler();
  TabController tabController;
  int active = 0;

  AdminDA _adminDA = AdminDA();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: 3, initialIndex: 0)
      ..addListener(() {
        setState(() {
          active = tabController.index;
        });
      });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            'Admin Dashboard  UTM CCTA',
            style: Theme.of(context).primaryTextTheme.headline2,
          ),
          leading: MediaQuery.of(context).size.width < 1300
              ? IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  onPressed: () => _scaffoldKey.currentState.openDrawer(),
                )
              : null,
          actions: [
            TextButton(
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
          ],
        ),
        body: Row(
          children: <Widget>[
            MediaQuery.of(context).size.width < 1300
                ? Container()
                : Card(
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAlias,
                    elevation: 0,
                    child: Container(
                        margin: EdgeInsets.all(0),
                        height: MediaQuery.of(context).size.height,
                        width: 200,
                        color: Theme.of(context).primaryColorDark,
                        child: listDrawerItems(false)),
                  ),
            Container(
              width: MediaQuery.of(context).size.width < 1300
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width - 310,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  Dashboard(),
                  LocationPage(),
                  FirebaseCloudMessagingConsole(),
                ],
              ),
            )
          ],
        ),
        drawer: MediaQuery.of(context).size.width < 1300
            ? Padding(
                padding: EdgeInsets.only(top: 56),
                child: Drawer(child: listDrawerItems(true)))
            : null);
  }

  Widget listDrawerItems(bool drawerStatus) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height / 30,
        ),
        _adminHandler.createState().getAdminProfileImage(),
        SizedBox(
          height: MediaQuery.of(context).size.height / 50,
        ),
        Divider(
          color: Colors.white,
          thickness: 2,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 50,
        ),
        // ignore: deprecated_member_use
        FlatButton(
          color: tabController.index == 0
              ? Theme.of(context).accentColor
              : Colors.transparent,
          //color: Colors.grey[100],
          onPressed: () {
            tabController.animateTo(0);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(
                  Icons.dashboard,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Dashboard",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ]),
            ),
          ),
        ),
        // ignore: deprecated_member_use
        FlatButton(
          color: tabController.index == 1
              ? Theme.of(context).accentColor
              : Colors.transparent,
          //color: Colors.grey[100],
          onPressed: () {
            tabController.animateTo(1);
            drawerStatus ? Navigator.pop(context) : print("");
          },

          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Location Details",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ]),
            ),
          ),
        ),
        // ignore: deprecated_member_use
        FlatButton(
          color: tabController.index == 2
              ? Theme.of(context).accentColor
              : Colors.transparent,
          //color: Colors.grey[100],
          onPressed: () {
            tabController.animateTo(2);
            drawerStatus ? Navigator.pop(context) : print("");
          },

          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Send Notification",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}

// return Flexible(
//   flex: 1,
//   child: Container(
//     width: MediaQuery.of(context).size.width,
//     color: Theme.of(context).primaryColorDark,
//     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
//     child: Column(
//       children: [
//         _adminHandler.createState().getAdminProfileImage(),
//         SizedBox(
//           height: MediaQuery.of(context).size.height / 50,
//         ),
//         Divider(
//           color: Colors.white,
//           thickness: 3,
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height / 50,
//         ),
//         Container(
//           child: InkWell(
//             onTap: () {
//               Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => Dashboard()));
//             },
//             child: Icon(
//               Icons.home,
//               color: (!isClickedHome)
//                   ? Theme.of(context).accentColor
//                   : Colors.white,
//               size: 40,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height / 20,
//         ),
//         Container(
//           child: InkWell(
//             onTap: () {
//               setState(() {
//                 isClickedLocation = true;
//                 isClickedHome = true;
//               });

//               Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => LocationPage()));
//             },
//             child: Icon(
//               Icons.location_on,
//               color: (!isClickedLocation)
//                   ? Theme.of(context).accentColor
//                   : Colors.white,
//               size: 40,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height / 20,
//         ),
//         Container(
//           child: InkWell(
//             onTap: () {
//               setState(() {
//                 isClickedNotification = true;
//               });
//             },
//             child: Icon(
//               Icons.notifications,
//               color: (isClickedNotification)
//                   ? Theme.of(context).accentColor
//                   : Colors.white,
//               size: 40,
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// );
