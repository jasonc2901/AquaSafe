import 'dart:async';
import 'dart:convert';
import 'package:FinalYearProject/models/BugReportModel.dart';
import 'package:http/http.dart' as http;

const url = "https://water-pollution-app.herokuapp.com/api/bugReports?";

class ReportBugToDb {
  Future<BugReportModel> postBugReport(String username, String subject,
      String body, String frequency, String date, String email) async {
    var finalUrl = url +
        "username=" +
        username +
        "&&subject=" +
        subject +
        "&&body=" +
        body +
        "&&frequency=" +
        frequency +
        "&&date=" +
        date +
        "&&email=" +
        email;

    var response = await http.post(finalUrl);
    var json = jsonDecode(response.body);

    var riversJson = BugReportModel.fromJson(json);

    return riversJson;
  }
}
