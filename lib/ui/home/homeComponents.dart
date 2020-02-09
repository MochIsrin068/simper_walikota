import 'package:flutter/material.dart';

class HomeComponents extends StatelessWidget {
  final Color primarycolor;
  final Color secondcolor;
  final String title;
  final Icon icon;
  final String count;

  HomeComponents(
      {this.primarycolor, this.secondcolor, this.title, this.icon, this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width / 2 - 20,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: primarycolor,
        ),
        child: Row(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: secondcolor,
                ),
                padding: EdgeInsets.only(
                    top: 20.0, right: 20.0, bottom: 20.0, left: 10.0),
                margin: EdgeInsets.only(right: 10.0),
                width: MediaQuery.of(context).size.width / 4 - 30,
                child: icon),
            Expanded(
                child: Text(title,
                    style: TextStyle(color: Colors.white, fontSize: 14.0)))
          ],
        ),
      ),
    );
  }
}
