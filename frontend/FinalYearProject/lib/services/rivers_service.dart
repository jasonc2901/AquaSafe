import 'dart:async';
import 'dart:convert';
import 'package:FinalYearProject/models/RiverModel.dart';
import 'package:http/http.dart' as http;

const url = "https://water-pollution-app.herokuapp.com/api/waterBodies";

class RiversService {
  Future<RiverModel> getRivers() async {
    var response = await http.get(url);
    var json = jsonDecode(response.body);

    var riversJson = RiverModel.fromJson(json);

    return riversJson;
  }
}
