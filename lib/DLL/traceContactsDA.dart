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

  // access or create trace contacts collection
  CollectionReference traceContactsCollection() {
    return _firestore
        .collection('TraceContacts')
        .doc(_auth.currentUser.uid)
        .collection('contactedWith');
  }

  DocumentReference traceContactsDocument() {
    return _firestore.collection('TraceContacts').doc(_auth.currentUser.uid);
  }

  Future<String> getEmailOfContactedPerson({uid}) async {
    String email = '';
    await _firestore.collection('Users').doc(uid).get().then((doc) {
      if (doc.exists) {
        email = doc.data()['email'];
      } else {
        // doc.data() will be undefined in this case
        print("No such document!");
      }
    });
    return email;
  }

  Future<String> getPhoneNoOfContactedPerson({String uid}) async {
    String phoneNumber = '';
    await _firestore.collection('Users').doc(uid).get().then((doc) {
      if (doc.exists) {
        phoneNumber = doc.data()['mobileNumber'];
      } else {
        // doc.data() will be undefined in this case
        print("No such document!");
      }
    });
    return phoneNumber;
  }
}
