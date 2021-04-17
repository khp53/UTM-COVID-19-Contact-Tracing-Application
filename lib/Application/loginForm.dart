import 'package:flutter/material.dart';
import 'package:utmccta/Application/dashboard.dart';
import 'package:utmccta/Application/registerForm.dart';
import 'package:utmccta/BLL/dashboardHandler.dart';
import 'package:utmccta/DLL/userDA.dart';
import 'package:utmccta/DLL/adminDA.dart';
import 'helpers/main_button.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 800) {
        return WebLoginLayout();
      } else {
        return RegisterMobileNumber();
      }
    });
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
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => DashboardHandler()));
        } else {
          setState(() {
            isLoading = false;
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
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
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width / 4,
                      MediaQuery.of(context).size.height / 12,
                      MediaQuery.of(context).size.width / 4,
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
                            style: Theme.of(context).primaryTextTheme.headline1,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 15,
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
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Colors.black54,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Email",
                                  hintStyle: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText2),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 35,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              validator: (val) {
                                return val.length > 6
                                    ? null
                                    : "Password should be 6+ chars";
                              },
                              controller: passwordTextEditingController,
                              obscureText: showPassword,
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1,
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          showPassword = !showPassword;
                                        });
                                      },
                                      child: Icon(Icons.toggle_off)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Colors.black54,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Password",
                                  hintStyle: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText2),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 25,
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 2),
                            child: TextButton(
                              onPressed: () {
                                adminLogin();
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: mainButton(),
                                child: Center(
                                    child: Text('Log in',
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
