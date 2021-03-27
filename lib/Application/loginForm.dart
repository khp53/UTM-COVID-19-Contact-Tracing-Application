import 'package:flutter/material.dart';
import 'package:utmccta/Application/homepage.dart';

import 'helpers/main_button.dart';

class LogIn extends StatefulWidget {
  final Function toggle;

  const LogIn({Key key, this.toggle}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
                    'Log in',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
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
                          hintText: "Mobile Number",
                          hintStyle: Theme.of(context).textTheme.bodyText2),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 35,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 25,
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
                            child: Text('Log in',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            widget.toggle();
                          },
                          child: Text(
                            "Register ",
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Text(
                          "If you are a new user.",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 15,
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
    );
  }
}
