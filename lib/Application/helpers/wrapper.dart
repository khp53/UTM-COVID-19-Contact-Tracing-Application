import 'package:flutter/material.dart';
import 'package:utmccta/Application/loginForm.dart';
import 'package:utmccta/Application/registerForm.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool toggleSignIn = true;

  void toggleView() {
    setState(() {
      toggleSignIn = !toggleSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (toggleSignIn) {
      return LogIn(toggle: toggleView);
    } else {
      return RegisterMobileNumber(toggle: toggleView);
    }
  }
}
