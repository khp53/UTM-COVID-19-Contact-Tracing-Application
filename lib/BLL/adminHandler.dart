import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:utmccta/Application/manageProfile.dart';
import 'package:utmccta/BLL/admin.dart';
import 'package:utmccta/BLL/users.dart';
import 'package:utmccta/DLL/adminDA.dart';

class AdminHandler extends StatefulWidget {
  @override
  _AdminHandlerState createState() => _AdminHandlerState();
}

class _AdminHandlerState extends State<AdminHandler> {
  AdminDA _adminDA = AdminDA();
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
            return Container(
              padding: EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ManageProfileWebLayout(
                      name: snapshot.data.data()["name"],
                      mobileNumber: snapshot.data.data()["mobileNumber"],
                      img: snapshot.data.data()["img"],
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      admin.name,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      //radius: 30,
                      backgroundImage: NetworkImage(admin.img),
                    ),
                  ],
                ),
              ),
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
                            snapshot1.data.docs[index].data()["closeContact"],
                            snapshot1.data.docs[index].data()["covidStatus"],
                            snapshot1.data.docs[index].data()["covidSymptoms"],
                            snapshot1.data.docs[index]
                                .data()["generalSymptoms"],
                            snapshot1.data.docs[index]
                                .data()["immunocompromised"],
                            snapshot1.data.docs[index].data()["traveled"],
                            snapshot.data.docs[index].data()["deviceToken"],
                          );
                          return Column(
                            children: [
                              ExpansionTile(
                                  collapsedBackgroundColor: Colors.white,
                                  backgroundColor: Colors.white,
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
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'User Information',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    renderDataTableUserInfo(
                                      _users.userID,
                                      _users.mobileNumber,
                                      _users.email,
                                      _users.icNo,
                                      _users.address,
                                      _users.postcode,
                                      context,
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Health Information',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    renderDataTableHealth(
                                      _users.userID,
                                      _users.closeContact,
                                      _users.covidStatus,
                                      _users.covidSymptoms,
                                      _users.generalSymtoms,
                                      _users.immunocompromised,
                                      _users.traveled,
                                      context,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ]),
                              SizedBox(
                                height: 7,
                              ),
                            ],
                          );
                        });
                  }
                  return CircularProgressIndicator();
                });
          }
          return CircularProgressIndicator();
        });
  }

  // render data table user
  Widget renderDataTableUserInfo(
      uid, number, email, ic, add, pos, BuildContext context) {
    return FittedBox(
      child: DataTable(
          headingRowColor:
              MaterialStateColor.resolveWith((states) => Color(0xffA79BDB)),
          dataRowColor:
              MaterialStateColor.resolveWith((states) => Color(0xffDED9F5)),
          columns: [
            DataColumn(
              label: Text(
                "User ID",
                style: Theme.of(context).primaryTextTheme.headline3,
              ),
            ),
            DataColumn(
              label: Text(
                "Mobile Number",
                style: Theme.of(context).primaryTextTheme.headline3,
              ),
            ),
            DataColumn(
              label: Text(
                "Email",
                style: Theme.of(context).primaryTextTheme.headline3,
              ),
            ),
            DataColumn(
              label: Text(
                "IC/Passport Number",
                style: Theme.of(context).primaryTextTheme.headline3,
              ),
            ),
            DataColumn(
              label: Text(
                "Address",
                style: Theme.of(context).primaryTextTheme.headline3,
              ),
            ),
            DataColumn(
              label: Text(
                "Post Code",
                style: Theme.of(context).primaryTextTheme.headline3,
              ),
            ),
          ],
          rows: [
            DataRow(cells: [
              DataCell(
                Text(
                  uid,
                  style: Theme.of(context).primaryTextTheme.subtitle2,
                ),
              ),
              DataCell(
                Text(
                  number,
                  style: Theme.of(context).primaryTextTheme.subtitle2,
                ),
              ),
              DataCell(
                Text(
                  email,
                  style: Theme.of(context).primaryTextTheme.subtitle2,
                ),
              ),
              DataCell(
                Text(
                  ic,
                  style: Theme.of(context).primaryTextTheme.subtitle2,
                ),
              ),
              DataCell(
                Text(
                  add,
                  style: Theme.of(context).primaryTextTheme.subtitle2,
                ),
              ),
              DataCell(
                Text(
                  pos.toString(),
                  style: Theme.of(context).primaryTextTheme.subtitle2,
                ),
              ),
            ])
          ]),
    );
  }

  // render data table health
  Widget renderDataTableHealth(
      uid, cc, cs, csy, gs, im, t, BuildContext context) {
    return FittedBox(
      child: DataTable(
          headingRowColor:
              MaterialStateColor.resolveWith((states) => Color(0xffF6C3D3)),
          dataRowColor:
              MaterialStateColor.resolveWith((states) => Color(0xffF8DCE5)),
          columns: [
            DataColumn(
              label: Text(
                "User ID",
                style: Theme.of(context).primaryTextTheme.headline3,
              ),
            ),
            DataColumn(
              label: Text(
                "Close Contact",
                style: Theme.of(context).primaryTextTheme.headline3,
              ),
            ),
            DataColumn(
              label: Text(
                "Covid Status",
                style: Theme.of(context).primaryTextTheme.headline3,
              ),
            ),
            DataColumn(
              label: Text(
                "Covid Symptoms",
                style: Theme.of(context).primaryTextTheme.headline3,
              ),
            ),
            DataColumn(
              label: Text(
                "General Symtoms",
                style: Theme.of(context).primaryTextTheme.headline3,
              ),
            ),
            DataColumn(
              label: Text(
                "Immunocompromised",
                style: Theme.of(context).primaryTextTheme.headline3,
              ),
            ),
            DataColumn(
              label: Text(
                "Traveled",
                style: Theme.of(context).primaryTextTheme.headline3,
              ),
            ),
          ],
          rows: [
            DataRow(cells: [
              DataCell(
                Text(
                  uid,
                  style: Theme.of(context).primaryTextTheme.subtitle2,
                ),
              ),
              DataCell(
                cc == true
                    ? Text(
                        "Yes",
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                      )
                    : Text(
                        "No",
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                      ),
              ),
              DataCell(
                cs == true
                    ? Text(
                        "Positive",
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                      )
                    : Text(
                        "Negative",
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                      ),
              ),
              DataCell(
                csy == true
                    ? Text(
                        "Yes",
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                      )
                    : Text(
                        "No",
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                      ),
              ),
              DataCell(
                gs == true
                    ? Text(
                        "Yes",
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                      )
                    : Text(
                        "No",
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                      ),
              ),
              DataCell(
                im == true
                    ? Text(
                        "Yes",
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                      )
                    : Text(
                        "No",
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                      ),
              ),
              DataCell(
                t == true
                    ? Text(
                        "Yes",
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                      )
                    : Text(
                        "No",
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                      ),
              ),
            ])
          ]),
    );
  }

  //get covid positive number
  Widget getTotalCovidPositive() {
    return StreamBuilder(
        stream: _adminDA
            .getAllUserCovidStatus()
            .where("covidStatus", isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      'Total\nNumber of\nCOVID Positive',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: new BoxDecoration(
                      border: Border.all(
                          color: snapshot.data.docs.length < 20
                              ? Colors.green
                              : Colors.red,
                          width: 20),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${snapshot.data.docs.length}',
                        style: TextStyle(
                            color: snapshot.data.docs.length > 20
                                ? Colors.red
                                : Colors.green,
                            fontSize: 70,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  // get total user number
  Widget getTotalUserNumber(BuildContext context) {
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
            return Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      'Total\nNumber of\nUsers',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: new BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColorDark, width: 20),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${snapshot.data.docs.length}',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 80,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  // get location entry of all user
  Widget getLocationEntry(BuildContext context) {
    return StreamBuilder(
        stream: _adminDA.getAllUserDetails().snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text("No Connections");
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                return StreamBuilder(
                    stream: _adminDA.getAllLocationEntry().snapshots(),
                    builder: (context, snapshot1) {
                      if (snapshot1.data != null) {
                        switch (snapshot1.connectionState) {
                          case ConnectionState.none:
                            return Text("No Connections");
                          case ConnectionState.waiting:
                            return CircularProgressIndicator();
                          case ConnectionState.active:
                          case ConnectionState.done:
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot1.data.docs.length,
                              itemBuilder: (builder, index) {
                                return locationEntryTable(
                                    index,
                                    snapshot1.data.docs[index]
                                        .data()['locationEntry'],
                                    snapshot.data.docs[index].data()['userID'],
                                    snapshot.data.docs[index].data()['name'],
                                    snapshot.data.docs[index].data()['img'],
                                    context);
                              },
                            );
                          default:
                            break;
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Center(child: Text("Loading..."));
                    });
              default:
                break;
            }
          } else {
            return Center(child: Text("Loading..."));
          }
          return Center(child: Text("Loading..."));
        });
  }

  Widget locationEntryTable(
      index, List locations, uid, unam, img, BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          childrenPadding: EdgeInsets.fromLTRB(70, 20, 0, 20),
          title: Text(
            unam,
            style: Theme.of(context).primaryTextTheme.bodyText1,
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(img),
          ),
          subtitle: Text(
            uid,
            style: Theme.of(context).textTheme.headline4,
          ),
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Location Name",
                        style: Theme.of(context).primaryTextTheme.headline3,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Location Address",
                        style: Theme.of(context).primaryTextTheme.headline3,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Visit Date",
                        style: Theme.of(context).primaryTextTheme.headline3,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Visit Time",
                        style: Theme.of(context).primaryTextTheme.headline3,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Entry Date",
                        style: Theme.of(context).primaryTextTheme.headline3,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  width: 5,
                ),
                ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.black,
                  ),
                  shrinkWrap: true,
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            locations[index]['locationName'],
                            style: Theme.of(context).primaryTextTheme.subtitle2,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            locations[index]['fullAddress'],
                            style: Theme.of(context).primaryTextTheme.subtitle2,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            locations[index]['visitDate'],
                            style: Theme.of(context).primaryTextTheme.subtitle2,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            locations[index]['visitTime'],
                            style: Theme.of(context).primaryTextTheme.subtitle2,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            locations[index]['entryDate'],
                            style: Theme.of(context).primaryTextTheme.subtitle2,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 7,
        )
      ],
    );
  }

  // update the profile
  updateProfile(name, mobileNumber) async {
    Map<String, dynamic> data = {
      "name": name,
      "mobileNumber": mobileNumber,
    };
    await _adminDA.updateProfile(data);
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
