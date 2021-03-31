import 'dart:async';
import 'dart:convert';
import 'package:FinalYearProject/models/GetNumPendingModel.dart';
import 'package:http/http.dart' as http;

const url = "https://water-pollution-app.herokuapp.com/api/getNumPending?";

class GetNumPending {
  Future<GetNumPendingModel> fetchNumPending(String username) async {
    var finalUrl = url + "username=" + username;

    var response = await http.get(finalUrl);
    var json = jsonDecode(response.body);

    var numPendingJson = GetNumPendingModel.fromJson(json);

    return numPendingJson;
  }
}
