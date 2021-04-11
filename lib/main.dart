import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:utmccta/Application/healthStatusForm.dart';
import 'package:utmccta/Application/loginform.dart';
import 'package:utmccta/Application/privacy_info.dart';
import 'package:utmccta/Application/registerForm.dart';
import 'package:utmccta/Application/welcome_screen.dart';
import 'package:utmccta/BLL/dashboardHandler.dart';

import 'Application/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      return StateMangement().id;
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
                primaryColorLight: Color(0xffffffff),
                primaryTextTheme: TextTheme(
                  bodyText1: TextStyle(color: Colors.black, fontSize: 15),
                  bodyText2: TextStyle(color: Colors.grey, fontSize: 15),
                  subtitle1:
                      TextStyle(color: Colors.grey, fontSize: 12, height: 1.5),
                  headline1: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      height: 1.5),
                  headline2: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 1.5),
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(color: Colors.white, fontSize: 15),
                  bodyText2: TextStyle(color: Colors.white54, fontSize: 15),
                  subtitle1: TextStyle(
                      color: Color(0xff8F8F8F), fontSize: 12, height: 1.5),
                  headline1: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      height: 1.5),
                  headline2: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 1.5),
                ),
              ),
              initialRoute: snapshot.data,
              routes: {
                StateMangement().id: (context) => StateMangement(),
                WelcomeScreen().id: (context) => WelcomeScreen(),
                Homepage().id: (context) => Homepage(),
                '/privacyinfo': (context) => PrivacyInfo(),
                '/register': (context) => RegisterMobileNumber(),
                '/login': (context) => LogIn(),
                '/healthststusform': (context) => HealthStatusForm()
              },
            );
          }
        });
  }
}

class StateMangement extends StatefulWidget {
  final String id = 'statemanagement';
  @override
  _StateMangementState createState() => _StateMangementState();
}

class _StateMangementState extends State<StateMangement> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data is User && snapshot.data != null) {
            return DashboardHandler();
          }
          return HealthStatusForm();
        });
  }
}
