import 'package:flutter/material.dart';
import 'package:simper_walikota/general/widget/expanstion_tile.dart';

class RekapCard extends StatefulWidget {
  final String title;
  final int total;
  final int masuk;
  final int proses;
  final int selesai;
  final int tolak;

  const RekapCard(
      {Key key,
      this.title,
      this.total,
      this.masuk,
      this.proses,
      this.selesai,
      this.tolak})
      : super(key: key);

  @override
  _RekapCardState createState() => _RekapCardState();
}

class _RekapCardState extends State<RekapCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(8.0),
      child: ExpansionTileX(
        headerBackgroundColor: Colors.transparent,
        title: Text(widget.title),
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Permohonan'),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Total'),
                    Card(
                      color: Color(0xff4487FF),
                      shape: StadiumBorder(),
                      child: Container(
                        height: 25.0,
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${widget.total}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Masuk'),
                    Card(
                      color: Color(0xffFF9B70),
                      shape: StadiumBorder(),
                      child: Container(
                        height: 25.0,
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${widget.masuk}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Proses'),
                    Card(
                      color: Color(0xffFFB544),
                      shape: StadiumBorder(),
                      child: Container(
                        height: 25.0,
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${widget.proses}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Selesai'),
                    Card(
                      color: Color(0xffFF7B80),
                      shape: StadiumBorder(),
                      child: Container(
                        height: 25.0,
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${widget.selesai}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Tolak'),
                    Card(
                      color: Color(0xffBAAAFF),
                      shape: StadiumBorder(),
                      child: Container(
                        height: 25.0,
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${widget.tolak}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                // Align(
                //   alignment: Alignment.bottomRight,
                //   child: MaterialButton(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(8.0),
                //     ),
                //     color: accentColor,
                //     child: Container(
                //       margin: EdgeInsets.all(8.0),
                //       child: Text(
                //         'Lihat \nPerjalanan',
                //         textAlign: TextAlign.center,
                //         style: TextStyle(color: Colors.white),
                //       ),
                //     ),
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => PastTripList(
                //             headerTitle: widget.title,
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}