import 'package:flutter/material.dart';
import 'package:utmccta/BLL/admin.dart';
import 'package:utmccta/BLL/healthStatusFormHandler.dart';
import 'package:utmccta/BLL/users.dart';
import 'package:utmccta/DLL/adminDA.dart';

class AdminHandler extends StatefulWidget {
  @override
  _AdminHandlerState createState() => _AdminHandlerState();
}

class _AdminHandlerState extends State<AdminHandler> {
  AdminDA _adminDA = AdminDA();
  HealthStatusFormHandler _healthStatusFormHandler = HealthStatusFormHandler();
  //Show admin profile image in the menue
  Widget getAdminProfileImage() {
    return StreamBuilder(
        stream: _adminDA.getUserProfile().snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            Admin admin = Admin.extended(
                snapshot.data.data()["staffID"],
                snapshot.data.data()["mobileNumber"],
                snapshot.data.data()["icNo"],
                snapshot.data.data()["img"],
                snapshot.data.data()["name"],
                snapshot.data.data()["email"]);
            return CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(admin.img),
            );
          }
          return CircularProgressIndicator();
        });
  }

  //get all user details
  Widget getUserDetails() {
    return StreamBuilder(
        stream: _adminDA.getAllUserDetails().snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return StreamBuilder(
                stream: _adminDA.getAllUserHealthDetails().snapshots(),
                builder: (context, snapshot1) {
                  if (snapshot1.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot1.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot1.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot1.data.docs.length,
                        itemBuilder: (context, index) {
                          Users _users = Users(
                            snapshot.data.docs[index].data()["name"],
                            snapshot.data.docs[index].data()["img"],
                            snapshot1.data.docs[index].data()["riskStatus"],
                            snapshot.data.docs[index].data()["userID"],
                            snapshot.data.docs[index].data()["mobileNumber"],
                            snapshot.data.docs[index].data()["email"],
                            snapshot.data.docs[index].data()["address"],
                            snapshot.data.docs[index].data()["icNo"],
                            snapshot.data.docs[index].data()["postcode"],
                          );
                          return ExpansionTile(
                              childrenPadding:
                                  EdgeInsets.fromLTRB(70, 20, 0, 20),
                              title: Text(
                                _users.name,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1,
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(_users.img),
                              ),
                              subtitle: Text(
                                _users.riskStatus,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Matric No: ${_users.userID}',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'IC/Passport No: ${_users.icNo}',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1,
                                        textAlign: TextAlign.start)),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'Mobile Number: ${_users.mobileNumber}',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1)),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Email: ${_users.email}',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1)),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Address: ${_users.address}',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1)),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'Postcode: ${_users.postcode.toString()}',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1)),
                                SizedBox(
                                  height: 10,
                                ),
                              ]);
                        });
                  }
                  return CircularProgressIndicator();
                });
          }
          return CircularProgressIndicator();
        });
  }

  //get all user details
  Widget getUserHealthDetails() {
    return StreamBuilder(
        stream: _adminDA.getAllUserDetails().snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return StreamBuilder(
                stream: _adminDA.getAllUserHealthDetails().snapshots(),
                builder: (context, snapshot1) {
                  if (snapshot1.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot1.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot1.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot1.data.docs.length,
                        itemBuilder: (context, index) {
                          Users _users = Users(
                            snapshot.data.docs[index].data()["name"],
                            snapshot.data.docs[index].data()["img"],
                            snapshot1.data.docs[index].data()["riskStatus"],
                            snapshot.data.docs[index].data()["userID"],
                            snapshot.data.docs[index].data()["mobileNumber"],
                            snapshot.data.docs[index].data()["email"],
                            snapshot.data.docs[index].data()["address"],
                            snapshot.data.docs[index].data()["icNo"],
                            snapshot.data.docs[index].data()["postcode"],
                          );
                          return ExpansionTile(
                              childrenPadding:
                                  EdgeInsets.fromLTRB(70, 20, 20, 20),
                              title: Text(
                                _users.name,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1,
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(_users.img),
                              ),
                              subtitle: Text(
                                _users.riskStatus,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${_healthStatusFormHandler.getQuestionText(0)}: \n${snapshot1.data.docs[index].data()["generalSymptoms"]}',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        '${_healthStatusFormHandler.getQuestionText(1)}: \n${snapshot1.data.docs[index].data()["covidSymptoms"]}',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1,
                                        textAlign: TextAlign.start)),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        '${_healthStatusFormHandler.getQuestionText(2)}: \n${snapshot1.data.docs[index].data()["immunocompromised"]}',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1)),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        '${_healthStatusFormHandler.getQuestionText(3)}: \n${snapshot1.data.docs[index].data()["traveled"]}',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1)),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        '${_healthStatusFormHandler.getQuestionText(4)}: \n${snapshot1.data.docs[index].data()["closeContact"]}',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1)),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        '${_healthStatusFormHandler.getQuestionText(5)}: \n${snapshot1.data.docs[index].data()["covidStatus"]}',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1)),
                                SizedBox(
                                  height: 10,
                                ),
                              ]);
                        });
                  }
                  return CircularProgressIndicator();
                });
          }
          return CircularProgressIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
