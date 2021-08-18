import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:utmccta/Application/healthStatusForm.dart';
import 'package:utmccta/Application/homepage.dart';
import 'package:utmccta/BLL/userHandler.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'helpers/main_button.dart';

class RegisterMobileNumber extends StatefulWidget {
  @override
  _RegisterMobileNumberState createState() => _RegisterMobileNumberState();
}

class _RegisterMobileNumberState extends State<RegisterMobileNumber> {
  // form key for text fields
  final formKey = new GlobalKey<FormState>();

  // loading status
  bool isLoading = false;
  String verificationId;
  bool codeSent = false;
  String _otp = '';

  // visibility status toggle of edit number button
  bool _visibility = false;

  //text field controller
  TextEditingController _phoneNumberController = TextEditingController();
  //TextEditingController _otpController = TextEditingController();

  AuthCredential authCreds;

  Future<void> verifyPhone(phoneNo) async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = false;
      });
      final PhoneVerificationCompleted verified =
          (AuthCredential authResult) async {
        final UserCredential authRes = await FirebaseAuth.instance
            .signInWithCredential(authResult)
            .catchError((onError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('OTP not valid')));
          print('SignIn Error: ${onError.toString()}\n\n');
        });

        if (authRes != null) {
          if (this.mounted) {
            //checks if widget is still active and not disposed
            setState(() {
              isLoading = true;
            });
            if (authRes.additionalUserInfo.isNewUser) {
              return Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => RegisterUserData(
                    phoneNo: phoneNo,
                  ),
                ),
                (route) => false,
              );
            } else {
              return Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Homepage(),
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

  signInUser(phoneNo) async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = false;
      });

      authCreds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: _otp.trim());

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

          if (authResult.additionalUserInfo.isNewUser) {
            return Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => RegisterUserData(
                  phoneNo: phoneNo,
                ),
              ),
              (route) => false,
            );
          } else {
            return Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => Homepage(),
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
                    _buildPhoneNumberFormFIeld(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    !isLoading
                        ? MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            height: 50,
                            elevation: 0,
                            color: Theme.of(context).accentColor,
                            onPressed: () {
                              verifyPhone('+60${_phoneNumberController.text}');
                            },
                            child: Center(
                                child: Text('Verify',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15))),
                          )
                        : Container(
                            padding: EdgeInsets.only(top: 5),
                            child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _buildPhoneNumberFormFIeld() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            readOnly: true,
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
              hintText: "+60",
              hintStyle: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 5,
          child: TextFormField(
            controller: _phoneNumberController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            validator: (value) {
              return value.isEmpty || value.length < 10
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
              labelText: "Phone Number (ie: 1123456789)",
              labelStyle: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ),
      ],
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
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Enter the OTP sent to +60${_phoneNumberController.text}',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 60,
                            ),
                            _otpPinCodeTextField(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 80,
                            ),
                            Container(
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
                                        initialTimer: 120,
                                        // Optional
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
                                                context, '/authManagement');
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
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            height: 50,
                            elevation: 0,
                            color: Theme.of(context).accentColor,
                            onPressed: () {
                              signInUser(_phoneNumberController.text);
                            },
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
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

  PinCodeTextField _otpPinCodeTextField() {
    return PinCodeTextField(
      keyboardType: TextInputType.number,
      textStyle: Theme.of(context).primaryTextTheme.bodyText1,
      appContext: context,
      length: 6,
      obscureText: true,
      obscuringCharacter: '•',
      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      validator: (v) {
        if (v.length < 6) {
          return "Please Enter The Correct OTP";
        } else {
          return null;
        }
      },
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.white,
          inactiveColor: Colors.white,
          inactiveFillColor: Colors.transparent,
          selectedFillColor: Colors.white,
          selectedColor: Theme.of(context).accentColor),
      cursorColor: Colors.black,
      animationDuration: Duration(milliseconds: 300),
      enableActiveFill: true,
      onChanged: (String val) {
        setState(() {
          _otp = val;
        });
      },
      beforeTextPaste: (text) {
        return false;
      },
    );
  }
}

//Complete registration after mobile number has been authenticated and user id has been created

class RegisterUserData extends StatefulWidget {
  final String phoneNo;

  //constructor
  const RegisterUserData({Key key, this.phoneNo}) : super(key: key);

  @override
  _RegisterUserDataState createState() => _RegisterUserDataState();
}

class _RegisterUserDataState extends State<RegisterUserData> {
  final formKey = new GlobalKey<FormState>();
  bool isLoading = false;

  UserHandler _userHandler = UserHandler();

  // Define the text controllers to capture user data
  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _icNoController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _currentAddressController =
      TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();

  registerUserData() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = false;
      });

      _userHandler.registerUserDataHandler(
          _userIDController.text,
          _icNoController.text,
          _nameController.text,
          widget.phoneNo,
          _emailController.text,
          _currentAddressController.text,
          _postCodeController.text);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => HealthStatusForm()),
        (route) => false,
      );
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: !isLoading
            ? SingleChildScrollView(
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
                              'Please complete your registration by providing us your information. This information will only be accesed by an UTM admin, if you are tested positive with COVID-19.',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 35,
                          ),
                          //userID or Matric number Form Field.
                          Container(
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
                                  labelText: "Matric Number (i.e: A20XX4123)",
                                  labelStyle:
                                      Theme.of(context).textTheme.bodyText2),
                            ),
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          //IC number or Passport Number Form Field.
                          Container(
                            child: TextFormField(
                              controller: _icNoController,
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
                                  labelText: "IC/Passport Number",
                                  labelStyle:
                                      Theme.of(context).textTheme.bodyText2),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          //Full name Form Field.
                          Container(
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
                                  labelText: "Full Name",
                                  labelStyle:
                                      Theme.of(context).textTheme.bodyText2),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          //Email Form Field.
                          Container(
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
                                  labelText: "Email Address",
                                  labelStyle:
                                      Theme.of(context).textTheme.bodyText2),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          //Current Address Form Field.
                          Container(
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
                                  labelText: "Full Address",
                                  labelStyle:
                                      Theme.of(context).textTheme.bodyText2),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          //Postcode Form Field.
                          Container(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
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
                                  labelText: "Postcode",
                                  labelStyle:
                                      Theme.of(context).textTheme.bodyText2),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 55,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()),
        bottomNavigationBar: Container(
            child: TextButton(
          onPressed: () {
            registerUserData();
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: mainButton(),
            child: Center(
                child: Text('Submit',
                    style: TextStyle(color: Colors.white, fontSize: 15))),
          ),
        )),
      ),
    );
  }
}
