import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simper_walikota/general/shimmer/shimmerMailCard.dart';
import 'package:simper_walikota/service/disposisiService.dart';
import 'package:simper_walikota/ui/mailIn/detailMailin/detailMailIn.dart';


class NotifCard extends StatefulWidget {
  final String title, subtitle, leading, idDisposisi;

  NotifCard({this.title, this.subtitle, this.leading, this.idDisposisi});

  @override
  _NotifCardState createState() => _NotifCardState();
}

class _NotifCardState extends State<NotifCard> {
  @override
  void initState() {
    super.initState();
    detailDisposisiMasukData(widget.idDisposisi);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        // margin: EdgeInsets.all(0.0),
        child: (widget.leading == "" ||
                widget.subtitle == "" ||
                widget.title == "")
            ? Container()
            : FutureBuilder(
                future: detailDisposisiMasukData(widget.idDisposisi),
                builder: (context, snap) {
                  if (snap.hasData) {
                    if (snap.data["status"]) {
                      return ListTile(
                        onTap: () {
                          print("Tap");
                          if (dataDetailDisposisiMasuk == null) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                });
                          } else {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => DetailMailIn(
                                      disposisiId: snap.data["data"][0]["disposisi_id"],
                                      url:
                                          "${snap.data["data"][0]["suratmasuk_file"]}",
                                    )));
                          }
                        },
                        leading: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.blueAccent,
                          ),
                          child: Text(widget.leading,
                              style: TextStyle(color: Colors.white)),
                        ),
                        title: Text(widget.title),
                        subtitle: Text(widget.subtitle),
                      );
                    } else {
                      return Text("");
                    }
                  } else {
                    return ShimmerMailCard();
                  }
                },
              ));
  }
}
