import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDA {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get USer uid
  getUID() {
    return _auth.currentUser.uid;
  }

  // old user auto sign in
  signIn(AuthCredential authCreds) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(authCreds);
    } catch (e) {
      print("Sign in error user side $e");
    }
  }

  //enter otp method for new users
  signInWithOTP(smsCode, verId) async {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }

  //sign out method for the user
  Future signOutUser() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  //save user data to firestore db
  Future uploadUserInfo(userMap) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(_auth.currentUser.uid)
        .set(userMap);
  }

  //save device token from homepage
  Future uploadUserDeviceToken(deviceToken) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(_auth.currentUser.uid)
        .update({'deviceToken': deviceToken});
  }

  // get user profiles based on uid
  DocumentReference getUserProfile() {
    return _firestore.collection("Users").doc(_auth.currentUser.uid);
  }

  // get user risk status from health da
  DocumentReference getUserRiskStat() {
    return _firestore.collection("HealthStatus").doc(_auth.currentUser.uid);
  }

  //update user data
  Future<void> updateProfile(Map data) async {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(_auth.currentUser.uid)
        .update(data);
  }

  // reference the directory in firebase storage
  refDirectory() async {
    return FirebaseStorage.instance
        .ref()
        .child("user_image")
        .child(_auth.currentUser.phoneNumber + '.jpg');
  }

  // upload user image
  uploadUserImage(File img) async {
    return await FirebaseStorage.instance
        .ref()
        .child("user_image")
        .child(_auth.currentUser.phoneNumber + '.jpg')
        .putFile(img);
  }

  // set a blank location entry collection
  Future createBlankLocationEntry() async {
    return await FirebaseFirestore.instance
        .collection("LocationEntry")
        .doc(_auth.currentUser.uid)
        .set({"locationEntry": FieldValue.arrayUnion([])});
  }
}
