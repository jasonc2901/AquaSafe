import 'dart:async';
import 'dart:convert';
import 'package:FinalYearProject/models/GetReportsModel.dart';
import 'package:http/http.dart' as http;

const url = "https://water-pollution-app.herokuapp.com/api/userReports?";

class GetReportFromDb {
  Future<GetReportsModel> fetchReport(String username) async {
    var finalUrl = url + "username=" + username;

    var response = await http.get(finalUrl);
    var json = jsonDecode(response.body);

    var reportsJson = GetReportsModel.fromJson(json);

    return reportsJson;
  }
}
