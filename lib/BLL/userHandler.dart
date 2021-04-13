import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:utmccta/Application/manageProfile.dart';
import 'package:utmccta/DLL/userDA.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserHandler extends StatefulWidget {
  UserDA _userDA = UserDA();
  //user data handler
  registerUserDataHandler(
      userID, icNo, name, mobileNumber, email, address, postcode) {
    Map<String, dynamic> userInfoMap = {
      "img":
          "https://firebasestorage.googleapis.com/v0/b/utm-covid19-contact-tracing.appspot.com/o/default.png?alt=media&token=45b19e89-019b-4eac-8f1c-aaf0f2b715e0",
      "userID": userID,
      "icNo": icNo,
      "name": name,
      "mobileNumber": mobileNumber,
      "email": email,
      "address": address,
      "postcode": int.parse(postcode)
    };
    _userDA.uploadUserInfo(userInfoMap);
  }

  // signOut The user
  userSignOut() {
    return _userDA.signOutUser();
  }

  @override
  _UserHandlerState createState() => _UserHandlerState();
}

class _UserHandlerState extends State<UserHandler> {
  UserDA _userDA = UserDA();
  // show name and risk status at the top of manage profile page
  Widget profileList() {
    return StreamBuilder(
        stream: _userDA.getUserProfile().snapshots(),
        builder: (context, snapshot1) {
          return snapshot1.hasData
              ? StreamBuilder(
                  stream: _userDA.getUserRiskStat().snapshots(),
                  builder: (context, snapshot2) {
                    return snapshot2.hasData
                        ? ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditProfileMobile()));
                              },
                              contentPadding: EdgeInsets.all(10),
                              tileColor: Color(0xff131313),
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    NetworkImage(snapshot1.data.data()["img"]),
                              ),
                              title: Text(
                                snapshot1.data.data()["name"],
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              subtitle: Text(
                                snapshot2.data.data()["riskStatus"],
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          )
                        : Center(child: CircularProgressIndicator());
                  })
              : Center(child: CircularProgressIndicator());
        });
  }

  // show rest of the details in a card
  Widget profileCard() {
    return StreamBuilder(
        stream: _userDA.getUserProfile().snapshots(),
        builder: (context, snapshot3) {
          return snapshot3.connectionState == ConnectionState.active
              ? Card(
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: Color(0xff131313),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        // user id
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'User ID:',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                snapshot3.data.data()["userID"],
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 65,
                        ),
                        // phone no
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'User Phone No:',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                snapshot3.data.data()["mobileNumber"],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 65,
                        ),
                        // ic / passport number
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'User IC/Pasport No:',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                snapshot3.data.data()["icNo"],
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
              : Center(child: CircularProgressIndicator());
        });
  }

  // show user image preview when editing
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  // update the profile
  updateProfile(url, address, email) async {
    Map<String, String> data = {"img": url, "email": email, "address": address};
    await _userDA.updateProfile(data);
  }

  // upload image
  uploadImage() async {
    await _userDA.uploadUserImage(_image);
    final ref = _userDA.refDirectory();
    final url = await ref.getDownloadURL();
  }

  Widget showImagePreview() {
    return StreamBuilder(
        stream: _userDA.getUserProfile().snapshots(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Center(
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(snapshot.data.data()["img"]),
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
