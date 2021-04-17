import 'package:flutter/material.dart';
import 'package:utmccta/BLL/admin.dart';
import 'package:utmccta/DLL/adminDA.dart';

class AdminHandler extends StatefulWidget {
  @override
  _AdminHandlerState createState() => _AdminHandlerState();
}

class _AdminHandlerState extends State<AdminHandler> {
  AdminDA _adminDA = AdminDA();
  //Show admin profile image in the menue
  Widget getAdminProfileImage() {
    return StreamBuilder(
        stream: _adminDA.getUserProfile().snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            Admin admin = Admin.extended(
                snapshot.data.data()["staffID"],
                snapshot.data.data()["mobileNumber"],
                snapshot.data.data()["icNo"],
                snapshot.data.data()["img"],
                snapshot.data.data()["name"],
                snapshot.data.data()["email"]);
            return ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: Container(
                height: 50,
                width: 50,
                child: Image.network(admin.img),
              ),
            );
          }
          return CircularProgressIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
