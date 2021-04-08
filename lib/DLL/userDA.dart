import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:utmccta/BLL/users.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDA {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Users _userFromFirebaseUser(User user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<Users> get userAuthChangeStream {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // old user auto sign in
  signIn(AuthCredential authCreds) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(authCreds);
      //User user = res.user;
      //return _userFromFirebaseUser(user);
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

  //check if user id has a collection in db
  getUserDbInfo() {
    return FirebaseFirestore.instance.collection("Users/${Users().uid}");
  }
}
