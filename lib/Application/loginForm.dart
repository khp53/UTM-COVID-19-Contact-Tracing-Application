import 'package:flutter/material.dart';
import 'package:utmccta/Application/registerForm.dart';
import 'package:utmccta/BLL/dashboardHandler.dart';
import 'package:utmccta/DLL/adminDA.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return WebLoginLayout();
    } else {
      return RegisterMobileNumber();
    }
  }
}

class WebLoginLayout extends StatefulWidget {
  @override
  _WebLoginLayoutState createState() => _WebLoginLayoutState();
}

class _WebLoginLayoutState extends State<WebLoginLayout> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool showPassword = true;

  AdminDA _adminDA = AdminDA();

  adminLogin() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      await _adminDA
          .signInWithEmailandPasswordAdmin(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((result) async {
        if (result != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => DashboardHandler()),
              (route) => false);
        } else {
          setState(() {
            isLoading = false;
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Theme(
                    data: ThemeData(
                        dialogTheme:
                            DialogTheme(backgroundColor: Colors.white)),
                    child: AlertDialog(
                      title: Text(
                        "Oops!",
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                      content: Text(
                        "Invalid Email or Password! Enter correct Email & Password and try again!",
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                      actions: [
                        TextButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  );
                });
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        body: isLoading
            ? Container(child: Center(child: CircularProgressIndicator()))
            : SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Stack(
                        children: [
                          Container(
                            color: Theme.of(context).primaryColorDark,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Image(
                              image: AssetImage('assets/img/homeMainImage.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 30),
                            child: Center(
                              child: Text(
                                'UTM COVID-19 Contact Tracing System',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width / 20,
                            MediaQuery.of(context).size.height / 15,
                            MediaQuery.of(context).size.width / 20,
                            20),
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
                                  'Log in',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline1,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 15,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: TextFormField(
                                    validator: (val) {
                                      return RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(val)
                                          ? null
                                          : "Provide a valid email";
                                    },
                                    textInputAction: TextInputAction.done,
                                    controller: emailTextEditingController,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                            color: Colors.black54,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                        labelText: "Email",
                                        labelStyle: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText2),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 35,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: TextFormField(
                                    onEditingComplete: () => adminLogin(),
                                    textInputAction: TextInputAction.send,
                                    validator: (val) {
                                      return val.length > 6
                                          ? null
                                          : "Password should be 6+ chars";
                                    },
                                    controller: passwordTextEditingController,
                                    obscureText: showPassword,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1,
                                    decoration: InputDecoration(
                                        suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                showPassword = !showPassword;
                                              });
                                            },
                                            child: showPassword
                                                ? Icon(Icons.visibility_off)
                                                : Icon(Icons.visibility)),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                            color: Colors.black54,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                        labelText: "Password",
                                        labelStyle: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText2),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 25,
                                ),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  elevation: 0,
                                  color: Theme.of(context).accentColor,
                                  height: 70,
                                  onPressed: () {
                                    adminLogin();
                                  },
                                  child: Center(
                                      child: Text('Log in',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15))),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
