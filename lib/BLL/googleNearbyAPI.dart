import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:location/location.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:utmccta/Application/helpers/main_button.dart';
import 'package:utmccta/DLL/traceContactsDA.dart';

class GoogleNearbyAPI extends StatefulWidget {
  @override
  _GoogleNearbyAPIState createState() => _GoogleNearbyAPIState();
}

class _GoogleNearbyAPIState extends State<GoogleNearbyAPI> {
  //Location location = Location();
  final Strategy strategy = Strategy.P2P_STAR;
  TraceContactsDA _traceContactsDA = TraceContactsDA();

  List<dynamic> contactTraces = [];
  List<dynamic> contactTime = [];
  List<dynamic> contactLocation = [];

  // add the discovered contacts to list
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
    });
  }

  // remove contacts older then 14 days
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
  }

  // ask location and external storage permission
  // bluetooth will be automatically activated when discovery starts
  void getPermissions() {
    Nearby().askLocationAndExternalStoragePermission();
  }

  checkIfGPSOn() async {
    return await Nearby().checkLocationEnabled();
  }

  // open your device through a encrypted channel for other ccta users to discover
  void discovery() async {
    try {
      bool d = await Nearby()
          .startDiscovery(_traceContactsDA.loggedInUserID(), strategy,
              onEndpointFound: (id, name, serviceId) async {
        print('I saw id:$id with name:$name');
        // in utm ccta's case the user name will be the document ID
        //  When I discover someone I will see their email and add that email to the database of my contacts
        //  also get the current time & location and add it to the database
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        _traceContactsDA
            .traceContactsDocument()
            .collection('contactedWith')
            .doc(name)
            .set({
          'contactName':
              await _traceContactsDA.getNameOfContactedPerson(uid: name),
          'contactEmail':
              await _traceContactsDA.getEmailOfContactedPerson(uid: name),
          'contactNumber':
              await _traceContactsDA.getPhoneNoOfContactedPerson(uid: name),
          'contactTime': DateTime.now(),
          'contactLocationLatitude': position.latitude,
          'contactLocationLongitudee': position.longitude,
        });
      }, onEndpointLost: (id) {
        print(id);
      });
      print('DISCOVERING: ${d.toString()}');
    } catch (e) {
      print(e);
    }
  }

  void adverise() async {
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
  }

  // stop discovery
  void stopDiscovery() async {
    return await Nearby().stopDiscovery();
  }

  // stop advertising
  void stopAdvertising() async {
    return await Nearby().stopAdvertising();
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
