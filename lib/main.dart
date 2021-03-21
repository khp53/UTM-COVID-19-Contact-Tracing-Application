import 'package:flutter/material.dart';
import 'package:utmccta/Application/welcome_screen.dart';
import 'Application/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(UTMCCTA());
}

class UTMCCTA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InfoScreen(),
    );
  }
}

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      return Homepage().id;
    } else {
      await prefs.setBool('seen', true);
      return WelcomeScreen().id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkFirstSeen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                accentColor: Color(0xffB454E7),
                primaryColor: Color(0xff000000),
                textTheme: TextTheme(
                  bodyText1: TextStyle(color: Colors.white, fontSize: 15),
                  bodyText2: TextStyle(
                      color: Color(0xff8F8F8F), fontSize: 12, height: 1.5),
                  headline1: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      height: 1.5),
                ),
              ),
              initialRoute: snapshot.data,
              routes: {
                WelcomeScreen().id: (context) => WelcomeScreen(),
                Homepage().id: (context) => Homepage(),
              },
            );
          }
        });
  }
}
