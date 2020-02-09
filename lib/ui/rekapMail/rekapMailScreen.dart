import 'package:flutter/material.dart';
import 'package:simper_walikota/ui/rekapMail/rekapCard.dart';

class RekapMailScreen extends StatefulWidget {
  @override
  _RekapMailScreenState createState() => _RekapMailScreenState();
}

class _RekapMailScreenState extends State<RekapMailScreen> {
  String _id = "1";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    SizedBox(width: 14.0),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Rekapan Surat OPD",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18.0)),
                          SizedBox(height: 4.0),
                          Text("Lihat semua rekapan surat opd",
                              style: TextStyle(fontSize: 14.0))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      RekapCard(
                        title: 'SPPD WALIKOTA',
                        total: 10,
                        masuk: 20,
                        proses: 12,
                        selesai: 11,
                        tolak: 12,
                      ),
                      RekapCard(
                        title: 'SPPD KEPALA OPD',
                        total: 10,
                        masuk: 20,
                        proses: 12,
                        selesai: 11,
                        tolak: 12,
                      ),
                      RekapCard(
                        title: 'SPPD SEKDA/ASISTEN/KABAG',
                        total: 10,
                        masuk: 20,
                        proses: 12,
                        selesai: 11,
                        tolak: 12,
                      ),
                      RekapCard(
                        title: 'SPPD ANGGOTA DPRD',
                        total: 10,
                        masuk: 20,
                        proses: 12,
                        selesai: 11,
                        tolak: 12,
                      ),
                      RekapCard(
                        title: 'CAMAT & LURAH',
                        total: 10,
                        masuk: 20,
                        proses: 12,
                        selesai: 11,
                        tolak: 12,
                      ),
                      RekapCard(
                        title: 'SPPD ESELON III, IV & STAF',
                        total: 10,
                        masuk: 20,
                        proses: 12,
                        selesai: 11,
                        tolak: 12,
                      ),
                      RekapCard(
                        title: 'SPPD STAF DPRD',
                        total: 10,
                        masuk: 20,
                        proses: 12,
                        selesai: 11,
                        tolak: 12,
                      ),
                      RekapCard(
                        title: 'SPPD STAF CAMAT & LURAH',
                        total: 10,
                        masuk: 20,
                        proses: 12,
                        selesai: 11,
                        tolak: 12,
                      ),
                      RekapCard(
                        title: 'SPPD STAF SETDA',
                        total: 10,
                        masuk: 20,
                        proses: 12,
                        selesai: 11,
                        tolak: 12,
                      ),
                      RekapCard(
                        title: 'SPPD SEKWAN',
                        total: 10,
                        masuk: 20,
                        proses: 12,
                        selesai: 11,
                        tolak: 12,
                      ),
                      RekapCard(
                        title: 'SPPD PUSKESMAS',
                        total: 10,
                        masuk: 20,
                        proses: 12,
                        selesai: 11,
                        tolak: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
