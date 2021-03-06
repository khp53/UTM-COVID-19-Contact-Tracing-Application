import 'package:flutter/material.dart';
import 'package:utmccta/BLL/adminHandler.dart';
import 'package:utmccta/BLL/utmHealthAuthorityHandler.dart';

class DashBoadrdAdmin extends StatefulWidget {
  @override
  _DashBoadrdAdminState createState() => _DashBoadrdAdminState();
}

class _DashBoadrdAdminState extends State<DashBoadrdAdmin> {
  AdminHandler _adminHandler = AdminHandler();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scrollbar(
      controller: _scrollController,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      width: w / 2,
                      height: h / 2,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: _adminHandler
                          .createState()
                          .getTotalUserNumber(context),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      width: w / 2,
                      height: h / 2,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child:
                          _adminHandler.createState().getTotalCovidPositive(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'User\'s Personal & Health Details',
                style: Theme.of(context).primaryTextTheme.headline2,
              ),
              SizedBox(
                height: 20,
              ),
              _adminHandler.createState().getUserDetails(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardHealthAuthorities extends StatefulWidget {
  @override
  _DashboardHealthAuthoritiesState createState() =>
      _DashboardHealthAuthoritiesState();
}

class _DashboardHealthAuthoritiesState
    extends State<DashboardHealthAuthorities> {
  final ScrollController _scrollController = ScrollController();
  UTMHealthAuthorityHandler _authorityHandler = UTMHealthAuthorityHandler();
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scrollbar(
      controller: _scrollController,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      width: w / 2,
                      height: h / 2,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: _authorityHandler.getTotalUserNumber(context),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      width: w / 2,
                      height: h / 2,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: _authorityHandler.getTotalCovidPositive(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      width: w / 2,
                      height: h / 2,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: _authorityHandler.getTotalCovidSymptom(context),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      width: w / 2,
                      height: h / 2,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: _authorityHandler.getTotalCloseContacts(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
