import 'package:utmccta/Application/manageProfile.dart';
import 'package:utmccta/BLL/users.dart';
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
      "postcode": int.parse(postcode),
      "documentID": _userDA.getUID().toString(),
    };
    _userDA.uploadUserInfo(userInfoMap);
    _userDA.createBlankLocationEntry();
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
          if (snapshot1.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot1.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot1.hasData) {
            return StreamBuilder(
                stream: _userDA.getUserRiskStat().snapshots(),
                builder: (context, snapshot2) {
                  if (snapshot2.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot2.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot2.hasData) {
                    Users _users = Users(
                      snapshot1.data.data()["name"],
                      snapshot1.data.data()["img"],
                      snapshot2.data.data()["riskStatus"],
                      snapshot1.data.data()["userID"],
                      snapshot1.data.data()["mobileNumber"],
                      snapshot1.data.data()["email"],
                      snapshot1.data.data()["address"],
                      snapshot1.data.data()["icNo"],
                      snapshot1.data.data()["postcode"],
                      snapshot2.data.data()["closeContact"],
                      snapshot2.data.data()["covidStatus"],
                      snapshot2.data.data()["covidSymptoms"],
                      snapshot2.data.data()["generalSymtoms"],
                      snapshot2.data.data()["immunocompromised"],
                      snapshot2.data.data()["traveled"],
                      snapshot1.data.data()["deviceToken"],
                    );
                    return ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditProfileMobile(
                                email: _users.email,
                                address: _users.address,
                                postcode: _users.postcode,
                              ),
                            ),
                          );
                        },
                        contentPadding: EdgeInsets.all(10),
                        tileColor: Color(0xff131313),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(_users.img),
                        ),
                        title: Text(
                          _users.name,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        subtitle: Text(
                          _users.riskStatus,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        trailing: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                });
          }
          return Center(child: CircularProgressIndicator());
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
                                    color: Colors.white, fontSize: 13),
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 65,
                        ),
                        // ic / passport number
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Registration No:',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                snapshot3.data.data()["documentID"],
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

  // update the profile
  updateProfile(url, email, address, postcode) async {
    Map<String, dynamic> data = {
      "img": url,
      "email": email,
      "address": address,
      "postcode": int.parse(postcode)
    };
    await _userDA.updateProfile(data);
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
