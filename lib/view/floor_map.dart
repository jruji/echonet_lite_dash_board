import 'dart:math';
import 'dart:ui';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:el_webapi_api/el_webapi_api.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

import '../blocs/blocs.dart';
import '../models/models.dart';
import '../view/views.dart';
import '../colorVar.dart';
import '../edit.dart' as edit;
import '../config.dart';


class GetFloorMap extends StatefulWidget {
  static const Key k = Key('');
  const GetFloorMap({Key? key = k}) : super(key: key);
  @override
  State<GetFloorMap> createState() => _GetFloorMapState();
}

class _GetFloorMapState extends State<GetFloorMap> {
  late ConnectivityBloc _netBloc;
  late DeviceListBloc _bloc;
  late int room;
  late String roomName;
   edit.ElWebApiClient _provider = edit.ElWebApiClient(url: serverUrl, header: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $accessToken',
  });
  @override
  void initState() {
        Future<RegisteredDeviceList> list = _provider.getRegisteredDevices();

    _netBloc = ConnectivityBloc();
    _bloc = DeviceListBloc(list);
    room = 0;
    roomName = "Living Room";

    String text =parseMap.replaceAll("\\s", "");
    for(int i=0; i<roomNum;i++){
      tempId.add([]);
      humidId.add([]);
      lightId.add([]);
      airId.add([]);
      newMap.add([]);
      for(int j=0; j<text.split("[[")[i+1].split("], [").length;j++){
        newMap[i].add([]);
        for(int k=0; k<text.split("[[")[i+1].split("], [")[j].replaceAll("\\s+", "").replaceAll("]],", "").replaceAll("[", "").replaceAll("]", "").split(",").length;k++)
        newMap[i][j].add(text.split("[[")[i+1].split("], [")[j].replaceAll("\\s+", "").replaceAll("]],", "").replaceAll("[", "").replaceAll("]", "").split(",")[k].trim());
      }  
    }
print(newMap);
    super.initState();
  }

  @override
  void dispose() {
    _netBloc.dispose();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 5.0,
          centerTitle: true,
          title: Text("Floor Map"),
          
           ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: GridView.count(
              
              scrollDirection: Axis.horizontal,
              crossAxisCount: 1,
              shrinkWrap: false,
              addRepaintBoundaries: true,
              childAspectRatio: 0.4,
              children: <Widget>[
                for(int i =0; i<newMap.length;i++) roomButton(newMap[i][0][0], i)
              // roomButton("Living Room", 0),
              // roomButton("Kitchen", 1),
              // roomButton("Japanese Room", 2),
              // roomButton("Utility Room", 3),
              // roomButton("Bedroom", 4),
              // roomButton("Western 1 Room", 5),
              // roomButton("Western 2 Room", 6),
              // roomButton("Spare Room", 7),
              // roomButton("1F Hallway", 8),
              // roomButton("2F Hallway", 9)
              
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<ConnectivityResult>(
                stream: _netBloc.connectivityResultStream!.asBroadcastStream(),
                builder: (context, snapshot) {
                  switch (snapshot.data) {
                    case ConnectivityResult.mobile:
                    case ConnectivityResult.wifi:
                    case ConnectivityResult.ethernet:
                    Future<RegisteredDeviceList> list = _provider.getRegisteredDevices();
                      // _bloc.fetchDeviceList(list);
                      //print('NET : ');
                      return RefreshIndicator(
                        onRefresh: ()=>_bloc.fetchDeviceList(list),
                        child: StreamBuilder<Response<List<EchonetLiteDevice>>>(
                          stream: _bloc.deviceStream.asBroadcastStream(),
                          builder: (context, snapshot) {
                            
                            if (snapshot.hasData) {
                              switch (snapshot.data!.status) {
                                case Status.LOADING:
                                  return Loading(
                                      loadingMessage: snapshot.data!.message);
                                case Status.COMPLETED:
                                  List<dynamic> devices =snapshot.data!.data;
                                  if (devices.isEmpty) {
                                    return Text('No device found!');
                                  } else {
                                    updateList(devices);
                                    if(mapImplemented)
                                    return floorDeviceList(room: room, roomName: roomName, devList: devices);
                                    else return Text("The map has not been implemented");
                                  }
                                case Status.ERROR:
                                  break;
                              }
                            }
                            return Loading(loadingMessage: 'Connecting');
                          },
                        ),
                      );
                    case ConnectivityResult.none:
                    case ConnectivityResult.bluetooth:
                      return Center(
                        child: Text('No internet'),
                      );
                    case null:
                      // TODO: Handle this case.
                      throw UnimplementedError();
                    case ConnectivityResult.vpn:
                      // TODO: Handle this case.
                      throw UnimplementedError();
                    case ConnectivityResult.other:
                      // TODO: Handle this case.
                      throw UnimplementedError();
                  }
                }),
          ),
        ],
      ),
    );
  }


  

  Container roomButton(String label, int roomNum){
  return Container(
    
                alignment: Alignment.topCenter,
                margin: EdgeInsets.all(10),
                child: FilterChip(
                  
                  // labelStyle: TextStyle(overflow: ),
                  label: SizedBox(child: Text(label, textAlign: TextAlign.center,),width: label.length*8,),
                  selected: (room == roomNum),
                  onSelected: (bool value) {
                    room = roomNum;
                    roomName = label;
                    setState(() {});
                  },
                  showCheckmark: false,
                  pressElevation: 15,
                  selectedColor: const Color.fromARGB(255, 184, 214, 239),
                ));
  }
  
}



class floorDeviceList extends StatelessWidget {
  final List<dynamic> devList;
  final int room;
  final String roomName;
  const floorDeviceList({Key? key, required this.room, required this.roomName, required this.devList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<NamedAreaGridPlacement> layoutList = [];
    List<List<dynamic>> tchartList = [];//temp
    List<List<dynamic>> hchartList = [];//humid
    List<List<dynamic>> lchartList = [];//light
    List<List<dynamic>> achartList = [];//air
    
    for(EchonetLiteDevice aDevice in this.devList){
        int loc = newMap[room].indexWhere((loc)=> loc[0]==aDevice.deviceId);
        if(loc!=-1) {
          
          if(aDevice.deviceType==DeviceType.temperatureSensor) 
          { 
             tchartList.add([aDevice as TemperatureSensor,room,int.parse(newMap[room][loc][2])]);
          layoutList.add(info(aDevice, context).inGridArea(newMap[room][loc][1]));
          }else if(aDevice.deviceType==DeviceType.humiditySensor) 
          { 
             hchartList.add([aDevice,room,int.parse(newMap[room][loc][2])]);
          layoutList.add(info(aDevice, context).inGridArea(newMap[room][loc][1]));
          }else if(aDevice.deviceType==DeviceType.generalLighting) 
          { 
             lchartList.add([aDevice,room,int.parse(newMap[room][loc][2])]);
          layoutList.add(info(aDevice, context,newMap[room][loc][2]).inGridArea(newMap[room][loc][1]));
          }else if(aDevice.deviceType==DeviceType.homeAirConditioner) 
          { 
             achartList.add([aDevice,room,int.parse(newMap[room][loc][2])]);
          layoutList.add(info(aDevice, context,newMap[room][loc][2]).inGridArea(newMap[room][loc][1]));
          }else{
            layoutList.add(info(aDevice, context, newMap[room][loc].length==3?newMap[room][loc][2]:null).inGridArea(newMap[room][loc][1]));
          }
        }
    }
    for(int i = 0; i<=9; i++)for(int j = 0; j<=9; j++)layoutList.add(Container(decoration: BoxDecoration(border: Border.all(color: Color.fromARGB(66, 125, 125, 125))),).inGridArea('$i$j'));
   
    return Row(
      children: [

            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width>1000?200:0, height: MediaQuery.of(context).size.width>1000?600:0,
              child: Container(width: MediaQuery.of(context).size.width>1000?200:0, height: MediaQuery.of(context).size.width>1000?200:0,decoration:BoxDecoration(image: DecorationImage(image:  AssetImage("assets/iHousemap${room}.png"))),)
            ),

        Container(
          width: MediaQuery.of(context).size.width>810?700:MediaQuery.of(context).size.width>600?MediaQuery.of(context).size.width-100:MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.width>810?700:MediaQuery.of(context).size.width>600?MediaQuery.of(context).size.width-100:MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/${roomName}.PNG"),
                alignment: Alignment(-1, -1), fit: BoxFit.contain 
              )
          ),
          child: LayoutGrid(
            columnSizes: repeat(10, [fixed(min((MediaQuery.of(context).size.height-120)/10,min((MediaQuery.of(context).size.width)/10,65)))]), rowSizes: repeat(10, [fixed(min((MediaQuery.of(context).size.width)/10,min((MediaQuery.of(context).size.height-120)/10,65)))]),
            areas: '''
              00 01 02 03 04 05 06 07 08 09 
              10 11 12 13 14 15 16 17 18 19 
              20 21 22 23 24 25 26 27 28 29
              30 31 32 33 34 35 36 37 38 39
              40 41 42 43 44 45 46 47 48 49
              50 51 52 53 54 55 56 57 58 59
              60 61 62 63 64 65 66 67 68 69
              70 71 72 73 74 75 76 77 78 79
              80 81 82 83 84 85 86 87 88 89
              90 91 92 93 94 95 96 97 98 99
            ''',
            children: layoutList
                  
            ,
            )

        ),
        MediaQuery.of(context).size.width>=1400?Container(
          width: 400,
          child: ListView(
            addRepaintBoundaries: false,
            children:[
              Text("Temperature Sensor (°C)", textAlign: TextAlign.center,),chart(tchartList, DeviceType.temperatureSensor),
              for(List<dynamic> dev  in tchartList) Container(
                decoration: BoxDecoration(border: BoxBorder.fromLTRB(left: BorderSide(width: 12, color: Color.fromARGB(255, 220, 190,  200+tchartList.indexOf(dev)*5)))),
                child: Text(dev[0].deviceId, style: TextStyle(fontSize: 10,color: Colors.black ),)
              ),
              Text("Humidity (%)", textAlign: TextAlign.center,),chart(hchartList, DeviceType.humiditySensor),
              for(List<dynamic> dev  in hchartList) Container(
                decoration: BoxDecoration(border: BoxBorder.fromLTRB(left: BorderSide(width: 12, color: Color.fromARGB(255, 80, 180,  200+tchartList.indexOf(dev)*5)))),
                child: Text(dev[0].deviceId, style: TextStyle(fontSize: 10,color: Colors.black ),)
              ),              for(List<dynamic> dev in lchartList) lightChart(dev[0], dev[1], dev[2]),
              for(List<dynamic> dev in achartList) lightChart(dev[0], dev[1], dev[2])]
          ),
        ):Container()
      ],
    );
  }

  Container info(EchonetLiteDevice aDevice, BuildContext context, [String? label]){
      return Container(
        child: InkWell(
        borderRadius: BorderRadius.circular(35),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GetDeviceDetailView(device: aDevice)));
        },
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Container(
            width: ((MediaQuery.of(context).size.width-110)/10),
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width/160),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: aDevice.faultStatus?colorVar().errC: _tileColorByStatus(aDevice), width: 2),
              gradient: LinearGradient(begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                _tileColorByStatus(aDevice), const Color.fromARGB(200, 255, 255, 255)
              ]),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Column(
                    children: [
                      Image(
                        image: AssetImage("assets/${aDevice.deviceType.toString().split('DeviceType.')[1]}.png"), 
                        //color: colorVar().DevNameC,
                        width: (aDevice.deviceType.toString().toLowerCase().contains("sensor")||label!=null)?20:MediaQuery.of(context).size.width > 760?30:15,
                        height: (aDevice.deviceType.toString().toLowerCase().contains("sensor")||label!=null)?20:MediaQuery.of(context).size.width > 760?30:15,
                      ),
                      Column(
                        children: [
                          
                              Container( 
                          child: aDevice.deviceType.toString().toLowerCase()
                  .contains("sensor")&&MediaQuery.of(context).size.width > 700? Text(getValue(aDevice),
                                textAlign: TextAlign.center,
                                style: TextStyle( color: Colors.black, height: 1.1, fontWeight: FontWeight.bold, fontSize:  9, 
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                ):label!=null&&MediaQuery.of(context).size.width > 700? Text(label,textAlign: TextAlign.center,
                                style: TextStyle( color: Colors.black, height: 1.1, fontWeight: FontWeight.bold, fontSize:  9, 
                                )):null,
                        )
                        ],
                      ),
                        
                    ],
                  ),
            ),
          ),
        ),
            ),
      );
  } 
}




// class floorDeviceInfor extends StatelessWidget {
//   final EchonetLiteDevice aDevice;
//   const floorDeviceInfor({Key? key, required this.aDevice}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(35),
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => GetDeviceDetailView(device: aDevice)));
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Container(
//           padding: EdgeInsets.only(top: MediaQuery.of(context).size.width/160),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(25),
//             border: Border.all(color: _tileColorByStatus(aDevice), width: 2),
//             gradient: LinearGradient(begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: <Color>[
//               _tileColorByStatus(aDevice), Colors.white
//             ]),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//                   children: [
//                     Image(
//                       image: AssetImage("assets/${this.aDevice.deviceType.toString().split('DeviceType.')[1]}.png"), 
//                       //color: colorVar().DevNameC,
//                       width: MediaQuery.of(context).size.width > 920?20:0,
//                       height: MediaQuery.of(context).size.width > 920?20:0,
//                     ),
//                     Column(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(top: MediaQuery.of(context).size.width > 920?10:5),
//                           child: MediaQuery.of(context).size.width > 1250?Text(
//                                 aDevice.deviceType
//                                     .toString()
//                                     .split('DeviceType.')[1]
//                                     .titleCase,
//                                 textAlign: TextAlign.center,
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 2,
//                                 style: TextStyle(
//                                     color: colorVar().DevNameC,
//                                      height: 1.1, fontSize: 10),
//                               ): null,
                              
//                             ),
//                             Container( 
//                         child: aDevice.deviceType.toString().toLowerCase()
//                 .contains("sensor")? Text(getValue(aDevice),
//                               textAlign: TextAlign.center,
//                               style: TextStyle( color: Colors.black, height: 1.1, fontWeight: FontWeight.bold, fontSize:  8, 
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 2,
//                               ):null,
//                       )
//                       ],
//                     ),
                      
//                   ],
//                 ),
//           ),
//         ),
//       ),
//     );
//   }


  
// }

Color _tileColorByStatus(EchonetLiteDevice device) {
  if (device.operationStatus) {
    return const Color.fromARGB(255, 151, 202, 244);
  } else {
    return Colors.grey;
  }
}

String getValue(EchonetLiteDevice dev){
  switch (dev.deviceType) {
    
    case DeviceType.bathHeatingStatusSensor:
      BathHeatingStatusSensor d =
          dev as BathHeatingStatusSensor;
          return d.detection==true? "Detected": "Undetected";
    case DeviceType.co2Sensor:
      Co2Sensor d = dev as Co2Sensor;
      return d.value.toString();
    case DeviceType.currentSensor:
      CurrentSensor d = dev as CurrentSensor;
      return "Rated V: "+d.ratedVoltage.toString();
    case DeviceType.electricEnergySensor:
      ElectricEnergySensor d = dev as ElectricEnergySensor;
      return "Effective V: "+d.effectiveVoltageValue.toString();
    case DeviceType.humanDetectionSensor:
      HumanDetectionSensor d = dev as HumanDetectionSensor;
      return d.detection==true? "Detected": "Undetected";
    case DeviceType.humiditySensor:
      HumiditySensor d = dev as HumiditySensor;
      return d.value.toString()+" %";
    case DeviceType.illuminanceSensor:
      IlluminanceSensor d = dev as IlluminanceSensor;
      return "Klux: "+d.valueInKlux.toString();
    case DeviceType.temperatureSensor:
      TemperatureSensor d = dev as TemperatureSensor;
      return d.value.toString()+" °C";
    case DeviceType.vocSensor:
      VocSensor d = dev as VocSensor;
      return d.detection==true? "Detected": "Undetected";
    default: return "";
  }
}

