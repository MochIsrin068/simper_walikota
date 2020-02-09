import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryDisposisiSelesai extends StatefulWidget {
  final List treePosition;
  final String instruksi;
  final String disposisiId;

  HistoryDisposisiSelesai(
      {this.treePosition, this.instruksi, this.disposisiId});

  @override
  _HistoryMailInState createState() => _HistoryMailInState();
}

class _HistoryMailInState extends State<HistoryDisposisiSelesai> {
  final Future<SharedPreferences> _sharedPref = SharedPreferences.getInstance();
  String jabatanId;
  String pendisposisi;

  getIdJabatan() async {
    final sha = await _sharedPref;
    jabatanId = sha.getString('jabatan_id');
    pendisposisi = sha.getString('pendisposisi');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getIdJabatan();
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
            itemBuilder: (context, i){
              return ListView(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[   
                  Container(
                            padding: EdgeInsets.only(
                                top: 8.0, right: 8.0, bottom: 8.0),
                            color: Colors.white,
                            margin: EdgeInsets.only(bottom: 4.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: widget.treePosition[i]["disposisi_status"] == "0"
                                          ? Colors.red[300]
                                          :widget.treePosition[i]["disposisi_status"] == "1"
                                              ? Colors.amber[400]
                                              : Colors.greenAccent,
                                      borderRadius: BorderRadius.circular(6.0)),
                                  height: 30.0,
                                  width: 30.0,
                                  child: Icon(
                                    widget.treePosition[i]["disposisi_status"] == "0"
                                        ? FontAwesomeIcons.eyeSlash
                                        : widget.treePosition[i]["disposisi_status"] == "1"
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        widget.treePosition[i]["jabatan_name"],
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      Text(
                                        widget.treePosition[i]["disposisi_status"] == "0"
                                            ? "Belum Diproses"
                                            : widget.treePosition[i]["disposisi_status"] == "1"
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
                          widget.treePosition[i]["length"] == 0 ? Container() : ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.treePosition[i]["length"],
                            itemBuilder: (context, i2){
                              return ListView(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[
                                  Container(
                            padding: EdgeInsets.only(
                                top: 8.0, right: 8.0, bottom: 8.0, left: 20.0),
                            color: Colors.white,
                            margin: EdgeInsets.only(bottom: 4.0),
                            child: Wrap(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: widget.treePosition[i]["child"][i2]["disposisi_status"] == "0"
                                          ? Colors.red[300]
                                          :widget.treePosition[i]["child"][i2]["disposisi_status"] == "1"
                                              ? Colors.amber[400]
                                              : Colors.greenAccent,
                                      borderRadius: BorderRadius.circular(6.0)),
                                  height: 30.0,
                                  width: 30.0,
                                  child: Icon(
                                    widget.treePosition[i]["child"][i2]["disposisi_status"] == "0"
                                        ? FontAwesomeIcons.eyeSlash
                                        : widget.treePosition[i]["child"][i2]["disposisi_status"] == "1"
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        widget.treePosition[i]["child"][i2]["jabatan_name"],
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      Text(
                                        widget.treePosition[i]["child"][i2]["disposisi_status"] == "0"
                                            ? "Belum Diproses"
                                            : widget.treePosition[i]["child"][i2]["disposisi_status"] == "1"
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
                          widget.treePosition[i]["child"][i2]["length"] == 0 ? Container() : ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.treePosition[i]["child"][i2]["length"],
                            itemBuilder: (context, i3){
                              return ListView(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[
                                  Container(
                            padding: EdgeInsets.only(
                                top: 8.0, right: 8.0, bottom: 8.0, left: 40.0),
                            color: Colors.white,
                            margin: EdgeInsets.only(bottom: 4.0),
                            child: Wrap(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: widget.treePosition[i]["child"][i2]["child"][i3]["disposisi_status"] == "0"
                                          ? Colors.red[300]
                                          :widget.treePosition[i]["child"][i2]["child"][i3]["disposisi_status"] == "1"
                                              ? Colors.amber[400]
                                              : Colors.greenAccent,
                                      borderRadius: BorderRadius.circular(6.0)),
                                  height: 30.0,
                                  width: 30.0,
                                  child: Icon(
                                    widget.treePosition[i]["child"][i2]["child"][i3]["disposisi_status"] == "0"
                                        ? FontAwesomeIcons.eyeSlash
                                        : widget.treePosition[i]["child"][i2]["child"][i3]["disposisi_status"] == "1"
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        widget.treePosition[i]["child"][i2]["child"][i3]["jabatan_name"],
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      Text(
                                        widget.treePosition[i]["child"][i2]["child"][i3]["disposisi_status"] == "0"
                                            ? "Belum Diproses"
                                            : widget.treePosition[i]["child"][i2]["child"][i3]["disposisi_status"] == "1"
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

                          /////////////////////// 4/////////////////
                          widget.treePosition[i]["child"][i2]["child"][i3]["length"] == 0 ? Container() : ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.treePosition[i]["child"][i2]["child"][i3]["length"],
                            itemBuilder: (context, i4){
                              return ListView(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[
                                  Container(
                            padding: EdgeInsets.only(
                                top: 8.0, right: 8.0, bottom: 8.0, left: 60.0),
                            color: Colors.white,
                            margin: EdgeInsets.only(bottom: 4.0),
                            child: Wrap(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["disposisi_status"] == "0"
                                          ? Colors.red[300]
                                          :widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["disposisi_status"] == "1"
                                              ? Colors.amber[400]
                                              : Colors.greenAccent,
                                      borderRadius: BorderRadius.circular(6.0)),
                                  height: 30.0,
                                  width: 30.0,
                                  child: Icon(
                                    widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["disposisi_status"] == "0"
                                        ? FontAwesomeIcons.eyeSlash
                                        : widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["disposisi_status"] == "1"
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["jabatan_name"],
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      Text(
                                        widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["disposisi_status"] == "0"
                                            ? "Belum Diproses"
                                            : widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["disposisi_status"] == "1"
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


                          /////////////////////// 5/////////////////
                          widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["length"] == 0 ? Container() : ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["length"],
                            itemBuilder: (context, i5){
                              return ListView(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[
                                  Container(
                            padding: EdgeInsets.only(
                                top: 8.0, right: 8.0, bottom: 8.0, left: 80.0),
                            color: Colors.white,
                            margin: EdgeInsets.only(bottom: 4.0),
                            child: Wrap(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["child"][i5]["disposisi_status"] == "0"
                                          ? Colors.red[300]
                                          :widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["child"][i5]["disposisi_status"] == "1"
                                              ? Colors.amber[400]
                                              : Colors.greenAccent,
                                      borderRadius: BorderRadius.circular(6.0)),
                                  height: 30.0,
                                  width: 30.0,
                                  child: Icon(
                                    widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["child"][i5]["disposisi_status"] == "0"
                                        ? FontAwesomeIcons.eyeSlash
                                        : widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["child"][i5]["disposisi_status"] == "1"
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["child"][i5]["jabatan_name"],
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      Text(
                                        widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["child"][i5]["disposisi_status"] == "0"
                                            ? "Belum Diproses"
                                            : widget.treePosition[i]["child"][i2]["child"][i3]["child"][i4]["child"][i5]["disposisi_status"] == "1"
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
          )
        ),
        Divider(),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Instruksi Untuk Anda : "),
              Divider(),
              Text((widget.instruksi == "" || widget.instruksi.split(",") == null) ? "" : "- ${widget.instruksi.split(",")[0]}",  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4.0),
              Text((widget.instruksi == "" || widget.instruksi.split(",").length == 1) ? "" : "- ${widget.instruksi.split(",")[1]}",  style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          child: pendisposisi == null ? Text("") : pendisposisi == "$jabatanId${widget.disposisiId}" ? MaterialButton(
            onPressed: () {},
            color: Colors.red[600],
            child: Text("Tarik Diposisi",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ) : Text("")
        )
      ],
    ));
  }
}
