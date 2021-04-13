import 'package:utmccta/DLL/healthStatusDA.dart';

class HealthStatusFormHandler {
  HealthStatusDA _healthStatusDA = HealthStatusDA();

  // List of questions
  List<String> _questions = [
    '1. Are you exhibiting two or more symptoms as listed below?\n- Fever\n- Chills\n- Shivering\n- Body ache\n- Headache\n- Sore throat\n- Nausea or vomiting\n- Fatigue\n- Runny nose',
    '2. Besides the above symptoms, are you exhibiting  any of the symptoms listed below?\n- Cough\n- Difficulty breathing\n- Loss of smell\n- Loss of taste',
    '3. Are you immunocompromised or have health conditions such as asthma, diabetes, hypertension, heart disease or cancer?',
    '4. Have you attended any event or visited any area associated with COVID-19?',
    '5. Have you had closed contact with any COVID-19 patient or suspected patient with in past 14 days?',
    '6. Were you recently (with in 14 days) tested positive for COVID-19? Or State your COVID-19 current status.'
  ];

  // getter questions
  String getQuestionText(questionNo) {
    return _questions[questionNo];
  }

  // handle user health data
  collectUserHealthData(
      q1Answer, q2Answer, q3Answer, q4Answer, q5Answer, q6Answer) {
    String riskStatus = '';
    // check risk condition
    if (q1Answer == true) {
      riskStatus = 'Low risk few symptoms';
    } else if (q2Answer == true) {
      riskStatus = 'High risk few symptoms';
    } else if (q2Answer == true && q1Answer == true) {
      riskStatus = 'High risk all symptoms';
    } else if (q3Answer == true || q4Answer == true || q5Answer == true) {
      riskStatus = 'High risk no symptoms';
    } else if (q1Answer == true && q3Answer == true) {
      riskStatus = 'High risk few symptoms';
    } else if (q4Answer == true) {
      riskStatus = 'High risk no symptoms';
    } else if (q4Answer == true && q1Answer == true) {
      riskStatus = 'High risk few symptoms';
    } else if (q4Answer == true && q2Answer == true) {
      riskStatus = 'High risk few symptoms';
    } else if (q4Answer == true && q1Answer == true && q2Answer == true) {
      riskStatus = 'High risk all symptoms';
    } else if (q6Answer == true || q5Answer == true || q4Answer == true) {
      riskStatus = 'High risk no symptoms';
    } else {
      riskStatus = 'Low risk no symptoms';
    }

    Map<String, dynamic> userHealthMap = {
      "generalSymptoms": q1Answer,
      "covidSymptoms": q2Answer,
      "immunocompromised": q3Answer,
      "traveled": q4Answer,
      "closeContact": q5Answer,
      "covidStatus": q6Answer,
      "riskStatus": riskStatus
    };
    _healthStatusDA.uploadUserInfo(userHealthMap);
  }
}
