import 'package:echonet_lite_dashboard/colorVar.dart';
import 'package:el_webapi_api/el_webapi_api.dart';
import 'package:el_webapi_api/src/models/models.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:recase/recase.dart';
import '../config.dart';
import '../view/views.dart';




Widget lightChart(EchonetLiteDevice dev, int room, int num) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Text(dev.deviceType.toString().split('DeviceType.')[1].titleCase+" "+num.toString()),
        Container(
          padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Color.fromARGB(130, 249, 234, 198), border: Border.all(color:Color.fromARGB(255, 249, 232, 198), width: 2)),
              width: 300,
              height: 80,
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                     rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))
                     ,bottomTitles: AxisTitles(  
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 24,
                        interval: 600000,
                        getTitlesWidget: bottomTitleWidgets,
                      ),
                    ),
                    leftTitles: AxisTitles(  
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        // interval: 1,
                        getTitlesWidget:leftTitleWidgets,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false), 
                  lineBarsData: [
                    LineChartBarData(
                      dashArray: [10,6],
                      spots: getData(dev, room, num),
                      dotData: FlDotData(getDotPainter: (spot, percent, barData, index) {
                        if (spot.y==0) {
                          return FlDotCirclePainter(
                            radius: 5,
                            color: colorVar().offC,
                          );
                        } else {
                          return FlDotCirclePainter(
                            radius: 5,
                            color: colorVar().onC,
                          );
                        }
                      },)
                    ),
                  ],
                  
                minY: 0,
                maxY: 1
                ),
              ),
            ),
      ],
    ),
  );

}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  if(value==1)
    return SideTitleWidget(
      fitInside: SideTitleFitInsideData(enabled: true, axisPosition: 0, parentAxisSize: 20, distanceFromEdge: 4),

      meta: meta,
      space: 8,
      child: Text(
        "ON ",
        style: TextStyle(
          fontSize: 10,
          color: colorVar().DevNameC,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  else return SideTitleWidget(
      meta: meta,
      space: 4,
      child: Text(
        "OFF  ",
        style: TextStyle(
          fontSize: 10,
          color: colorVar().DevNameC,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  
}

