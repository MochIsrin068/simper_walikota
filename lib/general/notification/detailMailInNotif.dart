import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:simper_walikota/service/disposisiService.dart';
import 'package:simper_walikota/ui/mailIn/detailMailin/historyMailIn.dart';

class DetailMailInNotif extends StatefulWidget {
  final String disposisiId;
  // final String url;

  DetailMailInNotif({this.disposisiId});

  // HANDLE LOAD PDF
  @override
  _DetailMailInState createState() => _DetailMailInState();
}

class _DetailMailInState extends State<DetailMailInNotif> {
  PDFDocument doc;
  bool _isDocument = true;

  String fileBase = "http://simper.technos-studio.com/upload/suratmasuk/";

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    var dataDetail =  await detailDisposisiMasukData(widget.disposisiId);

    doc = await PDFDocument.fromURL("$fileBase${dataDetail["data"][0]["suratmasuk_file"]}");
    setState(() {
      // _isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedContainer(
            curve: Curves.easeIn,
            duration: Duration(seconds: 2),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(10.0),
            child: FutureBuilder(
              future: detailDisposisiMasukData(widget.disposisiId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // loadDocument(snapshot.data["data"][0]["suratmasuk_file"]);
                  // print("Data ${snapshot.data}");

                  var getExtenstion =
                      snapshot.data["data"][0]["suratmasuk_file"].split(".");
                  String fileExtenstion = getExtenstion[1];
                  print(fileExtenstion);
                  return ListView(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.arrow_back_ios),
                            ),
                            Center(
                              child: Text("Detail Surat",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0)),
                            ),
                            IconButton(
                              icon: Icon(_isDocument
                                  ? FontAwesomeIcons.list
                                  : FontAwesomeIcons.file),
                              onPressed: () {
                                setState(() {
                                  _isDocument = _isDocument ? false : true;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      Divider(),
                      Text(_isDocument
                          ? snapshot.data["data"][0]["suratmasuk_nosurat"]
                          : "Riwayat Disposisi"),
                      SizedBox(height: 4.0),
                      _isDocument
                          ? Text(snapshot.data["data"][0]["skpd_pengirim"])
                          : Divider(),
                      // _isLoading
                      //     ? Center(child: CircularProgressIndicator())
                      //     :
                      Container(
                        height: MediaQuery.of(context).size.height - 158,
                        child: _isDocument
                            ? Container(
                                child: (fileExtenstion == "png" ||
                                        fileExtenstion == "jpg" ||
                                        fileExtenstion == "jpeg")
                                    ? CachedNetworkImage(
                                        // width: 80.0,
                                        // height: 110.0,
                                        // fit: BoxFit.cover,
                                        imageUrl:
                                            "$fileBase${snapshot.data["data"][0]["suratmasuk_file"]}",
                                        placeholder: (context, url) =>
                                            Image.asset(
                                                "assets/images/loading2.gif"),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      )
                                    : PDFViewer(
                                        showPicker: false,
                                        document: doc,
                                      ),
                              )
                            : HistoryMailIn(
                                treePosition: snapshot.data["tree"],
                                instruksi: snapshot.data["data"][0]
                                    ["disposisi_instruksi"],
                                disposisiId: widget.disposisiId,
                                suratId: snapshot.data["data"][0]
                                    ["suratmasuk_id"],
                                skpdPengirim: snapshot.data["data"][0]
                                    ["skpd_pengirim"],
                                noAgenda: snapshot.data["data"][0]
                                    ["suratmasuk_noagenda"],
                                tglTerima: snapshot.data["data"][0]
                                    ["suratmasuk_tanggalterima"],
                                statusDisposisi: snapshot.data["data"][0]["disposisi_status"],
                              ),
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )));
  }
}
