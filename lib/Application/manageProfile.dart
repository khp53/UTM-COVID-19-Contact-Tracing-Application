import 'package:flutter/material.dart';
import 'package:utmccta/BLL/userHandler.dart';
import 'package:utmccta/DLL/userDA.dart';
import 'package:utmccta/main.dart';

class ManageProfile extends StatefulWidget {
  @override
  _ManageProfileState createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  UserHandler _userHandler = UserHandler();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            _userHandler.createState().profileList(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 45,
            ),
            _userHandler.createState().profileCard(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: ListTile(
                tileColor: Color(0xff131313),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditProfileMobile()));
                },
                leading: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                title: Text(
                  'Edit Profile',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 55,
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: ListTile(
                tileColor: Color(0xff131313),
                onTap: () {},
                leading: Icon(
                  Icons.privacy_tip,
                  color: Colors.white,
                ),
                title: Text(
                  'Privacy Policy',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 55,
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: ListTile(
                tileColor: Color(0xff131313),
                onTap: () {
                  _userHandler.userSignOut();
                  Navigator.pushReplacementNamed(context, '/authManagement');
                },
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                title: Text(
                  'Log Out',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 55,
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfileMobile extends StatefulWidget {
  @override
  _EditProfileMobileState createState() => _EditProfileMobileState();
}

// edit and update profile after selecting from manage profile screen
class _EditProfileMobileState extends State<EditProfileMobile> {
  UserHandler _userHandler = UserHandler();
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
          appBar: AppBar(
            title: Text(
              'Edit Profile',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _userHandler.createState().showImagePreview(),
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
                        hintText: "IC/Passport Number",
                        hintStyle: Theme.of(context).textTheme.bodyText2),
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
                      return value.isEmpty ? "Please Enter your name!" : null;
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
                        hintText: "Email Address",
                        hintStyle: Theme.of(context).textTheme.bodyText2),
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
                        hintText: "Full Address",
                        hintStyle: Theme.of(context).textTheme.bodyText2),
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
                        hintText: "Postcode",
                        hintStyle: Theme.of(context).textTheme.bodyText2),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 55,
                ),
              ],
            ),
          )),
    );
  }
}

// if the user is admin or UTM health auth then show this
class ManageProfileWebLayout extends StatefulWidget {
  @override
  _ManageProfileWebLayoutState createState() => _ManageProfileWebLayoutState();
}

class _ManageProfileWebLayoutState extends State<ManageProfileWebLayout> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
