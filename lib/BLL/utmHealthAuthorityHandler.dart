import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:utmccta/Application/healthStatusUpdateForm.dart';
import 'package:utmccta/BLL/users.dart';
import 'package:utmccta/BLL/utmHealthAuthorities.dart';
import 'package:utmccta/DLL/utmHealthAuthoritiesDA.dart';

class UTMHealthAuthorityHandler {
  UTMHealthAuthoritiesDA _authoritiesDA = UTMHealthAuthoritiesDA();
  QuerySnapshot searchSnap;
  QuerySnapshot searchSnap1;

  //Show clinic profile image in the menue
  Widget getClinicProfileImage() {
    return StreamBuilder(
        stream: _authoritiesDA.getUserProfile().snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            UTMHealthAuthorities _healthAuth =
                UTMHealthAuthorities.fromMap(snapshot.data.data());

            return Container(
              padding: EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Text(
                    _healthAuth.name,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    //radius: 30,
                    backgroundImage: NetworkImage(_healthAuth.img),
                  ),
                ],
              ),
            );
          }
          return CircularProgressIndicator();
        });
  }

  //get all user details
  Widget getUserDetails(String searchTerm) {
    return StreamBuilder(
        stream: _authoritiesDA
            .getAllUserDetails()
            .where("userID", isEqualTo: searchTerm)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return StreamBuilder(
                stream: _authoritiesDA.getAllUserHealthDetails().snapshots(),
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
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          var docID =
                              snapshot.data.docs[index].data()['documentID'];
                          print(docID);
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
                          );
                          return ExpansionTile(
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
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              children: [
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
                                Container(
                                  width: 150,
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width /
                                          1.55),
                                  child: MaterialButton(
                                    elevation: 0,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  HealthStatusUpdateForm(
                                                    userName: _users.name,
                                                    docID: docID,
                                                  )));
                                    },
                                    color: Theme.of(context).accentColor,
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'EDIT',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
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
                                  height: 20,
                                ),
                              ]);
                        });
                  }
                  return Text(
                    'No User Found',
                    style: TextStyle(color: Colors.black),
                  );
                });
          }
          return Text(
            'No User Found',
            style: TextStyle(color: Colors.black),
          );
        });
  }

  searchUSersBasedOnUserID(searchT) async {
    await _authoritiesDA
        .getAllUserDetails()
        .where('userID', isEqualTo: searchT)
        .get()
        .then((value) {
      searchSnap1 = value;
    });
  }

  Widget showUserDetails() {
    return searchSnap1 != null
        ? StreamBuilder(
            stream: _authoritiesDA.getAllUserHealthDetails().snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      var docID =
                          snapshot.data.docs[index].data()['documentID'];
                      print(docID);

                      return _buildListTile(
                          context, searchSnap1.docs, index, snapshot, docID);
                    });
              }
              return Text(
                'No User Found',
                style: TextStyle(color: Colors.black),
              );
            })
        : Center(
            child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Icon(
                Icons.people,
                size: 60,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "No User Yet Found",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ));
  }

  _buildListTile(context, List<DocumentSnapshot> snap, index,
      AsyncSnapshot<dynamic> snapshot, docID) {
    return snap
        .map((e) => extendedListtile(e, context, index, snapshot, docID));
  }

  Widget extendedListtile(DocumentSnapshot data, context, index,
      AsyncSnapshot<dynamic> snapshot, docID) {
    return ExpansionTile(
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        childrenPadding: EdgeInsets.fromLTRB(70, 20, 0, 20),
        title: Text(
          data.data()['name'],
          style: Theme.of(context).primaryTextTheme.bodyText1,
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(data.data()['img']),
        ),
        subtitle: Text(
          snapshot.data.docs[index].data()['riskStatus'],
          style: Theme.of(context).textTheme.headline4,
        ),
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Health Information',
              style: Theme.of(context).primaryTextTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 150,
            margin:
                EdgeInsets.only(left: MediaQuery.of(context).size.width / 1.55),
            child: MaterialButton(
              elevation: 0,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => HealthStatusUpdateForm(
                              userName: data.data()['name'],
                              docID: docID,
                            )));
              },
              color: Theme.of(context).accentColor,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'EDIT',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          renderDataTableHealth(
            data.data()['userID'],
            snapshot.data.docs[index].data()['closeContact'],
            snapshot.data.docs[index].data()['covidStatus'],
            snapshot.data.docs[index].data()['covidSymptoms'],
            snapshot.data.docs[index].data()['generalSymptoms'],
            snapshot.data.docs[index].data()['immunocompromised'],
            snapshot.data.docs[index].data()['traveled'],
            context,
          ),
          SizedBox(
            height: 20,
          ),
        ]);
  }

  // search for user contact list
  searchUsersBasedOnRegID(search) async {
    await _authoritiesDA.getAllUsersContactList(search).then((value) {
      searchSnap = value;
    });
  }

  Widget showContactList(context) {
    return searchSnap != null
        ? Container(
            width: MediaQuery.of(context).size.width,
            child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Color(0xffA79BDB)),
                dataRowColor: MaterialStateColor.resolveWith(
                    (states) => Color(0xffDED9F5)),
                columns: [
                  DataColumn(
                    label: Text(
                      "Contact Name",
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
                      "COVID Status",
                      style: Theme.of(context).primaryTextTheme.headline3,
                    ),
                  ),
                ],
                rows: searchSnap.docs != null
                    ? _buildRow(context, searchSnap.docs)
                    : Center(
                        child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Icon(
                            Icons.people,
                            size: 60,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "No Contact List Found",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ))),
          )
        : Center(
            child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Icon(
                Icons.people,
                size: 60,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "All The Contact List Will Show Here.",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ));
  }

  List<DataRow> _buildRow(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    return snapshot
        .map((data) => renderDataTableUserContact(data, context))
        .toList();
  }

  // render data table user contcat list
  DataRow renderDataTableUserContact(
      DocumentSnapshot data, BuildContext context) {
    return DataRow(cells: [
      DataCell(
        Text(
          data.data()['contactName'],
          style: Theme.of(context).primaryTextTheme.subtitle2,
        ),
      ),
      DataCell(
        Text(
          data.data()['contactNumber'],
          style: Theme.of(context).primaryTextTheme.subtitle2,
        ),
      ),
      DataCell(
        Text(
          data.data()['contactEmail'],
          style: Theme.of(context).primaryTextTheme.subtitle2,
        ),
      ),
      DataCell(
        Text(
          data.data()['contactCovidStatus'].toString(),
          style: Theme.of(context).primaryTextTheme.subtitle2,
        ),
      ),
    ]);
  }

  // render data table health
  Widget renderDataTableHealth(
      uid, cc, cs, csy, gs, im, t, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(right: 40),
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
              DataCell(cc == true
                  ? Text(
                      "Yes",
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    )
                  : Text(
                      "No",
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    )),
              DataCell(cs == true
                  ? Text(
                      "Positive",
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    )
                  : Text(
                      "Negative",
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    )),
              DataCell(csy == true
                  ? Text(
                      "Yes",
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    )
                  : Text(
                      "No",
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    )),
              DataCell(gs == true
                  ? Text(
                      "Yes",
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    )
                  : Text(
                      "No",
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    )),
              DataCell(im == true
                  ? Text(
                      "Yes",
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    )
                  : Text(
                      "No",
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    )),
              DataCell(t == true
                  ? Text(
                      "Yes",
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    )
                  : Text(
                      "No",
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    )),
            ])
          ]),
    );
  }

  //get covid positive number
  Widget getTotalCovidPositive() {
    return StreamBuilder(
        stream: _authoritiesDA
            .getAllUserHealthDetails()
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

  //get covid symptoms number
  Widget getTotalCovidSymptom(context) {
    return StreamBuilder(
        stream: _authoritiesDA
            .getAllUserHealthDetails()
            .where("covidSymptoms", isEqualTo: true)
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
                      'Total\nNumber of\nUsers Showing\nCOVID Symptoms',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
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
                          color: Theme.of(context).accentColor, width: 20),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${snapshot.data.docs.length}',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
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

  //get close contact number
  Widget getTotalCloseContacts() {
    return StreamBuilder(
        stream: _authoritiesDA
            .getAllUserHealthDetails()
            .where("closeContact", isEqualTo: true)
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
                      'User\'s Had Close Contact With Another COVID Patient',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
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
        stream: _authoritiesDA.getAllUserDetails().snapshots(),
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
}