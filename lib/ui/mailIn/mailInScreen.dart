import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simper_walikota/general/notification/detailMailInNotif.dart';
import 'SuratMasuk.dart';

class MailInScreen extends StatefulWidget {
  @override
  _MailInScreenState createState() => _MailInScreenState();
}

class _MailInScreenState extends State<MailInScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<SharedPreferences> _shared = SharedPreferences.getInstance();
  String _id;

  Future _getData() async {
    final sha = await _shared;
    _id = sha.getString("id");
    setState(() {});
  }

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
      onBackgroundMessage: (Map<String, dynamic> message) async {
        print("onBackgroundMessage: $message");
        await displayNotification(
            message['notification']['title'], message['notification']['body']);
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
    if (payload != null) {
      debugPrint('notification payload: ' + payload);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              DetailMailInNotif(disposisiId: "$payload")));
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
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    getNotif();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Surat Masuk",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18.0)),
                        SizedBox(height: 4.0),
                        Text("Lihat semua disposisi masuk dan masuk selesai",
                            style: TextStyle(fontSize: 14.0))
                      ],
                    ),
                  ),
                  Container()
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: SuratMasuk(),
            )
          ],
        ),
      ),
    );
  }
}
