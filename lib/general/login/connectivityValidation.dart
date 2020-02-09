import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simper_walikota/service/loginService.dart';
import 'package:simper_walikota/ui/home/navigationBar.dart';


Future<SharedPreferences> _sharedPref = SharedPreferences.getInstance();

// FOR GET TOKEN
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
String myToken;

_getTokenNotif() {
  _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true));
  _firebaseMessaging.onIosSettingsRegistered
      .listen((IosNotificationSettings settings) {
    print("Settings registered: $settings");
  });
  _firebaseMessaging.getToken().then((String token) {
    assert(token != null);
    print(token);
    myToken = token;
    print(myToken);
  });
}

Future getConnection(
    BuildContext context, String username, String password) async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    await loginData(username, password);
    print(dataLogin);

    if (dataLogin == null) {
      showDialog(
          context: context,
          builder: (context) {
            return Center(child: CircularProgressIndicator());
          });
    } else {
      if (dataLogin["status"] == false) {
        showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            });

        void directly() {
          showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  content: Container(
                    height: 120.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.times,
                          color: Colors.red,
                          size: 50.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text("Username atau Password Salah!!")
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    MaterialButton(
                      color: Colors.amber,
                      child:
                          Text("Close", style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        }

        var durasi = Duration(seconds: 2);
        Timer(durasi, directly);
      } else {
        // Save to shared preferences
        final sha = await _sharedPref;
        // FOR DATA
        sha.setString("id", dataLogin["data"][0]["id"]);
        sha.setString("username", dataLogin["data"][0]["username"]);
        sha.setString("first_name", dataLogin["data"][0]["first_name"]);
        sha.setString("last_name", dataLogin["data"][0]["last_name"]);
        sha.setString("id_bpkad", dataLogin["data"][0]["id_bpkad"]);
        sha.setString("jabatan_id", dataLogin["data"][0]["jabatan_id"]);
        sha.setString("group_id", dataLogin["data"][0]["group_id"]);
        // FOR WIDGET
        sha.setString(
            "widget_suratmasuk", dataLogin["widget"][0]["widget_suratmasuk"]);
        sha.setString(
            "widget_suratkeluar", dataLogin["widget"][0]["widget_suratkeluar"]);

        sha.setString("password", password);

        // FOR NEWS DATA

        showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            });

        await _getTokenNotif();
        void directly() {
          if ((dataLogin["data"][0]["id"] == "1") || (dataLogin["data"][0]["id"] == "2") || (dataLogin["data"][0]["id"] == "3")) {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => NavigationBar(
                  username: username,
                  password: password,
                )));
          } else {
            showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text("Login Validasi"),
                    content: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Text("Selain Walikota, Wakil Walikota dan Sekda tidak dapat login, silahkan gunakan aplikasi SIMPER untuk Umum!", style: TextStyle(height: 1.6)),
                    ),
                    actions: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        color: Colors.amber,
                        child: Text("Tutup",
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  );
                });
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (context) => NavigationBar()));
          }
        }

        var durasi = Duration(seconds: 2);
        Timer(durasi, directly);
      }
    }
  } else {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Container(
              height: 120.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.wifi,
                    color: Colors.red,
                    size: 50.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Tidak Ada Koneksi Internet!!")
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.amber,
                child: Text("Close", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
