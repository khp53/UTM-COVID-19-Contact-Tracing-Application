import 'package:flutter/material.dart';
import 'package:utmccta/Application/dashboard.dart';
import 'package:utmccta/Application/searchPage.dart';
import 'package:utmccta/BLL/utmHealthAuthorityHandler.dart';
import 'package:utmccta/DLL/adminDA.dart';

class DashBoardSideNavClinic extends StatefulWidget {
  @override
  _DashBoardSideNavClinicState createState() => _DashBoardSideNavClinicState();
}

class _DashBoardSideNavClinicState extends State<DashBoardSideNavClinic>
    with SingleTickerProviderStateMixin {
  UTMHealthAuthorityHandler _authorityHandler = UTMHealthAuthorityHandler();
  TabController tabController;
  int active = 0;

  AdminDA _adminDA = AdminDA();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: 2, initialIndex: 0)
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
        backgroundColor: Color(0xffF0F0F0),
        key: _scaffoldKey,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColorDark,
            title: Row(
              children: [
                Image.asset(
                  'assets/img/logo.png',
                  width: 50,
                  height: 50,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Admin Dashboard  UTM CCTA',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
            leading: MediaQuery.of(context).size.width < 1300
                ? IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () => _scaffoldKey.currentState.openDrawer(),
                  )
                : null,
            actions: [
              InkWell(child: _authorityHandler.getClinicProfileImage()),
            ]),
        body: Row(
          children: <Widget>[
            MediaQuery.of(context).size.width < 1300
                ? Container()
                : Card(
                    margin: EdgeInsets.zero,
                    elevation: 0,
                    child: Container(
                        margin: EdgeInsets.all(0),
                        height: MediaQuery.of(context).size.height,
                        width: 200,
                        color: Theme.of(context).primaryColorDark,
                        child: listDrawerItems(false, context)),
                  ),
            Container(
              width: MediaQuery.of(context).size.width < 1300
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width - 200,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  DashboardHealthAuthorities(),
                  SearchPage(),
                ],
              ),
            )
          ],
        ),
        drawer: MediaQuery.of(context).size.width < 1300
            ? Theme(
                data: Theme.of(context)
                    .copyWith(canvasColor: Theme.of(context).primaryColorDark),
                child: Padding(
                    padding: EdgeInsets.only(top: 56),
                    child: Drawer(child: listDrawerItems(true, context))),
              )
            : null);
  }

  Widget listDrawerItems(bool drawerStatus, BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
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
        Spacer(),
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
                  Icons.search,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Search Users",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ]),
            ),
          ),
        ),
        Spacer(
          flex: 20,
        ),
        Container(
          width: 200,
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: MaterialButton(
            elevation: 0,
            height: 50,
            onPressed: () => _adminDA.signOutAdmin(),
            color: Theme.of(context).accentColor,
            child: Text(
              'SIGN OUT',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
