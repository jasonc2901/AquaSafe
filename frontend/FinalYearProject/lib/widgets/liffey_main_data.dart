import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LiffeyMainData {
  static LineChartData liffeyMainData() {
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
                return '0.01';
              case 2:
                return '0.02';
              case 3:
                return '0.03';
              case 4:
                return '0.04';
              case 5:
                return '0.05';
              case 6:
                return '0.06';
              case 7:
                return '0.07';
              case 8:
                return '0.08';
              case 9:
                return '0.09';
              case 10:
                return '0.10';
              case 11:
                return '0.11';
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
      maxY: 12,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 7.2),
            FlSpot(2, 10.5),
            FlSpot(4, 3.1),
            FlSpot(6, 4),
            FlSpot(8, 3),
            FlSpot(10, 2),
            FlSpot(11, 2),
          ],
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
