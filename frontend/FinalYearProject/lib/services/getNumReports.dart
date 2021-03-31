import 'dart:async';
import 'dart:convert';
import 'package:FinalYearProject/models/GetNumReportsModel.dart';
import 'package:http/http.dart' as http;

const url = "https://water-pollution-app.herokuapp.com/api/getNumReports?";

class GetNumReports {
  Future<GetNumReportsModel> fetchNumReports(String username) async {
    var finalUrl = url + "username=" + username;

    var response = await http.get(finalUrl);
    var json = jsonDecode(response.body);

    var numReportsJson = GetNumReportsModel.fromJson(json);

    return numReportsJson;
  }
}
