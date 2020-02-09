import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'notifCard.dart';

class NotifScreen extends StatelessWidget {
  final List dataNotif;
  final String collectionID;

  NotifScreen({this.dataNotif, this.collectionID});

  removeAllNotif() async {
    print("Clear Notif");
    print(collectionID);

    // for (var i = 0; i < dataNotif.length; i++) {
    //   final document =
    //       Firestore.instance.collection(collectionID).document(dataNotif[i]);
    //   document.delete().whenComplete(() {
    //     print("${dataNotif[i]} Deleted");
    //   });
    // }

    Firestore.instance.collection(collectionID).getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            removeAllNotif();
          },
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        title: Text("Notifikasi", style: TextStyle(color: Colors.black)),
      ),
      body: Container(
          padding: EdgeInsets.all(10.0),
          child: dataNotif.length == 0
              ? Center(child: Text("Tidak Ada Notifikasi"))
              : ListView.builder(
                  itemCount: dataNotif.length,
                  itemBuilder: (context, i) => NotifCard(
                    leading: dataNotif[i]["noAgenda"] == null
                        ? ""
                        : dataNotif[i]["noAgenda"],
                    subtitle: dataNotif[i]["title"] == null
                        ? ""
                        : dataNotif[i]["title"],
                    title: dataNotif[i]["skpdPengirim"] == null
                        ? ""
                        : dataNotif[i]["skpdPengirim"],
                    idDisposisi: dataNotif[i]["idDisposisi"] == null
                        ? ""
                        : dataNotif[i]["idDisposisi"],
                  ),
                )),
    );
  }
}
