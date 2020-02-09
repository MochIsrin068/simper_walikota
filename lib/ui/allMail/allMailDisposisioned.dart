import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simper_walikota/general/shimmer/shimmerMailCard.dart';
import 'package:simper_walikota/service/disposisiService.dart';
import 'package:simper_walikota/ui/mailDispositioned.dart/listTileMailDisposition.dart';

class AllMailInDispositioned extends StatefulWidget {
  @override
  _AllMailInDispositionedState createState() => _AllMailInDispositionedState();
}

class _AllMailInDispositionedState extends State<AllMailInDispositioned> {
  Future<SharedPreferences> _sharedPref = SharedPreferences.getInstance();

  String _id;

  Future getIdUser() async {
    final sha = await _sharedPref;
    _id = sha.getString("id");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getIdUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          // physics: BouncingScrollPhysics(),
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(LineIcons.arrow_left, size: 30.0,),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Surat Masuk Disposisi",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18.0)),
                        SizedBox(height: 4.0),
                        Text("Lihat semua surat yang masuk selesai",
                            style: TextStyle(fontSize: 14.0))
                      ],
                    ),
                  ),
                  Icon(LineIcons.arrow_left, color: Colors.transparent, size: 30.0,),
                ],
              ),
            ),
            Divider(),
            FutureBuilder(
              future: suratMasukSelesaiData(_id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data["data"] == null) {
                    return Container(
                        padding: EdgeInsets.all(20.0),
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey[100],
                        child: Container(
                            height: MediaQuery.of(context).size.height / 5,
                            padding: EdgeInsets.all(20.0),
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[100],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  "assets/ico/no.png",
                                  width: 50.0,
                                  height: 50.0,
                                ),
                                Center(child: Text(snapshot.data["message"]))
                              ],
                            )));
                  } else {
                    return ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data["data"].length,
                      itemBuilder: (context, i) {
                        return ListTileMailDisposition(
                          color: Colors.green[300],
                          date: snapshot.data["data"][i]
                              ["suratmasuk_tanggalterima"],
                          nosurat: snapshot.data["data"][i]
                              ["suratmasuk_noagenda"],
                          idDisposisi: snapshot.data["data"][i]["disposisi_id"],
                          title: snapshot.data["data"][i]["skpd_pengirim"],
                          nomorsurat: snapshot.data["data"][i]
                              ["suratmasuk_nosurat"],
                        );
                      },
                    );
                  }
                } else {
                  return Container(
                    child: ShimmerMailCard(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
