import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ShannonMainData {
  static LineChartData shannonMainData() {
    //gradient for new graph
    List<Color> gradientColors = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
    ];
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 13),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '2008';
              case 2:
                return '2010';
              case 4:
                return '2012';
              case 6:
                return '2014';
              case 8:
                return '2016';
              case 10:
                return '2018';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1.0';
              case 2:
                return '1.2';
              case 3:
                return '1.4';
              case 4:
                return '1.6';
              case 5:
                return '1.8';
              case 6:
                return '2.0';
              case 7:
                return '2.2';
              case 8:
                return '2.4';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 9,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 6.6),
            FlSpot(2, 3.49),
            FlSpot(4, 3.47),
            FlSpot(6, 3.53),
            FlSpot(8, 2.48),
            FlSpot(10, 3.35),
            FlSpot(11, 3.35),
          ],
          //  spots: [
          //   FlSpot(0, 2.063),
          //   FlSpot(2, 1.491),
          //   FlSpot(4, 1.470),
          //   FlSpot(6, 1.535),
          //   FlSpot(8, 1.280),
          //   FlSpot(10, 1.352),
          //   FlSpot(11, 1.352),
          // ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
      axisTitleData: FlAxisTitleData(
        leftTitle: AxisTitle(
          reservedSize: 22,
          showTitle: true,
          titleText: 'Milligrams per litre',
          textStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        bottomTitle: AxisTitle(
          reservedSize: 22,
          showTitle: true,
          titleText: 'Figures per year',
          textStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
