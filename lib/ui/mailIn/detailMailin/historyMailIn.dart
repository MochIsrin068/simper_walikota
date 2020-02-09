import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simper_walikota/service/disposisiService.dart';

import '../addMailInDisposisi.dart';

class HistoryMailIn extends StatefulWidget {
  final List treePosition;
  final String instruksi;
  final String disposisiId;
  final String suratId;
  final String skpdPengirim;
  final String noAgenda;
  final String tglTerima;
  final String statusDisposisi;

  HistoryMailIn(
      {this.treePosition,
      this.instruksi,
      this.disposisiId,
      this.suratId,
      this.skpdPengirim,
      this.noAgenda,
      this.tglTerima,
      this.statusDisposisi});

  @override
  _HistoryMailInState createState() => _HistoryMailInState();
}

class _HistoryMailInState extends State<HistoryMailIn> {
  final Future<SharedPreferences> _sharedPref = SharedPreferences.getInstance();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String jabatanId;
  String userId;

  getIdJabatan() async {
    final sha = await _sharedPref;
    jabatanId = sha.getString('jabatan_id');
    userId = sha.getString('id');
    setState(() {});
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

  Future displayNotifications(String title, String body) async {
    print("Local Notif From Selesai Button");

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'history id', 'history channel', 'history channel desc',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, '$title', '$body', platformChannelSpecifics, payload: "seleikan surat");
  }

  @override
  void initState() {
    super.initState();
    getIdJabatan();
    getNotif();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: <Widget>[
        Container(
            child: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.treePosition.length,
          itemBuilder: (context, i) {
            return ListView(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0),
                  color: Colors.white,
                  margin: EdgeInsets.only(bottom: 4.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: widget.treePosition[i]["disposisi_status"] ==
                                    "0"
                                ? Colors.red[300]
                                : widget.treePosition[i]["disposisi_status"] ==
                                        "1"
                                    ? Colors.amber[400]
                                    : Colors.greenAccent,
                            borderRadius: BorderRadius.circular(6.0)),
                        height: 30.0,
                        width: 30.0,
                        child: Icon(
                          widget.treePosition[i]["disposisi_status"] == "0"
                              ? FontAwesomeIcons.eyeSlash
                              : widget.treePosition[i]["disposisi_status"] ==
                                      "1"
                                  ? FontAwesomeIcons.clock
                                  : FontAwesomeIcons.check,
                          color: Colors.white,
                          size: 14.0,
                        ),
                      ),
                      SizedBox(width: 6.0),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.treePosition[i]["jabatan_name"],
                              style: TextStyle(fontSize: 14.0),
                            ),
                            Text(
                              widget.treePosition[i]["disposisi_status"] == "0"
                                  ? "Belum Diproses"
                                  : widget.treePosition[i]
                                              ["disposisi_status"] ==
                                          "1"
                                      ? "Disposisi Kebawah"
                                      : "Selesai",
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                /////////////////////// 2/////////////////
                widget.treePosition[i]["length"] == 0
                    ? Container()
                    : ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.treePosition[i]["length"],
                        itemBuilder: (context, i2) {
                          return ListView(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    top: 8.0,
                                    right: 8.0,
                                    bottom: 8.0,
                                    left: 20.0),
                                color: Colors.white,
                                margin: EdgeInsets.only(bottom: 4.0),
                                child: Wrap(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: widget.treePosition[i]["child"]
                                                          [i2]
                                                      ["disposisi_status"] ==
                                                  "0"
                                              ? Colors.red[300]
                                              : widget.treePosition[i]["child"]
                                                              [i2][
                                                          "disposisi_status"] ==
                                                      "1"
                                                  ? Colors.amber[400]
                                                  : Colors.greenAccent,
                                          borderRadius:
                                              BorderRadius.circular(6.0)),
                                      height: 30.0,
                                      width: 30.0,
                                      child: Icon(
                                        widget.treePosition[i]["child"][i2]
                                                    ["disposisi_status"] ==
                                                "0"
                                            ? FontAwesomeIcons.eyeSlash
                                            : widget.treePosition[i]["child"]
                                                            [i2]
                                                        ["disposisi_status"] ==
                                                    "1"
                                                ? FontAwesomeIcons.clock
                                                : FontAwesomeIcons.check,
                                        color: Colors.white,
                                        size: 14.0,
                                      ),
                                    ),
                                    SizedBox(width: 6.0),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            widget.treePosition[i]["child"][i2]
                                                ["jabatan_name"],
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                          Text(
                                            widget.treePosition[i]["child"][i2]
                                                        ["disposisi_status"] ==
                                                    "0"
                                                ? "Belum Diproses"
                                                : widget.treePosition[i]
                                                                ["child"][i2][
                                                            "disposisi_status"] ==
                                                        "1"
                                                    ? "Disposisi Kebawah"
                                                    : "Selesai",
                                            style: TextStyle(fontSize: 12.0),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              /////////////////////// 3/////////////////
                              widget.treePosition[i]["child"][i2]["length"] == 0
                                  ? Container()
                                  : ListView.builder(
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: widget.treePosition[i]["child"]
                                          [i2]["length"],
                                      itemBuilder: (context, i3) {
                                        return ListView(
                                          physics: ScrollPhysics(),
                                          shrinkWrap: true,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 8.0,
                                                  right: 8.0,
                                                  bottom: 8.0,
                                                  left: 40.0),
                                              color: Colors.white,
                                              margin:
                                                  EdgeInsets.only(bottom: 4.0),
                                              child: Wrap(
                                                children: <Widget>[
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: widget.treePosition[i]["child"]
                                                                            [i2]
                                                                        ["child"][i3]
                                                                    [
                                                                    "disposisi_status"] ==
                                                                "0"
                                                            ? Colors.red[300]
                                                            : widget.treePosition[i]["child"][i2]["child"][i3]["disposisi_status"] ==
                                                                    "1"
                                                                ? Colors
                                                                    .amber[400]
                                                                : Colors
                                                                    .greenAccent,
                                                        borderRadius:
                                                            BorderRadius.circular(6.0)),
                                                    height: 30.0,
                                                    width: 30.0,
                                                    child: Icon(
                                                      widget.treePosition[i]["child"]
                                                                          [i2]
                                                                      ["child"][i3][
                                                                  "disposisi_status"] ==
                                                              "0"
                                                          ? FontAwesomeIcons
                                                              .eyeSlash
                                                          : widget.treePosition[i]["child"]
                                                                          [i2]["child"][i3][
                                                                      "disposisi_status"] ==
                                                                  "1"
                                                              ? FontAwesomeIcons
                                                                  .clock
                                                              : FontAwesomeIcons
                                                                  .check,
                                                      color: Colors.white,
                                                      size: 14.0,
                                                    ),
                                                  ),
                                                  SizedBox(width: 6.0),
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          widget.treePosition[i]
                                                                      ["child"][
                                                                  i2]["child"][i3]
                                                              ["jabatan_name"],
                                                          style: TextStyle(
                                                              fontSize: 14.0),
                                                        ),
                                                        Text(
                                                          widget.treePosition[i]["child"]
                                                                              [i2]
                                                                          ["child"][i3]
                                                                      [
                                                                      "disposisi_status"] ==
                                                                  "0"
                                                              ? "Belum Diproses"
                                                              : widget.treePosition[i]
                                                                              [
                                                                              "child"][i2]["child"][i3]
                                                                          [
                                                                          "disposisi_status"] ==
                                                                      "1"
                                                                  ? "Disposisi Kebawah"
                                                                  : "Selesai",
                                                          style: TextStyle(
                                                              fontSize: 12.0),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),

                                            /////////////////////// 4/////////////////
                                            widget.treePosition[i]["child"][i2]
                                                            ["child"][i3]
                                                        ["length"] ==
                                                    0
                                                ? Container()
                                                : ListView.builder(
                                                    physics: ScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: widget
                                                                .treePosition[i]
                                                            ["child"][i2]
                                                        ["child"][i3]["length"],
                                                    itemBuilder: (context, i4) {
                                                      return ListView(
                                                        physics:
                                                            ScrollPhysics(),
                                                        shrinkWrap: true,
                                                        children: <Widget>[
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 8.0,
                                                                    right: 8.0,
                                                                    bottom: 8.0,
                                                                    left: 60.0),
                                                            color: Colors.white,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        4.0),
                                                            child: Wrap(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      color: widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["disposisi_status"] ==
                                                                              "0"
                                                                          ? Colors.red[
                                                                              300]
                                                                          : widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["disposisi_status"] == "1"
                                                                              ? Colors.amber[
                                                                                  400]
                                                                              : Colors
                                                                                  .greenAccent,
                                                                      borderRadius:
                                                                          BorderRadius.circular(6.0)),
                                                                  height: 30.0,
                                                                  width: 30.0,
                                                                  child: Icon(
                                                                    widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4][
                                                                                "disposisi_status"] ==
                                                                            "0"
                                                                        ? FontAwesomeIcons
                                                                            .eyeSlash
                                                                        : widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["disposisi_status"] ==
                                                                                "1"
                                                                            ? FontAwesomeIcons.clock
                                                                            : FontAwesomeIcons.check,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 14.0,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: 6.0),
                                                                Container(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]
                                                                            [
                                                                            "jabatan_name"],
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14.0),
                                                                      ),
                                                                      Text(
                                                                        widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["disposisi_status"] ==
                                                                                "0"
                                                                            ? "Belum Diproses"
                                                                            : widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["disposisi_status"] == "1"
                                                                                ? "Disposisi Kebawah"
                                                                                : "Selesai",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12.0),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),

                                                          /////////////////////// 5/////////////////
                                                          widget.treePosition[i]["child"][i2]["child"]
                                                                              [
                                                                              i3]
                                                                          [
                                                                          "child"][i4]
                                                                      [
                                                                      "length"] ==
                                                                  0
                                                              ? Container()
                                                              : ListView
                                                                  .builder(
                                                                  physics:
                                                                      ScrollPhysics(),
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount: widget.treePosition[i]["child"][i2]["child"]
                                                                              [
                                                                              i3]
                                                                          [
                                                                          "child"][i4]
                                                                      [
                                                                      "length"],
                                                                  itemBuilder:
                                                                      (context,
                                                                          i5) {
                                                                    return ListView(
                                                                      physics:
                                                                          ScrollPhysics(),
                                                                      shrinkWrap:
                                                                          true,
                                                                      children: <
                                                                          Widget>[
                                                                        Container(
                                                                          padding: EdgeInsets.only(
                                                                              top: 8.0,
                                                                              right: 8.0,
                                                                              bottom: 8.0,
                                                                              left: 80.0),
                                                                          color:
                                                                              Colors.white,
                                                                          margin:
                                                                              EdgeInsets.only(bottom: 4.0),
                                                                          child:
                                                                              Wrap(
                                                                            children: <Widget>[
                                                                              Container(
                                                                                decoration: BoxDecoration(color: widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["child"][i5]["disposisi_status"] == "0" ? Colors.red[300] : widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["child"][i5]["disposisi_status"] == "1" ? Colors.amber[400] : Colors.greenAccent, borderRadius: BorderRadius.circular(6.0)),
                                                                                height: 30.0,
                                                                                width: 30.0,
                                                                                child: Icon(
                                                                                  widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["child"][i5]["disposisi_status"] == "0" ? FontAwesomeIcons.eyeSlash : widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["child"][i5]["disposisi_status"] == "1" ? FontAwesomeIcons.clock : FontAwesomeIcons.check,
                                                                                  color: Colors.white,
                                                                                  size: 14.0,
                                                                                ),
                                                                              ),
                                                                              SizedBox(width: 6.0),
                                                                              Container(
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: <Widget>[
                                                                                    Text(
                                                                                      widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["child"][i5]["jabatan_name"],
                                                                                      style: TextStyle(fontSize: 14.0),
                                                                                    ),
                                                                                    Text(
                                                                                      widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["child"][i5]["disposisi_status"] == "0" ? "Belum Diproses" : widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["child"][i5]["disposisi_status"] == "1" ? "Disposisi Kebawah" : "Selesai",
                                                                                      style: TextStyle(fontSize: 12.0),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                )
                                                        ],
                                                      );
                                                    },
                                                  )
                                          ],
                                        );
                                      },
                                    )
                            ],
                          );
                        },
                      )
              ],
            );
          },
        )),
        Divider(),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Instruksi Untuk Anda : "),
              Divider(),
              Text( widget.instruksi == "" || widget.instruksi.split(",") == null ? "" : "- ${widget.instruksi.split(",")[0]}",  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4.0),
              Text((widget.instruksi == "" || widget.instruksi.split(",").length == 1 || widget.instruksi.split(",")[1] == "  " || widget.instruksi.split(",")[1] == " " || widget.instruksi.split(",")[1] == null) ? "" : "- ${widget.instruksi.split(",")[1]}",  style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          child: Row(
            children: <Widget>[
              FutureBuilder(
                future: getDataTujuanMailIn(
                    jabatanId, widget.disposisiId, widget.suratId),
                builder: (context, snap) {
                  if (snap.hasData) {
                    if (snap.data["status"]) {
                      if (widget.statusDisposisi == "0") {
                        return MaterialButton(
                          onPressed: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => AddMailInDisposisi(
                                      idJabatan: jabatanId,
                                      idDisposisi: widget.disposisiId,
                                      idSurat: widget.suratId,
                                      noAgenda: widget.noAgenda,
                                      skpdPengirim: widget.skpdPengirim,
                                      tglMenerima: widget.tglTerima,
                                    )));
                          },
                          color: Colors.cyan,
                          child: Text("Buat Disposisi",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        );
                      } else {
                        return Container();
                      }
                    } else {
                      return Container();
                    }
                  } else {
                    return MaterialButton(
                          onPressed: () {
                          },
                          color: Colors.cyan[200],
                          child: Text("Loading...",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        );
                  }
                },
              ),
              SizedBox(width: 10.0),
              MaterialButton(
                onPressed: () {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return FutureBuilder(
                          future: selesaikanDisposisiMasukData(
                              widget.disposisiId, "2"),
                          builder: (context, snap) {
                            if (snap.hasData) {
                              return CupertinoAlertDialog(
                                title: Text("Selesaikan Disposisi"),
                                content: Container(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(snap.data["message"]),
                                ),
                                actions: <Widget>[
                                  MaterialButton(
                                    onPressed: (){
                                      displayNotifications("Selesaikan Surat",
                                          "Berhasil Menyelesaikan Surat");
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                    color: Colors.amber[600],
                                    child: Text("Tutup",
                                        style: TextStyle(color: Colors.white)),
                                  )
                                ],
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        );
                      });
                },
                color: Colors.green,
                child: Text("Selesai",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        )
      ],
    ));
  }
}
