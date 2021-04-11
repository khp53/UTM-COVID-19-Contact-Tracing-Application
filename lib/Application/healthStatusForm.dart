import 'package:flutter/material.dart';
import 'package:utmccta/BLL/healthStatusFormHandler.dart';

class HealthStatusForm extends StatefulWidget {
  @override
  _HealthStatusFormState createState() => _HealthStatusFormState();
}

class _HealthStatusFormState extends State<HealthStatusForm> {
  HealthStatusFormHandler _healthStatusFormHandler = HealthStatusFormHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Questions'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 25),
          child: Column(
            children: <Widget>[
              // declaration text
              Container(
                child: Text(
                  'Please answer the questions to complete the registration! This information will only be accesed by an UTM admin, if you are tested positive with COVID-19.',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 35,
              ),
              // question 1
              Container(
                child: Text(
                  _healthStatusFormHandler.getQuestionText(0),
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 45,
              ),
              // radio button
            ],
          ),
        ),
      ),
    );
  }
}
