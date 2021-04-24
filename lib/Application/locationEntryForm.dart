import 'package:flutter/material.dart';

class LocationEntryForm extends StatefulWidget {
  @override
  _LocationEntryFormState createState() => _LocationEntryFormState();
}

class _LocationEntryFormState extends State<LocationEntryForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage('assets/img/locationEntryImage.png'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
