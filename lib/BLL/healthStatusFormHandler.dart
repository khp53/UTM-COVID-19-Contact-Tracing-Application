import 'package:utmccta/DLL/healthStatusDA.dart';

class HealthStatusFormHandler {
  HealthStatusDA _healthStatusDA = HealthStatusDA();

  // List of questions
  int _questionNumber = 0;

  List<String> _questions = [
    '1. Are you exhibiting two or more symptoms as listed below?\n- Fever\n- Chills\n- Shivering\n- Body ache\n- Headache\n- Sore throat\n- Nausea or vomiting\n- Fatigue\n- Runny nose',
    '2. Besides the above symptoms, are you exhibiting  any of the symptoms listed below?\n- Cough\n- Difficulty breathing\n- Loss of smell\n- Loss of taste',
    '3. Are you immunocompromised or have health conditions such as asthma, diabetes, hypertension, heart disease or cancer?',
    '4. Are you immunocompromised or have health conditions such as asthma, diabetes, hypertension, heart disease or cancer?',
    '5. Have you attended any event / area associated with COVID-19?',
    '6. Have you had closed contact with any COVID-19 patient or suspected patient with in past 14 days?',
    '7. Were you recently (with in 14 days) tested positive for COVID-19? / state your COVID-19 current status.'
  ];

  // getter questions
  String getQuestionText(questionNo) {
    return _questions[_questionNumber];
  }

  // handle user health data
  collectUserHealthData() {}
}
