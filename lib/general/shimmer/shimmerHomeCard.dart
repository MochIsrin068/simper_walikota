import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 8 + 10,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        enabled: true,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white70,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white70,
                  ),
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.only(right: 10.0),
                  width: 100.0,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("",
                          style: TextStyle(
                              color: Colors.white, fontSize: 18.0)),
                      SizedBox(height: 6.0),
                      Text("",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
