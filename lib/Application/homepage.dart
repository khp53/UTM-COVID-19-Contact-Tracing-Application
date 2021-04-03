import 'package:flutter/material.dart';
import 'package:utmccta/DLL/userDA.dart';
import 'package:utmccta/Application/manageProfile.dart';

class Homepage extends StatefulWidget {
  final String id = 'Homepage';
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text(
            'UTM CCTA',
            style: Theme.of(context).textTheme.headline2,
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ManageProfile()));
              },
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/img/default.png'),
              ),
            )
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Flexible(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/img/homeMainImage.png'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
