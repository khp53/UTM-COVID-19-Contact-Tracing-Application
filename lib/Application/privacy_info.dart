import 'package:flutter/material.dart';
import 'package:utmccta/Application/helpers/main_button.dart';

class PrivacyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return WebPrivacyLayout();
      } else {
        return MobilePrivacyLayout();
      }
    });
  }
}

class MobilePrivacyLayout extends StatelessWidget {
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
                    'Your\nData is Protected',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Icon(
                    Icons.enhanced_encryption,
                    color: Theme.of(context).accentColor,
                    size: 32,
                  ),
                  title: Transform.translate(
                    offset: Offset(0, -2.5),
                    child: Text(
                      'End-to-End Encryption',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  subtitle: Transform.translate(
                    offset: Offset(0, 2.5),
                    child: Text(
                      'Data exchage between two device is protected\nby end-to-end encryption.',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Icon(
                    Icons.vpn_key,
                    color: Theme.of(context).accentColor,
                    size: 32,
                  ),
                  title: Transform.translate(
                    offset: Offset(0, -2.5),
                    child: Text(
                      'Restricted Access',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  subtitle: Transform.translate(
                    offset: Offset(0, 2.5),
                    child: Text(
                      'Your data will only be accessed by UTM admin\nand UTM Health Professionals, if you are\ntested positive by COVID-19.',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
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
                      Navigator.pushReplacementNamed(context, '/login');
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

class WebPrivacyLayout extends StatelessWidget {
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
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    'Your\nData is Protected',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).primaryTextTheme.headline1,
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Icon(
                    Icons.enhanced_encryption,
                    color: Theme.of(context).accentColor,
                    size: 32,
                  ),
                  title: Transform.translate(
                    offset: Offset(0, -2.5),
                    child: Text(
                      'End-to-End Encryption',
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    ),
                  ),
                  subtitle: Transform.translate(
                    offset: Offset(0, 2.5),
                    child: Text(
                      'Data exchage between two device is protected\nby end-to-end encryption.',
                      style: Theme.of(context).primaryTextTheme.subtitle1,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Icon(
                    Icons.vpn_key,
                    color: Theme.of(context).accentColor,
                    size: 32,
                  ),
                  title: Transform.translate(
                    offset: Offset(0, -2.5),
                    child: Text(
                      'Restricted Access',
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    ),
                  ),
                  subtitle: Transform.translate(
                    offset: Offset(0, 2.5),
                    child: Text(
                      'Your data will only be accessed by UTM admin\nand UTM Health Professionals, if you are\ntested positive by COVID-19.',
                      style: Theme.of(context).primaryTextTheme.subtitle1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
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
                      Navigator.pushReplacementNamed(context, '/login');
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
