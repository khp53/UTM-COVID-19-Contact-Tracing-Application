import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:utmccta/DLL/userDA.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';

import 'helpers/main_button.dart';
import 'homepage.dart';

class RegisterMobileNumber extends StatefulWidget {
  @override
  _RegisterMobileNumberState createState() => _RegisterMobileNumberState();
}

class _RegisterMobileNumberState extends State<RegisterMobileNumber> {
  final formKey = new GlobalKey<FormState>();
  bool isLoading = false;
  String verificationId;
  bool codeSent = false;
  bool _enabled = true;

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  AuthCredential authCreds;

  UserDA _userDA = UserDA();

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      setState(() {
        isLoading = false;
      });
      _userDA.signIn(authResult).then((res) async {
        if (res != null) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, Homepage().id);
        }
      }).catchError((e) {
        FocusScope.of(context).unfocus();
        setState(() {
          isLoading = true;
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.black45,
                  title: Text(
                    "Oops!",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  content: Text(
                    "Something went wrong please try again!",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  actions: [
                    TextButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              });
        });
      });
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      setState(() {
        print('Error message:' + authException.message);
      });
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  signInUser() async {
    authCreds = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: _otpController.text);
    setState(() {
      isLoading = true;
    });
    await _userDA.signIn(authCreds).then((res) async {
      if (res != null) {
        Navigator.pushReplacementNamed(context, Homepage().id);
      } else {
        if (this.mounted) {
          setState(() {
            isLoading = false;
            FocusScope.of(context).unfocus();
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Color(0xff171717),
                    title: Text(
                      "Oops!",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    content: Text(
                      "Something went wrong please try again!",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    actions: [
                      TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                });
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: isLoading
            ? Container(child: Center(child: CircularProgressIndicator()))
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      20, MediaQuery.of(context).size.height / 12, 20, 20),
                  child: Center(
                    child: Form(
                      key: formKey,
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
                            child: TextFormField(
                              enabled: _enabled,
                              controller: _phoneNumberController,
                              style: Theme.of(context).textTheme.bodyText1,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Colors.white70,
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  hintText: "Phone Number (ie: +60XXXXXXXXXX)",
                                  hintStyle:
                                      Theme.of(context).textTheme.bodyText2),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 25,
                          ),
                          codeSent
                              ? Column(children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Enter the OTP sent to ${_phoneNumberController.text}',
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 60,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    child: TextFormField(
                                      controller: _otpController,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              color: Colors.white70,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          hintText: "OTP",
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 60,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Did not receive OTP yet?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 4, 0, 0),
                                          child: ArgonTimerButton(
                                            initialTimer: 60, // Optional
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.50,
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.30,
                                            color: Colors.transparent,
                                            borderRadius: 0.0,
                                            child: Text(
                                              "Resend OTP",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                            loader: (timeLeft) {
                                              return Text(
                                                "Wait | $timeLeft",
                                                style: TextStyle(
                                                  color: Color(0xff8F8F8F),
                                                  fontSize: 12,
                                                ),
                                              );
                                            },
                                            onTap: (startTimer, btnState) {
                                              if (btnState ==
                                                  ButtonState.Idle) {
                                                startTimer(20);
                                              }
                                              verifyPhone(
                                                  _phoneNumberController.text);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ])
                              : Container(),
                          Container(
                            padding: EdgeInsets.only(right: 2),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  isLoading = false;
                                  _enabled = !_enabled;
                                });

                                codeSent
                                    ? signInUser()
                                    : verifyPhone(_phoneNumberController.text);
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: mainButton(),
                                child: Center(
                                    child: codeSent
                                        ? Text('Login',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15))
                                        : Text('Verify',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
