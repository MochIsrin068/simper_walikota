import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api.dart';

var profile;

Future profileData(String idUser) async {
  var res = await http.get(baseUrl + "profile?id_user=$idUser");
  var jsonData = json.decode(res.body);
  profile = jsonData["data"][0];
  return jsonData["data"][0];
}

// EDIT PRFILE

var editProfile;

Future editProfiledata(String idUser, String username, String firstName,
    String lastName, String password) async {
  var res = await http.post(baseUrl + "update_profile", body: {
    "id_user": idUser,
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
    // "email": email,
    // "phone": phone,
    "password": password,
  });

  var jsonData = json.decode(res.body);
  editProfile = jsonData;
  return jsonData;
}
