class Users {
  final String userID;
  final String mobileNumber;
  final String email;
  final String address;
  final String icNo;
  final String img;
  final String name;
  final int postcode;
  final String riskStatus;

  Users(this.name, this.img, this.riskStatus, this.userID, this.mobileNumber,
      this.email, this.address, this.icNo, this.postcode);

  // setter
  set userID(String userID) {
    userID = userID;
  }

  set mobileNumber(String mobileNumber) {
    mobileNumber = mobileNumber;
  }

  set email(String email) {
    email = email;
  }

  set address(String address) {
    address = address;
  }

  set icNo(String icNo) {
    icNo = icNo;
  }

  set postcode(int postcode) {
    postcode = postcode;
  }

  set img(String img) {
    img = img;
  }

  set name(String name) {
    name = name;
  }

  set riskStatus(String riskStatus) {
    riskStatus = riskStatus;
  }

  //getters
  String get getUserID {
    return userID;
  }

  String get getMobileNumber {
    return mobileNumber;
  }

  String get getEmail {
    return email;
  }

  String get getAddress {
    return address;
  }

  String get getIcNo {
    return icNo;
  }

  int get getPostcode {
    return postcode;
  }

  String get getRiskStatus {
    return riskStatus;
  }

  String get getImg {
    return img;
  }

  String get getName {
    return name;
  }
}
