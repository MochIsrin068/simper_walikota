import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerMailCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              enabled: true,
              child: Container(
                  margin: EdgeInsets.only(bottom: 4.0),
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(6.0)),
                      height: 45.0,
                      width: 45.0,
                    ),
                    title: Container(
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(6.0)),
                      height: 20.0,
                    ),
                    subtitle: Container(
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(6.0)),
                      height: 16.0,
                    ),
                  ))),
          Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              enabled: true,
              child: Container(
                  margin: EdgeInsets.only(bottom: 4.0),
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(6.0)),
                      height: 45.0,
                      width: 45.0,
                    ),
                    title: Container(
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(6.0)),
                      height: 20.0,
                    ),
                    subtitle: Container(
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(6.0)),
                      height: 16.0,
                    ),
                  ))),
          Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              enabled: true,
              child: Container(
                  margin: EdgeInsets.only(bottom: 4.0),
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(6.0)),
                      height: 45.0,
                      width: 45.0,
                    ),
                    title: Container(
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(6.0)),
                      height: 20.0,
                    ),
                    subtitle: Container(
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(6.0)),
                      height: 16.0,
                    ),
                  )))
        ],
      ),
    );
  }
}
