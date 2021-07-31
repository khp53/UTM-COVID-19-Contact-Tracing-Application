import 'package:flutter/material.dart';
import 'package:utmccta/Application/helpers/WebAppbar.dart';
import 'package:utmccta/BLL/healthStatusFormHandler.dart';

class HealthStatusUpdateForm extends StatefulWidget {
  final userName;
  final docID;

  const HealthStatusUpdateForm({Key key, this.userName, this.docID})
      : super(key: key);

  @override
  _HealthStatusUpdateFormState createState() => _HealthStatusUpdateFormState();
}

class _HealthStatusUpdateFormState extends State<HealthStatusUpdateForm> {
  TextEditingController ccController = TextEditingController();
  TextEditingController csController = TextEditingController();
  TextEditingController csyController = TextEditingController();
  TextEditingController gsController = TextEditingController();
  TextEditingController immunController = TextEditingController();
  TextEditingController trController = TextEditingController();

  HealthStatusFormHandler _formHandler = HealthStatusFormHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WebAppBar(
        title: 'Health Authority Dashboard  UTM CCTA',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(50),
          child: Column(
            children: [
              Text(
                'Update ${widget.userName}\'s Health Data.',
                textAlign: TextAlign.center,
                style: Theme.of(context).primaryTextTheme.headline2,
              ),
              SizedBox(
                height: 30,
              ),
              _buildBody(context),
              Center(child: _buildButton()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(context) {
    return Container(
        padding: EdgeInsets.all(50),
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: ccController,
                style: Theme.of(context).primaryTextTheme.bodyText1,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.black54,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  labelText: "Close Contact (YES / NO)",
                  labelStyle: TextStyle(color: Colors.black54),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            //Current Address Form Field.
            Container(
              child: TextFormField(
                controller: csController,
                style: Theme.of(context).primaryTextTheme.bodyText1,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.black54,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  labelText: "COVID Status (Positive / Negative)",
                  labelStyle: TextStyle(color: Colors.black54),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            //Postcode Form Field.
            Container(
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: csyController,
                style: Theme.of(context).primaryTextTheme.bodyText1,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.black54,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  labelText: "COVID Symptopms (YES / NO)",
                  labelStyle: TextStyle(color: Colors.black54),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Container(
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: gsController,
                style: Theme.of(context).primaryTextTheme.bodyText1,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.black54,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  labelText: "General Symptopms (YES / NO)",
                  labelStyle: TextStyle(color: Colors.black54),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Container(
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: immunController,
                style: Theme.of(context).primaryTextTheme.bodyText1,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.black54,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  labelText: "User Immunocompromised? (YES / NO)",
                  labelStyle: TextStyle(color: Colors.black54),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Container(
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: trController,
                style: Theme.of(context).primaryTextTheme.bodyText1,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.black54,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  labelText: "User Traveled? (YES / NO)",
                  labelStyle: TextStyle(color: Colors.black54),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildButton() {
    return Container(
      width: 150,
      child: MaterialButton(
        elevation: 0,
        onPressed: () {
          _formHandler.updateUserData(
              widget.docID,
              ccController.text.toUpperCase(),
              csController.text.toUpperCase(),
              csyController.text.toUpperCase(),
              gsController.text.toUpperCase(),
              immunController.text.toUpperCase(),
              trController.text.toUpperCase());

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Update Sucessful')));

          Navigator.pop(context);
        },
        color: Theme.of(context).accentColor,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'UPDATE',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(width: 8),
            Icon(
              Icons.check,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
