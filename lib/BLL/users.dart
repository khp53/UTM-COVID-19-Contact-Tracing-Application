class Users {
  String uid;
  String userID;
  String mobileNumber;
  String email;
  String address;
  String icNo;
  String img;
  String name;
  int postcode;
  String riskStatus;

  Users(
      {this.name,
      this.img,
      this.riskStatus,
      this.userID,
      this.mobileNumber,
      this.email,
      this.address,
      this.icNo,
      this.postcode,
      this.uid});

  //getters
  String getUserID() {
    return userID;
  }

  String getMobileNumber() {
    return mobileNumber;
  }

  String getEmail() {
    return email;
  }

  String getAddress() {
    return address;
  }

  String getIcNo() {
    return icNo;
  }

  int getPostcode() {
    return postcode;
  }

  String getRiskStatus() {
    return riskStatus;
  }

  String getImg() {
    return img;
  }

  String getName() {
    return name;
  }
}
