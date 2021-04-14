import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:utmccta/Application/helpers/main_button.dart';
import 'package:utmccta/DLL/traceContactsDA.dart';

class GoogleNearbyAPI extends StatefulWidget {
  @override
  _GoogleNearbyAPIState createState() => _GoogleNearbyAPIState();
}

class _GoogleNearbyAPIState extends State<GoogleNearbyAPI> {
  Location location = Location();
  final Strategy strategy = Strategy.P2P_STAR;
  TraceContactsDA _traceContactsDA = TraceContactsDA();
  bool isLoading = false;

  List<dynamic> contactTraces = [];
  List<dynamic> contactTime = [];
  List<dynamic> contactLocation = [];

  void addContactsToList() async {
    await _traceContactsDA.getCurrentUser();
    _traceContactsDA.traceContactsCollection().snapshots().listen((snapshot) {
      for (var doc in snapshot.docs) {
        String currUsername = doc.data()['name'];
        DateTime currTime = doc.data().containsKey('contactTime')
            ? (doc.data()['contactTime'] as Timestamp).toDate()
            : null;
        String currLocation = doc.data().containsKey('contactLocation')
            ? doc.data()['contactLocation']
            : null;

        if (!contactTraces.contains(currUsername)) {
          contactTraces.add(currUsername);
          contactTime.add(currTime);
          contactLocation.add(currLocation);
        }
      }
      setState(() {});
    });
  }

  void removeOldContactListFromDB(int threshold) async {
    await _traceContactsDA.getCurrentUser();
    // get time and date
    DateTime timeNow = DateTime.now();

    _traceContactsDA.traceContactsCollection().snapshots().listen((snapshot) {
      for (var doc in snapshot.docs) {
        if (doc.data().containsKey('contactTime')) {
          DateTime contactTime = (doc.data()['contactTime'] as Timestamp)
              .toDate(); // get last contact time
          // if time since contact is greater than threshold than remove the contact from list
          if (timeNow.difference(contactTime).inDays > threshold) {
            doc.reference.delete();
          }
        }
      }
    });

    setState(() {});
  }

  void discovery() async {
    try {
      bool a = await Nearby()
          .startDiscovery(_traceContactsDA.loggedInUserID(), strategy,
              onEndpointFound: (id, name, serviceId) async {
        print('I saw id:$id with name:$name');
        // in utm ccta's case the user name will be the document ID
        //  When I discover someone I will see their email and add that email to the database of my contacts
        //  also get the current time & location and add it to the database
        _traceContactsDA
            .traceContactsDocument()
            .collection('met_with')
            .doc(name)
            .set({
          'contactEmail':
              await _traceContactsDA.getEmailOfContactedPerson(uid: name),
          'contactNumber':
              await _traceContactsDA.getPhoneNoOfContactedPerson(uid: name),
          'contact time': DateTime.now(),
          'contact location': (await location.getLocation()).toString(),
        });
      }, onEndpointLost: (id) {
        print(id);
      });
      print('DISCOVERING: ${a.toString()}');
    } catch (e) {
      print(e);
    }
  }

  Widget submitButton() {
    return Container(
        child: !isLoading
            ? TextButton(
                onPressed: () async {
                  try {
                    bool a = await Nearby().startAdvertising(
                      _traceContactsDA.loggedInUserID(),
                      strategy,
                      onConnectionInitiated: null,
                      onConnectionResult: (id, status) {
                        print(status);
                      },
                      onDisconnected: (id) {
                        print('Disconnected $id');
                      },
                    );

                    print('ADVERTISING ${a.toString()}');
                  } catch (e) {
                    print(e);
                  }

                  discovery();
                },
                child: Container(
                  height: 50,
                  decoration: mainButton(),
                  child: Center(
                      child: Text('Submit',
                          style: TextStyle(color: Colors.white, fontSize: 15))),
                ),
              )
            : CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
