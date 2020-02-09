import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:line_icons/line_icons.dart';
import 'package:simper_walikota/service/disposisiService.dart';

import 'historyDisposition.dart';

class DetailDisposition extends StatefulWidget {
  final String disposisiId;
  final String url;

  DetailDisposition({this.disposisiId, this.url});
  // HANDLE LOAD PDF
  @override
  _DetailDispositionState createState() => _DetailDispositionState();
}

class _DetailDispositionState extends State<DetailDisposition> {
  PDFDocument doc;

  bool _isLoading = true;
  bool _isDocument = true;

  bool _isImage = false;

  String fileBase = "http://simper.technos-studio.com/upload/suratmasuk/";

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    doc = await PDFDocument.fromURL("$fileBase${widget.url}");
    setState(() {
      _isLoading = false;
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
                              icon: Icon(
                                LineIcons.arrow_left,
                                size: 30.0,
                              ),
                            ),
                            Center(
                              child: Text("Detail Surat",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0)),
                            ),
                            IconButton(
                              icon: _isDocument
                                  ? Image.asset(
                                      "assets/ico/indata.png",
                                      width: 28,
                                      height: 28,
                                    )
                                  : Image.asset(
                                      "assets/ico/file.png",
                                      width: 28,
                                      height: 28,
                                    ),
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
                            : HistoryDisposisiSelesai(
                                treePosition: snapshot.data["tree"],
                                instruksi: snapshot.data["data"][0]
                                    ["disposisi_instruksi"],
                                disposisiId: snapshot.data["data"][0]
                                    ["disposisi_id"],
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
