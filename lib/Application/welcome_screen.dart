import 'package:flutter/material.dart';
import 'package:utmccta/Application/helpers/main_button.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return WebWelcomeLayout();
      } else {
        return MobileWelcomeLayout();
      }
    });
  }
}

class MobileWelcomeLayout extends StatelessWidget {
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
                      style: Theme.of(context).textTheme.subtitle1,
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
                      style: Theme.of(context).textTheme.subtitle1,
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
                      style: Theme.of(context).textTheme.subtitle1,
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
                  padding: const EdgeInsets.only(top: 40),
                  child: MaterialButton(
                    elevation: 0,
                    color: Theme.of(context).accentColor,
                    //height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/privacyinfo');
                    },
                    child: Center(
                        child: Text('Continue',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15))),
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

class WebWelcomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        body: Container(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width / 4,
              0,
              MediaQuery.of(context).size.width / 4,
              MediaQuery.of(context).size.height / 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    'Welcome to\nUTM COVID-19 Contact\nTracing Application',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).primaryTextTheme.headline1,
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
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    ),
                  ),
                  subtitle: Transform.translate(
                    offset: Offset(0, 2.5),
                    child: Text(
                      'Real-Time contact tracing using device\'s\nBluetooth and GPS.',
                      style: Theme.of(context).primaryTextTheme.subtitle1,
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
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    ),
                  ),
                  subtitle: Transform.translate(
                    offset: Offset(0, 2.5),
                    child: Text(
                      'Enter your visited location when ever you\nwant. Your privacy is at your hand.',
                      style: Theme.of(context).primaryTextTheme.subtitle1,
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
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    ),
                  ),
                  subtitle: Transform.translate(
                    offset: Offset(0, 2.5),
                    child: Text(
                      'Get contact exposure alerts and locational\nhotspot alerts directly on your phone.',
                      style: Theme.of(context).primaryTextTheme.subtitle1,
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
                  padding: const EdgeInsets.only(top: 40),
                  child: MaterialButton(
                    elevation: 0,
                    color: Theme.of(context).accentColor,
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/privacyinfo');
                    },
                    child: Center(
                        child: Text('Continue',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15))),
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
