import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

// HANDLE MESSAGING
class MessagingDisposisi {
  static final Client client = Client();

  String subId;

  MessagingDisposisi({this.subId});

  // from 'https://console.firebase.google.com'
  // --> project settings --> cloud messaging --> "Server key"
  static const String serverKey =
      'AAAAHBGXMKU:APA91bHGaUcNbvisQmi3e7HtUK0winP1nLFk6VsbapwnfjKWQLMchiamaKsa8-reU_1rrqQoJLRtHGbylu0DztRd-mMi9fWBsJ5MwXTIW7xV-jpgU-9b4aSbrv4IKCRCALvJQrC5_6Yz';

  static Future<Response> sendToAll({
    @required String title,
    @required String body,
    @required String speceficttopic,
  }) =>
      sendToTopic(title: title, body: body, topic: speceficttopic);

  static Future<Response> sendToTopic(
          {@required String title,
          @required String body,
          @required String topic}) =>
      sendTo(title: title, body: body, fcmToken: '/topics/$topic');

  static Future<Response> sendTo({
    @required String title,
    @required String body,
    @required String fcmToken,
  }) =>
      client.post(
        'https://fcm.googleapis.com/fcm/send',
        body: json.encode({
          'notification': {'body': '$body', 'title': '$title'},
          'priority': 'high',
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
          },
          'to': '$fcmToken',
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
      );
}
