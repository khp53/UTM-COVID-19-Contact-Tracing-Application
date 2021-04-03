import 'package:utmccta/BLL/admin.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminDA {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Admin _adminFromFirebaseUser(User user) {
    return user != null ? Admin(uid: user.uid) : null;
  }

  Admin _adminEmailFromFirebaseUser(User user) {
    return user != null ? Admin(email: user.email) : null;
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
}
