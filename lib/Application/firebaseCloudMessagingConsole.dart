import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utmccta/Application/helpers/adminAppbar.dart';
import 'package:utmccta/Application/helpers/sidenav.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
        body: Center(
      child: Text(
        'Firebase Cloud Messegaing Colsole Should Open in a New Tab\nIf redirecting is unsuccessfull click the button below',
        style: Theme.of(context).primaryTextTheme.headline1,
      ),
    ));
  }
}
