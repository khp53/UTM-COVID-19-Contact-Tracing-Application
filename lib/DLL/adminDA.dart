import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:utmccta/BLL/admin.dart';

class AdminDA {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Admin _adminFromFirebaseUser(User user) {
    return user != null ? Admin(uid: user.uid) : null;
  }

  //auth change admin stream
  Stream<Admin> get adminAuthChangeStream {
    return _auth.authStateChanges().map(_adminFromFirebaseUser);
  }

  // sign in using email and pass
  Future signInWithEmailandPasswordAdmin(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _adminFromFirebaseUser(user);
    } catch (e) {
      print("Sign in error admin side $e");
    }
  }

  // signout methode admin
  Future signOutAdmin() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  // get admin profile based on admin UID
  DocumentReference getUserProfile() {
    return _firestore
        .collection("System Administrators")
        .doc(_auth.currentUser.uid);
  }

  //get all user details
  CollectionReference getAllUserDetails() {
    return _firestore.collection("Users");
  }

  //get all user details
  CollectionReference getAllUserHealthDetails() {
    return _firestore.collection("HealthStatus");
  }
}
