import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HealthStatusDA {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //save user health status data to firestore db
  Future uploadUserInfo(userHealthMap) async {
    return await FirebaseFirestore.instance
        .collection("HealthStatus")
        .doc(_auth.currentUser.uid)
        .set(userHealthMap);
  }
}
