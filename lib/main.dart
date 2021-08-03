import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:utmccta/Application/healthStatusForm.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:utmccta/Application/loginForm.dart';
import 'package:utmccta/Application/privacy_info.dart';
import 'package:utmccta/Application/registerForm.dart';
import 'package:utmccta/Application/welcome_screen.dart';
import 'package:utmccta/BLL/dashboardHandler.dart';
import 'Application/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true,
    showBadge: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(UTMCCTA());
}

// This function is used to update the page title
void setPageTitle(String title, BuildContext context) {
  SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
    label: title,
    primaryColor: Theme.of(context).primaryColor.value, // This line is required
  ));
}

class UTMCCTA extends StatefulWidget {
  @override
  _UTMCCTAState createState() => _UTMCCTAState();
}

class _UTMCCTAState extends State<UTMCCTA> {
  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      var initialzationSettingsAndroid = AndroidInitializationSettings(
          '@mipmap/ic_stat_notification_icon_one');
      var initializationSettings =
          InitializationSettings(android: initialzationSettingsAndroid);

      flutterLocalNotificationsPlugin.initialize(initializationSettings);
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  icon: android?.smallIcon,
                  priority: Priority.high,
                  playSound: true,
                  channelShowBadge: true,
                ),
              ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "UTM CCTA",
      debugShowCheckedModeBanner: false,
      home: InfoScreen(),
    );
  }
}

class InfoScreen extends StatefulWidget {
  @override
  InfoScreenState createState() => InfoScreenState();
}

class InfoScreenState extends State<InfoScreen>
    with AfterLayoutMixin<InfoScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      return '/homepage';
    } else {
      await prefs.setBool('seen', true);
      return '/welcome';
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    setPageTitle('UTM CCTA', context);
    return FutureBuilder(
        future: checkFirstSeen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return MaterialApp(
              title: "UTM CCTA",
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                accentColor: Color(0xffB454E7),
                primaryColorDark: Color(0xff5C001E),
                primaryColor: Color(0xff000000),
                primaryColorLight: Color(0xffffffff),
                dialogBackgroundColor: Color(0xff131313),
                primaryTextTheme: TextTheme(
                  bodyText1: TextStyle(color: Colors.black, fontSize: 20),
                  bodyText2: TextStyle(color: Colors.grey, fontSize: 15),
                  headline3: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  subtitle2: TextStyle(color: Colors.black, fontSize: 15),
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
                  headline3:
                      TextStyle(color: Colors.white, fontSize: 15, height: 1.8),
                  headline4: TextStyle(
                      color: Color(0xffB454E7), fontSize: 15, height: 1.8),
                ),
              ),
              initialRoute: snapshot.data,
              routes: {
                '/homepage': (context) => StateMangement(),
                '/welcome': (context) => WelcomeScreen(),
                '/home': (context) => Homepage(),
                '/privacyinfo': (context) => PrivacyInfo(),
                '/register': (context) => RegisterMobileNumber(),
                '/login': (context) => LogIn(),
                '/healthstatusform': (context) => HealthStatusForm(),
              },
            );
          }
        });
  }
}

class StateMangement extends StatefulWidget {
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
            if (kIsWeb) {
              return DashboardHandler();
            } else {
              return Homepage();
            }
          }
          return LogIn();
        });
  }
}
