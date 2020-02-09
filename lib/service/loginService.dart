import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api.dart';

var dataLogin;

Future loginData(String username, String password) async{
  var res = await http.post( baseUrl+"login", body: {
    "username" : username,
    "password" : password
  });

  var jsonData = json.decode(res.body);
  dataLogin = jsonData;
  return jsonData;
} 