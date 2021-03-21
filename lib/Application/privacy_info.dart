import 'package:flutter/material.dart';
import 'package:utmccta/Application/helpers/main_button.dart';

class PrivacyInfo extends StatelessWidget {
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
                      style: Theme.of(context).textTheme.bodyText2,
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
                      style: Theme.of(context).textTheme.bodyText2,
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
                  padding: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
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
