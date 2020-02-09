import 'dart:io';

import 'package:badges/badges.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simper_walikota/general/notification/detailMailInNotif.dart';
import 'package:simper_walikota/general/shimmer/shimmerHomeCard.dart';
import 'package:simper_walikota/service/disposisiService.dart';
import 'package:simper_walikota/ui/allMail/allMailDisposisioned.dart';
import 'package:simper_walikota/ui/allMail/allMailIn.dart';
import 'package:simper_walikota/ui/mailIn/ListTileSuratMasukCard.dart';
import 'homeComponents.dart';
import '../../general/shimmer/shimmerMailCard.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final String password;

  HomeScreen({this.username, this.password});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // GET DATA SHARED PREFERENCES
  Future<SharedPreferences> _shared = SharedPreferences.getInstance();

  // FOR DATA
  String _username;
  String _firstname;
  String _lastname;
  String _idskpd;
  String _jabatanid;
  String _groupidskpd;
  // FOR WUDGET
  String _suratMasuk;
  String _suratKeluar;
  String _password;
  String _id;
  //////////////////////////

  Future _getData() async {
    final sha = await _shared;
    _username = sha.getString("username");
    _firstname = sha.getString("first_name");
    _lastname = sha.getString("last_name");
    _idskpd = sha.getString("id_skpd");
    _jabatanid = sha.getString("jabatan_id");
    _groupidskpd = sha.getString("group_id");
    _suratMasuk = sha.getString("widget_suratmasuk");
    _suratKeluar = sha.getString("widget_suratkeluar");
    _password = sha.getString("password");
    _id = sha.getString("id");
    setState(() {});
  }

  // DATA NOTIF
  List notifData = [];

  // BUGES
  int counter = 0;

  //GET NOTIFIKASI
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
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
        print(notifData);

        setState(() {
          counter++;
        });
        // addBadge();
        print(notifData);

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
    // _getData();
    getNotif();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Selamat Datang",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            )),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text("$_firstname",
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                            ))
                      ],
                    ),
                  ),
                ),
                _id == null
                    ? Icon(
                        LineIcons.bell,
                        size: 30,
                        color: Colors.black.withOpacity(0.5),
                      )
                    : FutureBuilder(
                        future: disposisiMasukData(_id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data["status"]) {
                              return Badge(
                                position:
                                    BadgePosition.topRight(top: 0, right: 3),
                                animationDuration: Duration(milliseconds: 300),
                                animationType: BadgeAnimationType.slide,
                                badgeContent: Text(
                                  snapshot.data["data"].length.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    LineIcons.bell,
                                    size: 30,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  onPressed: () {},
                                ),
                              );
                            } else {
                              return Badge(
                                position:
                                    BadgePosition.topRight(top: 0, right: 3),
                                animationDuration: Duration(milliseconds: 300),
                                animationType: BadgeAnimationType.slide,
                                badgeContent: Text(
                                  0.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    LineIcons.bell,
                                    size: 30,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  onPressed: () {},
                                ),
                              );
                            }
                          } else {
                            return Badge(
                              position:
                                  BadgePosition.topRight(top: 0, right: 3),
                              animationDuration: Duration(milliseconds: 300),
                              animationType: BadgeAnimationType.slide,
                              badgeContent: Text(
                                0.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  LineIcons.bell,
                                  size: 30,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                onPressed: () {},
                              ),
                            );
                          }
                        }),
              ],
            ),
          ),
          Divider(),
          SizedBox(height: 14.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(CupertinoPageRoute(builder: (context) {
                      return AllMailIn();
                    }));
                  },
                  child: HomeComponents(
                    icon: Icon(
                      LineIcons.envelope,
                      size: 35.0,
                      color: Colors.white,
                    ),
                    primarycolor: Colors.amber,
                    secondcolor: Colors.amber[600],
                    count: 0.toString(),
                    title: "Surat Masuk",
                  )),
              InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(CupertinoPageRoute(builder: (context) {
                      return AllMailInDispositioned();
                    }));
                  },
                  child: HomeComponents(
                    icon: Icon(
                      LineIcons.paper_plane,
                      size: 35.0,
                      color: Colors.white,
                    ),
                    primarycolor: Colors.cyan[400],
                    secondcolor: Colors.cyan,
                    count: 0.toString(),
                    title: "Surat Keluar",
                  )),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                  onTap: () {},
                  child: HomeComponents(
                    icon: Icon(
                      LineIcons.check,
                      size: 35.0,
                      color: Colors.white,
                    ),
                    primarycolor: Colors.green,
                    secondcolor: Colors.green[600],
                    count: 0.toString(),
                    title: "Surat Tervalidasi",
                  )),
              InkWell(
                  onTap: () {},
                  child: HomeComponents(
                    icon: Icon(
                      LineIcons.book,
                      size: 35.0,
                      color: Colors.white,
                    ),
                    primarycolor: Colors.red[400],
                    secondcolor: Colors.red,
                    count: 0.toString(),
                    title: "Rekap Surat",
                  )),
            ],
          ),

          SizedBox(
            height: 30.0,
          ),
          // Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Surat Masuk Terbaru"),
                newsMail == false
                    ? Container()
                    : FlatButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(CupertinoPageRoute(builder: (context) {
                            return AllMailIn();
                          }));
                        },
                        color: Colors.grey[200],
                        child: Text("Lihat Semua"),
                      )
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),

          FutureBuilder(
            future: newsMailData(_username, _password),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == false) {
                  return Center(
                      child: Container(
                          padding: EdgeInsets.all(20.0),
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey[100],
                          child: Center(child: Text("Surat Tidak Ada"))));
                } else {
                  if (snapshot.data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return ListTileSuratMasukCard(
                          color: Colors.green[300],
                          date: snapshot.data[i]["suratmasuk_tanggalsurat"],
                          nosurat: snapshot.data[i]["suratmasuk_noagenda"],
                          idDisposisi: snapshot.data[i]["disposisi_id"],
                          title: snapshot.data[i]["skpd_pengirim"],
                          nomorsurat: snapshot.data[i]["suratmasuk_nosurat"],
                        );
                      },
                    );
                  }
                }
              } else {
                return Container(child: ShimmerMailCard());
              }
            },
          ),
        ],
      ),
    );
  }
}
