import 'dart:async';
import 'dart:convert';
import 'package:FinalYearProject/models/getNumVolunteersModel.dart';
import 'package:http/http.dart' as http;

const url =
    "https://water-pollution-app.herokuapp.com/api/getNumVolunteers?location=";

class GetNumVolunteers {
  Future<GetNumVolunteersModel> fetchNumVolunteers(String location) async {
    String finalUrl = url + location;
    print(finalUrl);

    var response = await http.get(finalUrl);

    var json = jsonDecode(response.body);

    var numVolunteersJson = GetNumVolunteersModel.fromJson(json);

    return numVolunteersJson;
  }
}
