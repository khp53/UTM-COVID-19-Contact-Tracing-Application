import 'package:flutter/material.dart';
import 'package:utmccta/Application/helpers/main_button.dart';
import 'package:utmccta/Application/privacy_info.dart';

class WelcomeScreen extends StatelessWidget {
  final String id = 'WelcomeScreen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          padding: EdgeInsets.fromLTRB(
              20, 0, 20, MediaQuery.of(context).size.height / 20),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    'Welcome to\nUTM COVID-19 Contact\nTracing Application',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Icon(
                    Icons.contacts,
                    color: Theme.of(context).accentColor,
                    size: 32,
                  ),
                  title: Transform.translate(
                    offset: Offset(0, -2.5),
                    child: Text(
                      'Contact Tracing',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  subtitle: Transform.translate(
                    offset: Offset(0, 2.5),
                    child: Text(
                      'Real-Time contact tracing using device\'s\nBluetooth and GPS.',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Icon(
                    Icons.location_on,
                    color: Theme.of(context).accentColor,
                    size: 32,
                  ),
                  title: Transform.translate(
                    offset: Offset(0, -2.5),
                    child: Text(
                      'Manual Location Entry',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  subtitle: Transform.translate(
                    offset: Offset(0, 2.5),
                    child: Text(
                      'Enter your visited location when ever you\nwant. Your privacy is at your hand.',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Icon(
                    Icons.notifications_active,
                    color: Theme.of(context).accentColor,
                    size: 32,
                  ),
                  title: Transform.translate(
                    offset: Offset(0, -2.5),
                    child: Text(
                      'Real-Time Alerts',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  subtitle: Transform.translate(
                    offset: Offset(0, 2.5),
                    child: Text(
                      'Get contact exposure alerts and locational\nhotspot alerts directly on your phone.',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyInfo()));
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: mainButton(),
                      child: Center(
                          child: Text('Continue',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15))),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
