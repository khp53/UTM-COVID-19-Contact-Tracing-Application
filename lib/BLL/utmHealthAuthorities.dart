class UTMHealthAuthorities {
  String clinicID;
  String mobileNumber;
  String email;
  String icNo;
  String img;
  String name;

  UTMHealthAuthorities.fromMap(Map<String, dynamic> clinicMap)
      : assert(clinicMap['clinicID'] != null),
        assert(clinicMap['mobileNumber'] != null),
        assert(clinicMap['email'] != null),
        assert(clinicMap['icNo'] != null),
        assert(clinicMap['img'] != null),
        assert(clinicMap['name'] != null),
        clinicID = clinicMap['clinicID'],
        mobileNumber = clinicMap['mobileNumber'],
        email = clinicMap['email'],
        icNo = clinicMap['icNo'],
        img = clinicMap['img'],
        name = clinicMap['name'];
}
