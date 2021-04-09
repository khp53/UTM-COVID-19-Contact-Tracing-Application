import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:utmccta/Application/healthStatusForm.dart';
import 'package:utmccta/BLL/userHandler.dart';
import 'package:utmccta/BLL/users.dart';
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
  //Users _users = Users();

  Users _userFromFirebaseUser(User user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  Future<void> verifyPhone(phoneNo) async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
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
      setState(() {
        isLoading = true;
      });
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
          User user = authResult.user;
          _userFromFirebaseUser(user);

          if (authResult.additionalUserInfo.isNewUser) {
            return Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => RegisterUserData(),
              ),
              (route) => false,
            );
          } else {
            return Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => RegisterUserData(),
              ),
              (route) => false,
            );
          }
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
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 2),
                      child: !isLoading
                          ? TextButton(
                              onPressed: () {
                                verifyPhone(_phoneNumberController.text);
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
                          : Container(
                              padding: EdgeInsets.only(top: 5),
                              child: CircularProgressIndicator()),
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

//Complete registration after mobile number has been authenticated and user id has been created

class RegisterUserData extends StatefulWidget {
  @override
  _RegisterUserDataState createState() => _RegisterUserDataState();
}

class _RegisterUserDataState extends State<RegisterUserData> {
  final formKey = new GlobalKey<FormState>();
  bool isLoading = false;

  // Define the text controllers to capture user data
  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _icNoController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _currentAddressController =
      TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();

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
                      'Register',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 15,
                    ),
                    Container(
                      child: Text(
                        'Please complete your registration by providing us your information.\nThis information will only be accesed by an UTM admin\nIf you are tested positive with COVID-19.',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 45,
                    ),
                    //userID or Matric number Form Field.
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: TextFormField(
                        controller: _userIDController,
                        validator: (value) {
                          return value.isEmpty
                              ? "Please Enter a valid matric number!"
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
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintText: "Matric Number (i.e: A20XX4123)",
                            hintStyle: Theme.of(context).textTheme.bodyText2),
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height / 65,
                    ),
                    //IC number or Passport Number Form Field.
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: TextFormField(
                        controller: _userIDController,
                        validator: (value) {
                          return value.isEmpty
                              ? "Please Enter a valid IC or Passport No.!"
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
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintText: "IC/Passport Number",
                            hintStyle: Theme.of(context).textTheme.bodyText2),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 65,
                    ),
                    //Full name Form Field.
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          return value.isEmpty
                              ? "Please Enter your name!"
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
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintText: "Full Name",
                            hintStyle: Theme.of(context).textTheme.bodyText2),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 65,
                    ),
                    //Email Form Field.
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)
                              ? null
                              : "Provide a valid email";
                        },
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
                            hintText: "Email Address",
                            hintStyle: Theme.of(context).textTheme.bodyText2),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 65,
                    ),
                    //Current Address Form Field.
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: TextFormField(
                        controller: _currentAddressController,
                        validator: (value) {
                          return value.isEmpty
                              ? "Please Enter your full address!"
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
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintText: "Full Address",
                            hintStyle: Theme.of(context).textTheme.bodyText2),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 65,
                    ),
                    //Postcode Form Field.
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: TextFormField(
                        controller: _postCodeController,
                        validator: (value) {
                          return value.isEmpty
                              ? "Please Enter your area postcode!"
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
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintText: "Postcode",
                            hintStyle: Theme.of(context).textTheme.bodyText2),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 75,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(right: 2),
          child: !isLoading
              ? TextButton(
                  onPressed: () {},
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: mainButton(),
                    child: Center(
                        child: Text('Submit',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15))),
                  ),
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
