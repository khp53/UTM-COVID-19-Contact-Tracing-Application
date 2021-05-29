import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FirebaseCloudMessagingConsole extends StatefulWidget {
  @override
  _FirebaseCloudMessagingConsoleState createState() =>
      _FirebaseCloudMessagingConsoleState();
}

class _FirebaseCloudMessagingConsoleState
    extends State<FirebaseCloudMessagingConsole> {
  launchHelpDesk() async {
    const url =
        'https://console.firebase.google.com/u/0/project/utm-covid19-contact-tracing/notification';
    if (await canLaunch(url)) {
      await launch(url, enableJavaScript: true, forceWebView: true);
    } else {
      throw 'Could not reach to $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(25),
      child: Column(
        children: [
          Image.asset('assets/img/notificationHelp.jpg'),
          SizedBox(
            height: 40,
          ),
          Text(
            'Press The Button Below To Send Locational HotSpot Alerts\nTo All The Users Using UTM CCTA Application!',
            textAlign: TextAlign.center,
            style: Theme.of(context).primaryTextTheme.headline1,
          ),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width / 4,
            child: MaterialButton(
              color: Theme.of(context).accentColor,
              child: Text(
                'Send HotSpot Alert!',
                style: Theme.of(context).primaryTextTheme.headline2,
              ),
              onPressed: () {
                launchHelpDesk();
              },
            ),
          )
        ],
      ),
    ));
  }
}
