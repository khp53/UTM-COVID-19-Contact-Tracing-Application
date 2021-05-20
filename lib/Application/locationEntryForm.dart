import 'package:flutter/material.dart';
import 'package:utmccta/Application/helpers/dateField.dart';
import 'package:utmccta/Application/helpers/dateTimeField.dart';

class LocationEntryForm extends StatefulWidget {
  @override
  _LocationEntryFormState createState() => _LocationEntryFormState();
}

class _LocationEntryFormState extends State<LocationEntryForm> {
  final formKey = new GlobalKey<FormState>();
  bool isLoading = false;
  // Define the text controllers to capture user data
  final TextEditingController _locationName = TextEditingController();
  final TextEditingController _fullAddress = TextEditingController();
  final TextEditingController _visitTime = TextEditingController();
  final TextEditingController _visitDate = TextEditingController();
  final TextEditingController _entryDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Form(
            key: formKey,
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
                  height: 20,
                ),
                Text(
                  'Location Entry',
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 35,
                ),
                //location name form field
                Container(
                  child: TextFormField(
                    controller: _locationName,
                    validator: (value) {
                      return value.isEmpty
                          ? "Please Enter a location name!"
                          : null;
                    },
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.white70,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        labelText: "Location Name (i.e: Meranti)",
                        labelStyle: Theme.of(context).textTheme.bodyText2),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                //full address form field
                Container(
                  child: TextFormField(
                    controller: _fullAddress,
                    validator: (value) {
                      return value.isEmpty
                          ? "Please Enter the full address of the location!"
                          : null;
                    },
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.white70,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        labelText: "Full Address",
                        labelStyle: Theme.of(context).textTheme.bodyText2),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                //visited time form field
                Container(
                  child: DateTimeFieldCustom(
                    timeController: _visitTime,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                //visited date form field
                Container(
                  child: DateFieldCustom(
                    dateController: _visitDate,
                    lableText: "Pick visit date!",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                //entry date form field
                Container(
                  child: DateFieldCustom(
                    dateController: _entryDate,
                    lableText: "Pick today's date!",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
