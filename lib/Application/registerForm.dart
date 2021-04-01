import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'helpers/main_button.dart';
import 'homepage.dart';

class RegisterMobileNumber extends StatefulWidget {
  final Function toggle;

  const RegisterMobileNumber({Key key, this.toggle}) : super(key: key);
  @override
  _RegisterMobileNumberState createState() => _RegisterMobileNumberState();
}

class _RegisterMobileNumberState extends State<RegisterMobileNumber> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  String _verificationId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height / 12, 20, 20),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 74,
                    height: 74,
                    child: Image(
                      image: AssetImage('assets/img/logo.png'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'LogIn / Register',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            enabled: false,
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: InputDecoration(
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Colors.white70,
                                  ),
                                ),
                                hintText: "MY(+60)",
                                hintStyle:
                                    Theme.of(context).textTheme.bodyText2),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 40),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: _phoneNumberController,
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Colors.white70,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                hintText: "Mobile Number",
                                hintStyle:
                                    Theme.of(context).textTheme.bodyText2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 25,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 2),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OTPVerification()));
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: mainButton(),
                        child: Center(
                            child: Text('Login/Register',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static SmsAutoFill() {}
}

class OTPVerification extends StatefulWidget {
  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height / 12, 20, 20),
            child: Column(
              children: [
                SizedBox(
                  width: 74,
                  height: 74,
                  child: Image(
                    image: AssetImage('assets/img/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Register',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'OTP Verification',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 60,
                ),
                Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter the OTP sent to your registered number.',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 60,
                ),
                Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Expanded(
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.white70,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          hintText: "OTP",
                          hintStyle: Theme.of(context).textTheme.bodyText2),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 60,
                ),
                Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Did not receive OTP yet? ",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        "Resent OTP",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Container(
                  padding: EdgeInsets.only(right: 2),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PasswordForm()));
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: mainButton(),
                      child: Center(
                          child: Text('Submit',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordForm extends StatefulWidget {
  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height / 12, 20, 20),
            child: Column(
              children: [
                SizedBox(
                  width: 74,
                  height: 74,
                  child: Image(
                    image: AssetImage('assets/img/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Register',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter Password',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 60,
                ),
                Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter a secured password. The password must have uppercase, lowercase and any number.',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 60,
                ),
                Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Expanded(
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.white70,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          hintText: "Password",
                          hintStyle: Theme.of(context).textTheme.bodyText2),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Container(
                  padding: EdgeInsets.only(right: 2),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Homepage().id);
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: mainButton(),
                      child: Center(
                          child: Text('Register',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
