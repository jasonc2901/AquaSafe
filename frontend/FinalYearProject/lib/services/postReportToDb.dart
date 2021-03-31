import 'dart:async';
import 'dart:convert';
import 'package:FinalYearProject/models/ReportModel.dart';
import 'package:http/http.dart' as http;

const url = "https://water-pollution-app.herokuapp.com/api/userReports?";

class ReportToDb {
  Future<ReportModel> postReport(String username, String subject, String body,
      String date, String email, String pending) async {
    var finalUrl = url +
        "username=" +
        username +
        "&&subject=" +
        subject +
        "&&body=" +
        body +
        "&&date=" +
        date +
        "&&email=" +
        email +
        "&&pending=" +
        pending;

    var response = await http.post(finalUrl);
    var json = jsonDecode(response.body);

    var riversJson = ReportModel.fromJson(json);

    return riversJson;
  }
}
