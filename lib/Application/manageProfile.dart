import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:utmccta/Application/helpers/WebAppbar.dart';
import 'package:utmccta/BLL/adminHandler.dart';
import 'package:utmccta/BLL/userHandler.dart';
import 'package:utmccta/Application/helpers/helpDesk.dart';
import 'package:utmccta/DLL/userDA.dart';

class ManageProfile extends StatefulWidget {
  @override
  _ManageProfileState createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  UserHandler _userHandler = UserHandler();
  String url = 'https://digital.utm.my/contact/';

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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HelpDesk(url)));
                },
                leading: Icon(
                  Icons.help,
                  color: Colors.white,
                ),
                title: Text(
                  'Help Desk',
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
                  Navigator.pushReplacementNamed(context, '/homepage');
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
  final String email;
  final String address;
  final int postcode;

  const EditProfileMobile({Key key, this.email, this.address, this.postcode})
      : super(key: key);

  @override
  _EditProfileMobileState createState() => _EditProfileMobileState();
}

// edit and update profile after selecting from manage profile screen
class _EditProfileMobileState extends State<EditProfileMobile> {
  UserHandler _userHandler = UserHandler();
  UserDA _userDA = UserDA();

  bool isLoading = false;

  // show user image preview when editing
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  TextEditingController email;
  TextEditingController address;
  TextEditingController postcode;

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    address = TextEditingController();
    postcode = TextEditingController();
    email.text = widget.email;
    address.text = widget.address;
    postcode.text = widget.postcode.toString();
    email.addListener(() {});
    address.addListener(() {});
    postcode.addListener(() {});
  }

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
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder(
                    stream: _userDA.getUserProfile().snapshots(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? Center(
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    NetworkImage(snapshot.data.data()["img"]),
                                child: IconButton(
                                  onPressed: () {
                                    getImage();
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : Center(child: CircularProgressIndicator());
                    }),

                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                //Email Form Field.
                Container(
                  child: TextFormField(
                    controller: email,
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
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                //Current Address Form Field.
                Container(
                  child: TextFormField(
                    controller: address,
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
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                //Postcode Form Field.
                Container(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: postcode,
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
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 25,
                ),
                Container(
                  child: !isLoading
                      ? MaterialButton(
                          elevation: 0,
                          color: Theme.of(context).accentColor,
                          height: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () async {
                            if (_image != null) {
                              setState(() {
                                isLoading = true;
                              });
                              await _userDA.uploadUserImage(_image);
                              final ref = FirebaseStorage.instance
                                  .ref()
                                  .child("user_image")
                                  .child(FirebaseAuth
                                          .instance.currentUser.phoneNumber +
                                      '.jpg');
                              final url = await ref.getDownloadURL();

                              _userHandler.createState().updateProfile(
                                  url, email.text, address.text, postcode.text);
                              setState(() {
                                isLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Profile Update Sucessful')));
                            } else {
                              setState(() {
                                isLoading = false;
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Update Failed')));
                              });
                              print("error");
                            }
                          },
                          child: Center(
                              child: Text('Submit',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15))),
                        )
                      : CircularProgressIndicator(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 25,
                ),
                Container(
                  child: Text(
                      'For security and privacy reasons you cannot change your name or ic/passport number. If you no longer have your phone number you can contact UTM CCTA from our help desk!'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// if the user is admin or UTM health auth then show this
class ManageProfileWebLayout extends StatefulWidget {
  final name;
  final mobileNumber;
  final img;

  const ManageProfileWebLayout({this.name, this.mobileNumber, this.img});
  @override
  _ManageProfileWebLayoutState createState() => _ManageProfileWebLayoutState();
}

class _ManageProfileWebLayoutState extends State<ManageProfileWebLayout> {
  bool isLoading = false;

  TextEditingController name;
  TextEditingController mobileNumber;

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    mobileNumber = TextEditingController();
    name.text = widget.name;
    mobileNumber.text = widget.mobileNumber;
    name.addListener(() {});
    mobileNumber.addListener(() {});
  }

  AdminHandler _adminHandler = AdminHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WebAppBar(
        title: "Update Profile",
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(150),
          child: Column(
            children: [
              //name Form Field.
              Container(
                child: TextFormField(
                  controller: name,
                  style: Theme.of(context).primaryTextTheme.bodyText1,
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
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              //Current phoneno Form Field.
              Container(
                child: TextFormField(
                  controller: mobileNumber,
                  style: Theme.of(context).primaryTextTheme.bodyText1,
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
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              Container(
                child: !isLoading
                    ? MaterialButton(
                        elevation: 0,
                        color: Theme.of(context).accentColor,
                        height: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () async {
                          if (name.text.isNotEmpty &&
                              mobileNumber.text.isNotEmpty) {
                            setState(() {
                              isLoading = true;
                            });

                            _adminHandler
                                .createState()
                                .updateProfile(name.text, mobileNumber.text);
                            setState(() {
                              isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Profile Update Sucessful')));
                          } else {
                            setState(() {
                              isLoading = false;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Update Failed')));
                            });
                            print("error");
                          }
                        },
                        child: Center(
                            child: Text('Submit',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15))),
                      )
                    : CircularProgressIndicator(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 25,
              ),
              Container(
                child: Text(
                    'For security and privacy reasons you cannot change your name or ic/passport number. If you no longer have your phone number you can contact UTM CCTA from our help desk!'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
