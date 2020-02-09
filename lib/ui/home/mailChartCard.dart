import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MailChartCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MailChartCardState();
}

class MailChartCardState extends State<MailChartCard> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: Container(
          padding: EdgeInsets.only(top: 40.0),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barTouchData: BarTouchData(
                enabled: false,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.transparent,
                  tooltipPadding: const EdgeInsets.all(0),
                  tooltipBottomMargin: 8,
                  getTooltipItem: (
                    BarChartGroupData group,
                    int groupIndex,
                    BarChartRodData rod,
                    int rodIndex,
                  ) {
                    return BarTooltipItem(
                      rod.y.round().toString(),
                      TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,
                  textStyle: TextStyle(
                      color: const Color(0xff7589a2),
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                  margin: 20,
                  getTitles: (double value) {
                    switch (value.toInt()) {
                      case 0:
                        return 'Masuk';
                      case 1:
                        return 'Tervalidasi';
                      case 2:
                        return 'Keluar';
                      default:
                        return '';
                    }
                  },
                ),
                leftTitles: const SideTitles(showTitles: false),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: [
                BarChartGroupData(x: 0, barRods: [
                  BarChartRodData(
                      y: 8,
                      color: Colors.lightBlueAccent,
                      width: 30.0,
                      borderRadius: BorderRadius.circular(4.0))
                ], showingTooltipIndicators: [
                  0
                ]),
                BarChartGroupData(x: 1, barRods: [
                  BarChartRodData(
                      y: 20,
                      color: Colors.lightBlueAccent,
                      width: 30.0,
                      borderRadius: BorderRadius.circular(4.0))
                ], showingTooltipIndicators: [
                  0
                ]),
                BarChartGroupData(x: 2, barRods: [
                  BarChartRodData(
                      y: 30,
                      color: Colors.lightBlueAccent,
                      width: 30.0,
                      borderRadius: BorderRadius.circular(4.0))
                ], showingTooltipIndicators: [
                  0
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
