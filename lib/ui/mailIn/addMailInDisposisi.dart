import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simper_walikota/bloc/mailBloc.dart';
import 'package:simper_walikota/service/disposisiService.dart';
import 'package:simper_walikota/service/notifcationServiceDisposisi.dart';

class AddMailInDisposisi extends StatefulWidget {
  final String idJabatan;
  final String idDisposisi;
  final String idSurat;
  final String skpdPengirim;
  final String noAgenda;
  final String tglMenerima;

  AddMailInDisposisi(
      {this.idJabatan,
      this.idDisposisi,
      this.idSurat,
      this.skpdPengirim,
      this.tglMenerima,
      this.noAgenda});

  @override
  _AddMailInDisposisiState createState() => _AddMailInDisposisiState();
}

class _AddMailInDisposisiState extends State<AddMailInDisposisi> {
  final Future<SharedPreferences> _sharedPref = SharedPreferences.getInstance();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String jabatanId;
  String userId;

  TextEditingController _textEditingController = TextEditingController();

  getIdJabatan() async {
    final sha = await _sharedPref;
    jabatanId = sha.getString('jabatan_id');
    userId = sha.getString('id');
    setState(() {});
  }

  setPendisposisi() async {
    final sha = await _sharedPref;
    sha.setString("pendisposisi", "$jabatanId${widget.idDisposisi}");
  }

  getNotif() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  // SHOW NOTIF IOS AND ANDROID
  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text(title),
        content: new Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: new Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
      ),
    );
  }

  Future onSelectNotification(String payload) async {
    // await removeBadge();
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  Future displayNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'add id', 'add', 'add description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, '$title', '$body', platformChannelSpecifics,
        payload: "add disposition");
  }

  @override
  void initState() {
    super.initState();
    getIdJabatan();
    getNotif();
  }

  List<bool> _valueOfData = [];

  itreablesBoolean(int _valueChecked) {
    for (var i = 0; i < _valueChecked; i++) {
      _valueOfData.add(false);
    }
  }

  // Data Tujuan Disposisi
  List _tujuanDisposisi;

  // Add New Perintah
  final Map<String, String> dataDisposisi = {};
  final List<Map> dispositionCommand = [];

  // ADD DATA TO FIRESTORE
  _createData(List dataTujuanDisposisi) async {
    for (var i = 0; i < dispositionCommand.length; i++) {
      final document = Firestore.instance
          .collection(dispositionCommand[i]["userTujuan"])
          .document(dispositionCommand[i]["idSurat"]);

      Map<String, dynamic> data = {
        'idDisposisi': dataTujuanDisposisi[i]["disposisi_id"],
        'title': dispositionCommand[i]["title"],
        'noAgenda': dispositionCommand[i]["noAgenda"],
        'skpdPengirim': dispositionCommand[i]["skpdPengirim"],
        'tglTerima': dispositionCommand[i]["tglTerima"]
      };

      document.setData(data).whenComplete(() {
        print("Data Berhasil Disimpan");
        return SnackBar(
          content: Text("data sudah ditambahkan"),
        );
      });

      // SET NOTIF TO DESTINATIONS
      print("Subscripe Tujuan Notif : ${dispositionCommand[i]["userTujuan"]}");
      final response = await MessagingDisposisi.sendToAll(
          title: "Surat Masuk Disposisi",
          body:
              "${dispositionCommand[i]["skpdPengirim"]}/${dispositionCommand[i]["idDisposisi"]}",
          speceficttopic: dispositionCommand[i]["userTujuan"]
          // fcmToken: fcmToken,
          );

      if (response.statusCode != 200) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content:
              Text('[${response.statusCode}] Error message: ${response.body}'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: ListView(children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                    icon: Icon(LineIcons.arrow_left, size: 30.0,),
                  
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Tambah Disposisi",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18.0)),
                      SizedBox(height: 4.0),
                      Text("Tambah atau buat disposisi ke bawahan anda",
                          style: TextStyle(fontSize: 14.0))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          SizedBox(
            height: 20.0,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text("Tujuan Disposisi:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blueAccent))),
          Divider(),
          FutureBuilder(
            future: getDataTujuanMailIn(
                widget.idJabatan, widget.idDisposisi, widget.idSurat),
            builder: (context, snap) {
              if (snap.hasData) {
                if (snap.data["data"] == null) {
                  return Center(child: Text("Tidak Dapat Mendisposisi"));
                } else {
                  itreablesBoolean(snap.data["data"].length);
                  return ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snap.data["data"].length,
                    itemBuilder: (context, i) {
                      return Container(
                          child: CheckboxListTile(
                        onChanged: (newValue) {
                          _tujuanDisposisi = snap.data["perintah"];

                          if (_valueOfData[i] == false) {
                            setState(() {
                              _valueOfData[i] = true;
                            });
                            showCupertinoDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    // shape: RoundedRectangleBorder(
                                    //     borderRadius:
                                    //         BorderRadius.circular(10.0)),
                                    title: Text("Perintah Disposisi"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            child: DropdownButtonHideUnderline(
                                                child: Consumer<
                                                    ChangeCommandDisposistion>(
                                              builder: (context, command, _) {
                                                return DropdownButton(
                                                    hint: Text("Pilih Item"),
                                                    value: command.value,
                                                    onChanged: (newValue) {
                                                      print(command.value);
                                                      command.value = newValue;
                                                      print(command.value);
                                                    },
                                                    items: _tujuanDisposisi
                                                        .map((value) {
                                                      return DropdownMenuItem(
                                                        value: value,
                                                        child: Text(value,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    10.0)),
                                                      );
                                                    }).toList());
                                              },
                                            ))),
                                        SizedBox(height: 10.0),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: TextField(
                                            controller: _textEditingController,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Instruksi Tambahan",
                                                hintStyle: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 10.0)),
                                          ),
                                        )
                                      ],
                                    ),
                                    actions: <Widget>[
                                      Consumer<ChangeCommandDisposistion>(
                                        builder: (context, command, _) {
                                          return MaterialButton(
                                            onPressed: () {
                                              print(
                                                  "Awal api : $dataDisposisi");
                                              print(
                                                  "Awal firebase : $dispositionCommand");

                                              setState(() {
                                                dataDisposisi.addAll({
                                                  "id_surat[]${snap.data["data"][i]["id"]}":
                                                      snap.data["id_surat"],
                                                  "jabatan_asal[]${snap.data["data"][i]["id"]}":
                                                      jabatanId,
                                                  "jabatan_tujuan[]${snap.data["data"][i]["id"]}":
                                                      snap.data["data"][i]
                                                          ["jabatan_id"],
                                                  "user_asal[]${snap.data["data"][i]["id"]}":
                                                      userId,
                                                  "user_tujuan[]${snap.data["data"][i]["id"]}":
                                                      snap.data["data"][i]
                                                          ["id"],
                                                  "instruksi[]${snap.data["data"][i]["id"]}":
                                                      "${command.value},${_textEditingController.text}",
                                                  "disposisi_id[]${snap.data["data"][i]["id"]}":
                                                      snap.data["id_disposisi"],
                                                });

                                                dispositionCommand.add({
                                                  "idSurat": widget.idSurat,
                                                  "userTujuan": snap
                                                      .data["data"][i]["id"],
                                                  "idDisposisi":
                                                      widget.idDisposisi,
                                                  "title":
                                                      "Surat Masuk Disposisi",
                                                  "noAgenda": widget.noAgenda,
                                                  "skpdPengirim":
                                                      widget.skpdPengirim,
                                                  "tglTerima":
                                                      widget.tglMenerima
                                                });
                                              });
                                              print(
                                                  "Awal api 2 : $dataDisposisi");
                                              print(
                                                  "Awal firebase 2 : $dispositionCommand");
                                              Navigator.of(context).pop();
                                              _textEditingController.clear();
                                            },
                                            color: Colors.amber[600],
                                            child: Text("OK",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          );
                                        },
                                      )
                                    ],
                                  );
                                });
                          } else {
                            setState(() {
                              _valueOfData[i] = false;
                            });
                            dataDisposisi.remove(
                                "id_surat[]${snap.data["data"][i]["id"]}");
                            dataDisposisi.remove(
                                "jabatan_asal[]${snap.data["data"][i]["id"]}");
                            dataDisposisi.remove(
                                "jabatan_tujuan[]${snap.data["data"][i]["id"]}");
                            dataDisposisi.remove(
                                "user_asal[]${snap.data["data"][i]["id"]}");
                            dataDisposisi.remove(
                                "user_tujuan[]${snap.data["data"][i]["id"]}");
                            dataDisposisi.remove(
                                "instruksi[]${snap.data["data"][i]["id"]}");
                            dataDisposisi.remove(
                                "disposisi_id[]${snap.data["data"][i]["id"]}");

                            _textEditingController.clear();

                            dispositionCommand.removeAt(i);

                            print("Awal api 3 : $dataDisposisi");
                            print("Awal firebase 3 : $dispositionCommand");
                          }
                          // setState(() {
                          //   _valueOfData[i] = newValue;
                          // });
                        },
                        value: _valueOfData[i],
                        title: Text(snap.data["data"][i]["first_name"],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54)),
                        subtitle: Text(snap.data["data"][i]["jabatan_name"]),
                      ));
                    },
                  );
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(10.0),
            child: MaterialButton(
              onPressed: () {
                if (dataDisposisi.isEmpty) {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: Text("Status Disposisi"),
                            content: Container(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                  "Silahkan Pilih Tujuan Disposisi Terlebih Dahulu"),
                            ),
                            actions: <Widget>[
                              MaterialButton(
                                color: Colors.amber[600],
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Close",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ));
                } else {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return FutureBuilder(
                          future: addDispositionData(dataDisposisi),
                          builder: (context, snap) {
                            if (snap.hasData) {
                              print("snapshot : ${snap.data}");
                              print("data : $addDisposition");

                              _createData(snap.data["data"]);

                              return CupertinoAlertDialog(
                                title: Text("Status Disposisi"),
                                content: Container(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(snap.data["message"]),
                                ),
                                actions: <Widget>[
                                  MaterialButton(
                                    color: Colors.amber[600],
                                    onPressed: () {
                                      setPendisposisi();
                                      setState(() {
                                        dataDisposisi.clear();
                                      });
                                      displayNotification("Status Disposisi",
                                          snap.data["message"]);
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Tutup",
                                        style: TextStyle(color: Colors.white)),
                                  )
                                ],
                              );
                            } else {
                              print("snapshot : ${snap.data}");
                              print("data : $addDisposition");
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        );
                      });
                }
              },
              color: Colors.green,
              child: Text("Kirim", style: TextStyle(color: Colors.white)),
            ),
          )
        ]),
      ),
    );
  }

  // Future deleteNotif() async {
  //   await flutterLocalNotificationsPlugin.cancelAll();
  // }
}
