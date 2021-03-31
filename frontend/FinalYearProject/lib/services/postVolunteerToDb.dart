import 'dart:async';
import 'dart:convert';
import 'package:FinalYearProject/models/VolunteerModel.dart';
import 'package:http/http.dart' as http;

const url = "https://water-pollution-app.herokuapp.com/api/volunteerList?";

class ReportVolunteerToDb {
  Future<VolunteerModel> postVolunteer(
      String username, String location, String date, String email) async {
    var finalUrl = url +
        "username=" +
        username +
        "&&location=" +
        location +
        "&&date=" +
        date +
        "&&email=" +
        email;

    var response = await http.post(finalUrl);
    var json = jsonDecode(response.body);

    var volunteerJson = VolunteerModel.fromJson(json);

    return volunteerJson;
  }
}
