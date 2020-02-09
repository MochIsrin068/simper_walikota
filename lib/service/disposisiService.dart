import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api.dart';

var dataDisposisiMasuk;

Future disposisiMasukData(String idUser) async{
  var res = await http.get(baseUrl+"list_surat_masuk?id_user=$idUser");

  var jsonData = json.decode(res.body);
  dataDisposisiMasuk = jsonData;
  return jsonData;
} 



//  ADD DISPOSITION

var addDisposition;

Future addDispositionData(Map<String, String> data) async {
  for (var i = 0; i < data.length; i++) {}

  var res = await http.post(baseUrl + "buat_disposisi", body: data);

  var jsonData = json.decode(res.body);
  addDisposition = jsonData;
  return jsonData;
}


// DETAIL DISPOSISI
var dataDetailDisposisiMasuk;

Future detailDisposisiMasukData(String disposisiId) async {
  var res =
      await http.get(baseUrl + "detail_disposisi?id_disposisi=$disposisiId");

  var jsonData = json.decode(res.body);
  dataDetailDisposisiMasuk = jsonData;
  return jsonData;
}


// NEWS MAIL FROM LOGIN
var newsMail;

Future newsMailData(String username, String password) async{
  var res = await http.post( baseUrl+"login", body: {
    "username" : username,
    "password" : password
  });

  var jsonData = json.decode(res.body);
  newsMail = jsonData["suratbaru"];
  return jsonData["suratbaru"];
} 


// SELESAI DISPOSISI
var selesaikanDisposisiMasuk;

Future selesaikanDisposisiMasukData(String disposisiId, String disposisiStatus) async{
  var res = await http.post( baseUrl+"selesai_disposisi", body: {
    "disposisi_id" : disposisiId,
    "disposisi_status" : disposisiStatus
  });

  var jsonData = json.decode(res.body);
  selesaikanDisposisiMasuk = jsonData;
  return jsonData;
} 


// SURAT MASUK DISPOSISI
var suratMasukSelesai;

Future suratMasukSelesaiData(String idUser) async{
  var res = await http.get(baseUrl+"list_surat_selesai?id_user=$idUser");
  var jsonData = json.decode(res.body);
  suratMasukSelesai = jsonData;
  return jsonData;
} 

// SURAT TERDIDPOSISI
var suratTerdisposisi;

Future suratTerdisposisiData(String idUser) async{
  var res = await http.get(baseUrl+"list_surat_selesai?id_user=$idUser");
  var jsonData = json.decode(res.body);
  suratTerdisposisi = jsonData;
  return jsonData;
} 


// TUJUAN DISPOSISI or TARIK DATA BAWAHAN
var tujuanMailInData;

Future getDataTujuanMailIn(String idJabatan, String idDisposisi, String idSurat) async {
  var res = await http.get(baseUrl +
      "user_disposisi?id_jabatan=$idJabatan&id_disposisi=$idDisposisi&id_surat=$idSurat");
  var jsonData = json.decode(res.body);

  tujuanMailInData = jsonData;
  return jsonData;
}
