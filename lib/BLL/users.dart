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
  final bool closeContact;
  final bool covidStatus;
  final bool covidSymptoms;
  final bool generalSymtoms;
  final bool immunocompromised;
  final bool traveled;

  Users(
      this.name,
      this.img,
      this.riskStatus,
      this.userID,
      this.mobileNumber,
      this.email,
      this.address,
      this.icNo,
      this.postcode,
      this.closeContact,
      this.covidStatus,
      this.covidSymptoms,
      this.generalSymtoms,
      this.immunocompromised,
      this.traveled);

  Users.fromMap(Map<String, dynamic> userMap)
      : assert(userMap['userID'] != null),
        assert(userMap['mobileNumber'] != null),
        assert(userMap['email'] != null),
        assert(userMap['address'] != null),
        assert(userMap['icNo'] != null),
        assert(userMap['img'] != null),
        assert(userMap['name'] != null),
        assert(userMap['postcode'] != null),
        assert(userMap['riskStatus'] != null),
        assert(userMap['closeContact'] != null),
        assert(userMap['covidStatus'] != null),
        assert(userMap['covidSymptoms'] != null),
        assert(userMap['generalSymtoms'] != null),
        assert(userMap['immunocompromised'] != null),
        assert(userMap['traveled'] != null),
        userID = userMap['userID'],
        mobileNumber = userMap['mobileNumber'],
        email = userMap['email'],
        address = userMap['address'],
        icNo = userMap['icNo'],
        img = userMap['img'],
        name = userMap['name'],
        postcode = userMap['postcode'],
        riskStatus = userMap['riskStatus'],
        closeContact = userMap['closeContact'],
        covidStatus = userMap['covidStatus'],
        covidSymptoms = userMap['covidSymptoms'],
        generalSymtoms = userMap['generalSymtoms'],
        immunocompromised = userMap['immunocompromised'],
        traveled = userMap['traveled'];
}
