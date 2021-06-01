import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UTMHealthAuthoritiesDA {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // get clinic profile based on admin UID
  DocumentReference getUserProfile() {
    return _firestore
        .collection("System Administrators")
        .doc(_auth.currentUser.uid);
  }

  //get all user details
  CollectionReference getAllUserDetails() {
    return _firestore.collection("Users");
  }

  //get all user health details
  CollectionReference getAllUserHealthDetails() {
    return _firestore.collection("HealthStatus");
  }

  // get all users contact list
  Future getAllUsersContactList(String id) async {
    return _firestore
        .collection("TraceContacts")
        .doc(id)
        .collection("contactedWith")
        .get();
  }
}
