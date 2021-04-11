import 'package:utmccta/DLL/userDA.dart';

class UserHandler {
  UserDA _userDA = UserDA();

  //user data handler
  registerUserDataHandler(
      userID, icNo, name, mobileNumber, email, address, postcode) {
    Map<String, dynamic> userInfoMap = {
      "img":
          "https://firebasestorage.googleapis.com/v0/b/utm-covid19-contact-tracing.appspot.com/o/default.png?alt=media&token=45b19e89-019b-4eac-8f1c-aaf0f2b715e0",
      "userID": userID,
      "icNo": icNo,
      "name": name,
      "mobileNumber": mobileNumber,
      "email": email,
      "address": address,
      "postcode": int.parse(postcode)
    };
    _userDA.uploadUserInfo(userInfoMap);
  }
}
