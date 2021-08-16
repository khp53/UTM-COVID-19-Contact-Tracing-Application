import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TraceContactsDA {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User loggedInUser;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //get current logged in user info
  Future<void> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  // return logged in user id
  loggedInUserID() {
    return _auth.currentUser.uid;
  }

  Future<String> getRegID() async {
    String _regID = '';
    await _firestore
        .collection('Users')
        .doc(_auth.currentUser.uid)
        .get()
        .then((doc) {
      if (doc.exists) {
        _regID = doc.data()['regID'];
      } else {
        // doc.data() will be undefined in this case
        print("No such document!");
      }
    });
    return _regID;
  }

  // access or create trace contacts collection
  CollectionReference traceContactsCollection() {
    return _firestore.collection('TraceContacts');
  }

  // CollectionReference traceContactsDocument() {
  //   return _firestore.collection('TraceContacts');
  // }

  Future<String> getEmailOfContactedPerson({uid}) async {
    String _email = '';
    await _firestore.collection('Users').doc(uid).get().then((doc) {
      if (doc.exists) {
        _email = doc.data()['email'];
      } else {
        // doc.data() will be undefined in this case
        print("No such document!");
      }
    });
    return _email;
  }

  Future<String> getPhoneNoOfContactedPerson({String uid}) async {
    String _phoneNumber = '';
    await _firestore.collection('Users').doc(uid).get().then((doc) {
      if (doc.exists) {
        _phoneNumber = doc.data()['mobileNumber'];
      } else {
        // doc.data() will be undefined in this case
        print("No such document!");
      }
    });
    return _phoneNumber;
  }

  Future<String> getNameOfContactedPerson({String uid}) async {
    String _name = '';
    await _firestore.collection('Users').doc(uid).get().then((doc) {
      if (doc.exists) {
        _name = doc.data()['name'];
      } else {
        // doc.data() will be undefined in this case
        print("No such document!");
      }
    });
    return _name;
  }

  Future<String> getDeviceTokenOfContactedPerson({String uid}) async {
    String _deviceToken = '';
    await _firestore.collection('Users').doc(uid).get().then((doc) {
      if (doc.exists) {
        _deviceToken = doc.data()['deviceToken'];
      } else {
        // doc.data() will be undefined in this case
        print("No such document!");
      }
    });
    return _deviceToken;
  }

  Future<bool> getCovidStatusOfContactedPerson({String uid}) async {
    bool covidStatus;
    await _firestore.collection('HealthStatus').doc(uid).get().then((doc) {
      if (doc.exists) {
        covidStatus = doc.data()['covidStatus'];
      } else {
        // doc.data() will be undefined in this case
        print("No such document!");
      }
    });
    return covidStatus;
  }
}
