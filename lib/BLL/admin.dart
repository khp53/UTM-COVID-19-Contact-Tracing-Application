class Admin {
  String uid;
  String staffID;
  String mobileNumber;
  String email;
  String icNo;
  String img;
  String name;
  Admin.extended(this.staffID, this.mobileNumber, this.icNo, this.img,
      this.name, this.email);
  Admin({this.uid});

  //getters
  String get getStaffID {
    return staffID;
  }

  String get getMobileNumber {
    return mobileNumber;
  }

  String get getEmail {
    return email;
  }

  String get getIcNo {
    return icNo;
  }

  String get getImg {
    return img;
  }

  String get getName {
    return name;
  }
}
