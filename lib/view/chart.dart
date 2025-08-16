import 'package:echonet_lite_dashboard/colorVar.dart';
import 'package:el_webapi_api/el_webapi_api.dart';
import 'package:el_webapi_api/src/models/models.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../config.dart';
import '../view/views.dart';




// livingroom

List<List<FlSpot>> tempData0 = [[]], humidData0=[[]],lightData0=[[]],
             tempData1 =[[]], humidData1=[[]],lightData1=[[]],
             tempData2 =[[]], humidData2=[[]],lightData2=[[]],
             tempData3 =[[]], humidData3=[[]],lightData3=[[]],
             tempData4 =[[]], humidData4=[[]],lightData4=[[]],
             tempData5 =[[]], humidData5=[[]],lightData5=[[]],
             tempData6 =[[]], humidData6=[[]],lightData6=[[]],
             tempData7 =[[]], humidData7=[[]],lightData7=[[]],
             tempData8 =[[]], humidData8=[[]],lightData8=[[]],
             tempData9 =[[]], humidData9=[[]],lightData9=[[]],
             airData0=[[]],airData1=[[]],airData2=[[]],
             airData3=[[]],airData4=[[]],airData5=[[]],
             airData6=[[]],airData7=[[]],airData8=[[]],airData9=[[]];

        


List<List<List<List<FlSpot>>>> dataList = [
                               [tempData0, humidData0, lightData0, airData0],
                               [tempData1, humidData1, lightData1, airData1],
                               [tempData2, humidData2, lightData2, airData2],
                               [tempData3, humidData3, lightData3, airData3],
                               [tempData4, humidData4, lightData4, airData4],
                               [tempData5, humidData5, lightData5, airData5],
                               [tempData6, humidData6, lightData6, airData6],
                               [tempData7, humidData7, lightData7, airData7],
                               [tempData8, humidData8, lightData8, airData8],
                               [tempData9, humidData9, lightData9, airData9]];




List<FlSpot> getData(EchonetLiteDevice dev, int room, int num){
  if(dev.deviceType==DeviceType.temperatureSensor&&dataList[room][0].length>num) return dataList[room][0][num];
  if(dev.deviceType==DeviceType.humiditySensor&&dataList[room][1].length>num) return dataList[room][1][num];
  if(dev.deviceType==DeviceType.generalLighting&&dataList[room][2].length>num) return dataList[room][2][num];
  if(dev.deviceType==DeviceType.homeAirConditioner&&dataList[room][3].length>num) return dataList[room][3][num];
  return [];
}



Widget chart(List<List<dynamic>> chartList, DeviceType type) {
// Widget chart(EchonetLiteDevice dev, int room, int num) {
  
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: type==DeviceType.temperatureSensor? Color.fromARGB(38, 238, 216, 255):Color.fromARGB(130, 198, 227, 249), border: Border.all(color:type==DeviceType.temperatureSensor?Color.fromARGB(255, 234, 198, 249):Color.fromARGB(255, 198, 227, 249), width: 2)),
              width: 300,
              height: 200,
              child: LineChart(
                LineChartData(//sensor
                  titlesData: FlTitlesData(topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                     rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))
                     ,bottomTitles: AxisTitles(  
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 24,
                        // interval: 1,
                        getTitlesWidget: bottomTitleWidgets,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false), lineBarsData: [
                    for (List<dynamic> chart in chartList)
                  LineChartBarData(
                    spots: getData(chart[0], chart[1], chart[2]), color: type==DeviceType.temperatureSensor? Color.fromARGB(255, 220, 190,  200+chartList.indexOf(chart)*5):Color.fromARGB(255, 80, 180, 200+chartList.indexOf(chart)*5)
                    ),
                ],
                minY: type==DeviceType.temperatureSensor?-20:type==DeviceType.humiditySensor?0:0,
                maxY: type==DeviceType.temperatureSensor?40:type==DeviceType.humiditySensor?100:0
                )
              ),
            ),
        // ListView(children: [for(List<dynamic> list in chartList)
        //   Container(child: Text("list[2].toString()"), color: type==DeviceType.temperatureSensor? Color.fromARGB(255, 220, 190,  200+chartList.indexOf(list)*5):Color.fromARGB(255, 80, 180, 200+chartList.indexOf(list)*5),)
        // ])
      ],
    ),
  );

}


Widget bottomTitleWidgets(double value, TitleMeta meta) {
  DateTime time = DateTime.fromMillisecondsSinceEpoch(value.toInt());
    String text = time.hour.toString()+":";
    if(time.minute<10) text+="0";
    text+=time.minute.toString();

    if (value % (value.ceil()) == 0) return SideTitleWidget(
      fitInside: SideTitleFitInsideData(enabled: true, axisPosition: 0, parentAxisSize: 20, distanceFromEdge: 0),
      meta: meta,
      space: 4,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 8,
          color: colorVar().DevNameC,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    else return SideTitleWidget(
                  meta: meta,
                  child: Container(),
                );  
}


init(List<dynamic> devList)async{
  for(List<dynamic> list in tempId) list.clear();
  for(List<dynamic> list in humidId) list.clear();
  for(List<dynamic> list in lightId) list.clear();
  for(List<dynamic> list in airId) list.clear();
  for(dynamic dev in devList){
    if(dev.deviceType == DeviceType.temperatureSensor){
      int room = newMap.indexWhere((room)=>room.indexWhere((loc)=>loc.contains(dev.deviceId))>=0);
      if(room>=0)tempId[room].add(dev.deviceId);
    }else if(dev.deviceType == DeviceType.humiditySensor){
      int room = newMap.indexWhere((room)=>room.indexWhere((loc)=>loc.contains(dev.deviceId))>=0);
      if(room>=0)humidId[room].add(dev.deviceId);
    } else if(dev.deviceType == DeviceType.generalLighting){
      int room = newMap.indexWhere((room)=>room.indexWhere((loc)=>loc.contains(dev.deviceId))>=0);
      if(room>=0)lightId[room].add(dev.deviceId);
    } else if(dev.deviceType == DeviceType.homeAirConditioner){
      int room = newMap.indexWhere((room)=>room.indexWhere((loc)=>loc.contains(dev.deviceId))>=0);
      if(room>=0)airId[room].add(dev.deviceId);
    }
  }
}

updateList(List<dynamic> devList)async{
  double now = DateTime.now().millisecondsSinceEpoch.toDouble();
  bool midnight = false;
  if(DateTime.now().hour==0&&DateTime.now().minute==0) midnight = true;

  for(dynamic dev in devList){
    for(List<String> check in tempId) if (check.contains(dev.deviceId)){
      TemperatureSensor temp = dev as TemperatureSensor;
      int room = tempId.indexWhere((room)=>room.contains(dev.deviceId));
      int num = tempId[room].indexOf(dev.deviceId);
      while(dataList[room][0].length<num+1) dataList[room][0].add([]);
      if(midnight) getData(dev,room, num).removeLast();
      if(getData(dev,room, num).isEmpty||now-getData(dev,room, num).last.x>300000){ getData(dev,room, num).add(FlSpot(now, temp.value.toDouble()));}
      if(getData(dev,room, num).length>24){getData(dev,room, num).removeAt(0);}

    }
    for(List<String> check in humidId) if (check.contains(dev.deviceId)){
      HumiditySensor temp = dev as HumiditySensor;
      int room = humidId.indexWhere((room)=>room.contains(dev.deviceId));
      int num = humidId[room].indexOf(dev.deviceId);
      while(dataList[room][1].length<num+1) dataList[room][1].add([]);
      if(midnight) getData(dev,room, num).removeLast();
      if(getData(dev,room, num).isEmpty||now-getData(dev,room, num).last.x>300000){ getData(dev,room, num).add(FlSpot(now, temp.value.toDouble()));}
      if(getData(dev,room, num).length>24){getData(dev,room, num).removeAt(0);}
    }    
    for(List<String> check in lightId) if (check.contains(dev.deviceId)){
      GeneralLighting temp = dev as GeneralLighting; 
      int room = lightId.indexWhere((room)=>room.contains(dev.deviceId));
      int num = lightId[room].indexOf(dev.deviceId);print(lightId[room]);print(dev.deviceId+" "+num.toString());
      while(dataList[room][2].length<num+1) dataList[room][2].add([]);
      if(midnight) getData(dev,room, num).removeLast();
      if(getData(dev,room, num).isEmpty||now-getData(dev,room, num).last.x>600000){ getData(dev,room, num).add(FlSpot(now, temp.operationStatus?1:0));}
      if(getData(dev,room, num).length>24){getData(dev,room, num).removeAt(0);}
      print(getData(dev,room, num));
   }  
   for(List<String> check in airId) if (check.contains(dev.deviceId)){
      HomeAirConditioner temp = dev as HomeAirConditioner; 
      int room = airId.indexWhere((room)=>room.contains(dev.deviceId));
      int num = airId[room].indexOf(dev.deviceId);//print(airId[room]);//print(dev.deviceId+" "+num.toString());
      while(dataList[room][3].length<num+1) dataList[room][3].add([]);
      if(midnight) getData(dev,room, num).removeLast();
      if(getData(dev,room, num).isEmpty||now-getData(dev,room, num).last.x>600000){ getData(dev,room, num).add(FlSpot(now, temp.operationStatus?1:0));}
      if(getData(dev,room, num).length>24){getData(dev,room, num).removeAt(0);}
      // print(getData(dev,room, num));
   }  
  }
  

}