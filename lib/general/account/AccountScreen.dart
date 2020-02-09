import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:simper_walikota/general/login/loginScreen.dart';
import 'package:simper_walikota/general/notification/detailMailInNotif.dart';
import 'package:simper_walikota/general/shimmer/shimmerProfile.dart';
import 'package:simper_walikota/service/profile.dart';

import 'editAccountScreen.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  // GET DATA SHARED PREFERENCES
  Future<SharedPreferences> _shared = SharedPreferences.getInstance();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  String _idUser;
  String _username;
  String _firstname;
  String _lastname;
  String _idskpd;
  String _jabatanid;
  String _groupidskpd;
  String _id;
  //////////////////////////

  Future _getData() async {
    final sha = await _shared;
    _idUser = sha.getString("id");
    _username = sha.getString("username");
    _firstname = sha.getString("first_name");
    _lastname = sha.getString("last_name");
    _idskpd = sha.getString("id_skpd");
    _jabatanid = sha.getString("jabatan_id");
    _groupidskpd = sha.getString("group_id");
    _id = sha.getString("id");
    setState(() {});
  }

  //GET NOTIFIKASI
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  getNotif() async {
    await _getData();

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    // _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
    // _firebaseMessaging.getToken();

    _firebaseMessaging.subscribeToTopic(_id);
    print("Subscripe : $_id");

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        await displayNotification(
            message['notification']['title'], message['notification']['body']);

        // addBadge();
      },
      onBackgroundMessage: Platform.isIOS
          ? null
          : (Map<String, dynamic> message) async {
              print("onBackgroundMessage: $message");
              if (message.containsKey('data')) {
                await displayNotification(
                    message['data']['title'], message['data']['body']);
              }

              if (message.containsKey('notification')) {
                await displayNotification(message['notification']['title'],
                    message['notification']['body']);
              }
            },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        await displayNotification(
            message['data']['title'], message['notification']['body']);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");

        await displayNotification(
            message['notification']['title'], message['notification']['body']);
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print(token);
    });
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

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailMailInNotif(disposisiId: "$payload")));
    }
  }

  Future displayNotification(String title, String body) async {
    var getExtenstion = body.split("/");
    String fileExtenstion = getExtenstion[1];

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, '$title', '${getExtenstion[0]}', platformChannelSpecifics,
        payload: fileExtenstion);
  }

  @override
  void initState() {
    super.initState();
    _getData();
    getNotif();
  }

  // Logout
  Future _logout() async {
    final sha = await _shared;
    sha.clear();
  }

  refreshToken() {
    print("Refresh Token");
    _firebaseMessaging.unsubscribeFromTopic(_id);
    print("UNSubscripe : $_id");
    removeAllNotif();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[100],
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5.0),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      LineIcons.info_circle,
                      color: Colors.black54,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 14.0),
                    child: Text("My Account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontSize: 18.0)),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      LineIcons.cog,
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      radius: 46.0,
                      child: CircleAvatar(
                        radius: 44.0,
                        backgroundImage: AssetImage(_id == "1"
                            ? "assets/images/walikota.jpg"
                            : "assets/images/person3.png"),
                      ),
                    ),
                  ),
                  Container(
                      child: FutureBuilder(
                    future: profileData(_idUser),
                    builder: (context, snap) {
                      if (snap.hasData) {
                        return Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            Center(
                                child: Text(
                              "${snap.data["username"]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                  fontSize: 14.0),
                            )),
                            SizedBox(height: 2.0),
                            Chip(
                                backgroundColor: Colors.amber,
                                label: Text("${snap.data["first_name"]}",
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.white))),
                            SizedBox(height: 4.0),
                            Center(
                                child: Text("${snap.data["email"]}",
                                    style: TextStyle(fontSize: 14.0))),
                            SizedBox(height: 4.0),
                            Center(
                                child: Text(
                                    snap.data["phone"] == null
                                        ? ""
                                        : "${snap.data["phone"]}",
                                    style: TextStyle(fontSize: 14.0))),
                            SizedBox(height: 10.0)
                          ],
                        );
                      } else {
                        return Container(
                          child: ShimmerProfile(),
                        );
                      }
                    },
                  ))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Card(
                  child: Column(
                children: <Widget>[
                  Container(
                      child: FutureBuilder(
                    future: profileData(_idUser),
                    builder: (context, snap) {
                      if (snap.hasData) {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => EditAccountScreen(
                                      id: _idUser,
                                      email: snap.data["email"],
                                      firstname: snap.data["first_name"],
                                      lastname: snap.data["last_name"],
                                      username: snap.data["username"],
                                      nohp: snap.data["phone"],
                                    )));
                          },
                          leading:
                              Icon(LineIcons.edit, color: Colors.green[200]),
                          title: Text("Edit Profile"),
                          trailing: Text(">"),
                        );
                      } else {
                        return ListTile(
                          leading: Icon(LineIcons.power_off,
                              color: Colors.green[200]),
                          title: Text("Edit Profile"),
                          trailing: Text(">"),
                        );
                      }
                    },
                  )),
                  Divider(),
                  Container(
                    child: ListTile(
                      onTap: () {
                        _logout();
                        refreshToken();
                        Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      leading: Icon(Icons.power_settings_new,
                          color: Colors.redAccent),
                      title: Text("Logout"),
                      trailing: Text(">"),
                    ),
                  ),
                ],
              )),
            )
          ],
        ));
  }

  removeAllNotif() async {
    print("Clear Notif");
    print(_id);

    Firestore.instance.collection(_id).getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
  }
}
