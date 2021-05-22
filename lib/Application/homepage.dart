import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:utmccta/Application/locationEntryForm.dart';
import 'package:utmccta/Application/locationHistoryPage.dart';
import 'package:utmccta/BLL/googleNearbyAPI.dart';
import 'package:utmccta/Application/manageProfile.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  //stab text style
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  // classes or widgets to show after clicking bottom nav
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    LocationEntryForm(),
    LocationHistoryPage(),
    ManageProfile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          'UTM CCTA',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xff131313),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Location Entry',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'User',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).accentColor,
        onTap: _onItemTapped,
      ),
    ));
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleNearbyAPI _api = GoogleNearbyAPI();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _api.createState().removeOldContactListFromDB(14);
    _api.createState().addContactsToList();
    _api.createState().getPermissions();
    _api.createState().checkIfGPSOn();
  }

  Widget scanButton() {
    return Container(
        child: Column(
      children: [
        !isLoading
            ? Container(
                padding:
                    EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
                child: MaterialButton(
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  elevation: 0,
                  color: Theme.of(context).accentColor,
                  onPressed: () async {
                    if (!(await Geolocator.isLocationServiceEnabled())) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text(
                                  "Attention!",
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                backgroundColor:
                                    Theme.of(context).dialogBackgroundColor,
                                content: Text(
                                  "Please Turn On GPS or Location Services!",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("OK"))
                                ],
                              ));
                    } else {
                      if (this.mounted) {
                        setState(() {
                          isLoading = true;
                        });
                      }
                      _api.createState().adverise();
                      _api.createState().discovery();
                    }
                  },
                  child: Center(
                      child: Text('Start Scanning',
                          style: TextStyle(color: Colors.white, fontSize: 15))),
                ),
              )
            : Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Scanning...',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          height: 17,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 40, right: 40, top: 10, bottom: 10),
                    child: MaterialButton(
                      elevation: 0,
                      color: Color(0xffFF725E),
                      height: 50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      onPressed: () async {
                        if (this.mounted) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                        _api.createState().stopAdvertising();
                        _api.createState().stopDiscovery();
                      },
                      child: Center(
                        child: Text(
                          'Stop Scanning',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage('assets/img/homeMainImage.png'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Icon(
                Icons.gps_fixed,
                color: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'The app requires GPS and Bluetooth Connection to trace contacts, make sure ypu GPS connection is on while using the app',
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
            ),
            scanButton()
          ],
        ),
      ),
    );
  }
}
