import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:utmccta/DLL/userDA.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:utmccta/main.dart';

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
  String _emptyError = '';
  bool codeSent = false;
  bool _enabled = true;
  bool _visibility = false;

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  AuthCredential authCreds;

  UserDA _userDA = UserDA();

  Future<void> verifyPhone(phoneNo) async {
    if (formKey.currentState.validate()) {
      final PhoneVerificationCompleted verified = (AuthCredential authResult) {
        _userDA.signIn(authResult);
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
  }

  signInUser() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = false;
      });

      authCreds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: _otpController.text.trim());

      final UserCredential authResult = await FirebaseAuth.instance
          .signInWithCredential(authCreds)
          .catchError((onError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('OTP not valid')));
        print('SignIn Error: ${onError.toString()}\n\n');
      });

      if (authResult != null) {
        if (this.mounted) {
          //checks if widget is still active and not disposed
          setState(() {
            isLoading = true;
          });
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Homepage(),
            ),
            (route) => false,
          );
        }
      } else {
        setState(() {
          isLoading = true;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Log In Failed')));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 130), () {
      //asynchronous delay
      if (this.mounted) {
        //checks if widget is still active and not disposed
        setState(() {
          //tells the widget builder to rebuild again because ui has updated
          _visibility =
              true; // set the visibility to true after otp runout seconds
        });
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _phoneNumberController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return codeSent ? otpForm() : phoneNumberForm();
  }

  Widget phoneNumberForm() {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
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
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          return value.isEmpty
                              ? "Please Enter a Valid Phone Number"
                              : null;
                        },
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
                            hintStyle: Theme.of(context).textTheme.bodyText2),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 55,
                    ),
                    Container(
                      child: Text(_emptyError),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 65,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 2),
                      child: !isLoading
                          ? TextButton(
                              onPressed: () {
                                if (_phoneNumberController.text.isNotEmpty) {
                                  setState(() {
                                    isLoading = true;
                                    _enabled = !_enabled;
                                  });

                                  verifyPhone(_phoneNumberController.text);
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  _emptyError =
                                      'Please Enter a Valid Phone Number';
                                }
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: mainButton(),
                                child: Center(
                                    child: Text('Verify',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15))),
                              ),
                            )
                          : CircularProgressIndicator(),
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

  Widget otpForm() {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: !isLoading
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
                          Column(children: [
                            Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Enter the OTP sent to ${_phoneNumberController.text}',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 60,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                controller: _otpController,
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
                                    hintStyle:
                                        Theme.of(context).textTheme.bodyText2),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 70,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Text(
                                      "Did not receive OTP yet?",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 3.5, 0, 0),
                                      child: ArgonTimerButton(
                                        initialTimer: 120, // Optional
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        minWidth:
                                            MediaQuery.of(context).size.width *
                                                0.30,
                                        color: Colors.transparent,
                                        borderRadius: 0.0,
                                        child: Text(
                                          "Resend OTP",
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
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
                                          if (btnState == ButtonState.Idle) {
                                            startTimer(120);
                                          }
                                          verifyPhone(
                                              _phoneNumberController.text);
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 4),
                                      child: Visibility(
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.pushReplacementNamed(
                                                context, StateMangement().id);
                                          },
                                          child: Text(
                                            "Edit Number",
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        visible: _visibility,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ]),
                          Container(
                            padding: EdgeInsets.only(right: 2),
                            child: TextButton(
                              onPressed: () {
                                signInUser();
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: mainButton(),
                                child: Center(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          )
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
