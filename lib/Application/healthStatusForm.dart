import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:utmccta/Application/helpers/main_button.dart';
import 'package:utmccta/BLL/healthStatusFormHandler.dart';

class HealthStatusForm extends StatefulWidget {
  @override
  _HealthStatusFormState createState() => _HealthStatusFormState();
}

class _HealthStatusFormState extends State<HealthStatusForm> {
  HealthStatusFormHandler _healthStatusFormHandler = HealthStatusFormHandler();

  //loading status
  bool isLoading = false;

  // radio button on click value
  int _question1Value = 1;
  int _question2Value = 1;
  int _question3Value = 1;
  int _question4Value = 1;
  int _question5Value = 1;
  int _question6Value = 1;

  // send data to handller
  saveHealthStatusData() {
    setState(() {
      isLoading = true;
    });
    _healthStatusFormHandler.collectUserHealthData(
        _question1Value == 1 ? true : false,
        _question2Value == 1 ? true : false,
        _question3Value == 1 ? true : false,
        _question4Value == 1 ? true : false,
        _question5Value == 1 ? true : false,
        _question6Value == 1 ? true : false);
    Navigator.pushReplacementNamed(context, '/home');
    setState(() {
      isLoading = false;
    });
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xff131313),
            title: Text(
              "Registration Complete!",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: FlareActor('assets/img/Done animation.flr',
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: "Done"),
            ),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text(
            'Questions',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        body: SingleChildScrollView(
          child: !isLoading
              ? Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      // radio button value
                      _q1RadioButton(
                        title: "No",
                        value: 0,
                        onChanged: (newValue) =>
                            setState(() => _question1Value = newValue),
                      ),
                      _q1RadioButton(
                        title: "Yes",
                        value: 1,
                        onChanged: (newValue) =>
                            setState(() => _question1Value = newValue),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 35,
                      ),
                      // question 2
                      Container(
                        child: Text(
                          _healthStatusFormHandler.getQuestionText(1),
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 45,
                      ),
                      // radio button value
                      _q2RadioButton(
                        title: "No",
                        value: 0,
                        onChanged: (newValue) =>
                            setState(() => _question2Value = newValue),
                      ),
                      _q2RadioButton(
                        title: "Yes",
                        value: 1,
                        onChanged: (newValue) =>
                            setState(() => _question2Value = newValue),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 35,
                      ),
                      // question 3
                      Container(
                        child: Text(
                          _healthStatusFormHandler.getQuestionText(2),
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 45,
                      ),
                      // radio button value
                      _q3RadioButton(
                        title: "No",
                        value: 0,
                        onChanged: (newValue) =>
                            setState(() => _question3Value = newValue),
                      ),
                      _q3RadioButton(
                        title: "Yes",
                        value: 1,
                        onChanged: (newValue) =>
                            setState(() => _question3Value = newValue),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 35,
                      ),
                      // question 4
                      Container(
                        child: Text(
                          _healthStatusFormHandler.getQuestionText(3),
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 45,
                      ),
                      // radio button value
                      _q4RadioButton(
                        title: "No",
                        value: 0,
                        onChanged: (newValue) =>
                            setState(() => _question4Value = newValue),
                      ),
                      _q4RadioButton(
                        title: "Yes",
                        value: 1,
                        onChanged: (newValue) =>
                            setState(() => _question4Value = newValue),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 35,
                      ),
                      // question 5
                      Container(
                        child: Text(
                          _healthStatusFormHandler.getQuestionText(4),
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 45,
                      ),
                      // radio button value
                      _q5RadioButton(
                        title: "No",
                        value: 0,
                        onChanged: (newValue) =>
                            setState(() => _question5Value = newValue),
                      ),
                      _q5RadioButton(
                        title: "Yes",
                        value: 1,
                        onChanged: (newValue) =>
                            setState(() => _question5Value = newValue),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 35,
                      ),
                      // question 6
                      Container(
                        child: Text(
                          _healthStatusFormHandler.getQuestionText(5),
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 45,
                      ),
                      // radio button value
                      _q6RadioButton(
                        title: "No / Negative",
                        value: 0,
                        onChanged: (newValue) =>
                            setState(() => _question6Value = newValue),
                      ),
                      _q6RadioButton(
                        title: "Yes / Positive",
                        value: 1,
                        onChanged: (newValue) =>
                            setState(() => _question6Value = newValue),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 35,
                      ),
                    ],
                  ),
                )
              : Center(child: CircularProgressIndicator()),
        ),
        bottomNavigationBar: Container(
            child: TextButton(
          onPressed: () {
            saveHealthStatusData();
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: mainButton(),
            child: Center(
                child: Text('Complete Registration',
                    style: TextStyle(color: Colors.white, fontSize: 15))),
          ),
        )),
      ),
    );
  }

  // build q1 radio list
  Widget _q1RadioButton({String title, int value, Function onChanged}) {
    return Theme(
      data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.white54),
      child: RadioListTile(
        contentPadding:
            EdgeInsets.only(right: MediaQuery.of(context).size.width / 2),
        value: value,
        groupValue: _question1Value,
        onChanged: onChanged,
        title: Text(title, style: Theme.of(context).textTheme.bodyText1),
      ),
    );
  }

  // buiild q2 radio list
  Widget _q2RadioButton({String title, int value, Function onChanged}) {
    return Theme(
      data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.white54),
      child: RadioListTile(
        contentPadding:
            EdgeInsets.only(right: MediaQuery.of(context).size.width / 2),
        value: value,
        groupValue: _question2Value,
        onChanged: onChanged,
        title: Text(title, style: Theme.of(context).textTheme.bodyText1),
      ),
    );
  }

  // buiild q3 radio list
  Widget _q3RadioButton({String title, int value, Function onChanged}) {
    return Theme(
      data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.white54),
      child: RadioListTile(
        contentPadding:
            EdgeInsets.only(right: MediaQuery.of(context).size.width / 2),
        value: value,
        groupValue: _question3Value,
        onChanged: onChanged,
        title: Text(title, style: Theme.of(context).textTheme.bodyText1),
      ),
    );
  }

  // buiild q4 radio list
  Widget _q4RadioButton({String title, int value, Function onChanged}) {
    return Theme(
      data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.white54),
      child: RadioListTile(
        contentPadding:
            EdgeInsets.only(right: MediaQuery.of(context).size.width / 2),
        value: value,
        groupValue: _question4Value,
        onChanged: onChanged,
        title: Text(title, style: Theme.of(context).textTheme.bodyText1),
      ),
    );
  }

  // buiild q5 radio list
  Widget _q5RadioButton({String title, int value, Function onChanged}) {
    return Theme(
      data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.white54),
      child: RadioListTile(
        contentPadding:
            EdgeInsets.only(right: MediaQuery.of(context).size.width / 2),
        value: value,
        groupValue: _question5Value,
        onChanged: onChanged,
        title: Text(title, style: Theme.of(context).textTheme.bodyText1),
      ),
    );
  }

  // buiild q6 radio list
  Widget _q6RadioButton({String title, int value, Function onChanged}) {
    return Theme(
      data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.white54),
      child: RadioListTile(
        contentPadding:
            EdgeInsets.only(right: MediaQuery.of(context).size.width / 2),
        value: value,
        groupValue: _question6Value,
        onChanged: onChanged,
        title: Text(title, style: Theme.of(context).textTheme.bodyText1),
      ),
    );
  }
}
