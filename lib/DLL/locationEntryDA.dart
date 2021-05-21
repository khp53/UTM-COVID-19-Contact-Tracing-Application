import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LocationEntryDA {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload user manual location entry
  Future uploadUserLocationEntry(locationMap) async {
    return await _firestore
        .collection("LocationEntry")
        .doc(_auth.currentUser.uid)
        .set(locationMap);
  }
}
