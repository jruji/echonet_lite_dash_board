import 'dart:async';

import 'package:echonet_lite_dashboard/view/views.dart';

import 'package:el_webapi_api/src/models/models.dart';
import '/config.dart';
import '../models/models.dart';
import '../repository/repositories.dart';
import '../view/chart.dart' as chart;

class DeviceListBloc {
  DeviceListRepository? _repository;
  StreamController<Response<List<EchonetLiteDevice>>>? _controller;
  Timer? _timer;
  bool? displayFlag;
  StreamSink get deviceListSink =>
      _controller!.sink;
  Stream<Response<List<EchonetLiteDevice>>> get deviceStream =>
      _controller!.stream;

  DeviceListBloc(Future<RegisteredDeviceList> list) {
    displayFlag = false;
    _controller =
        StreamController<Response<List<EchonetLiteDevice>>>.broadcast();
    _repository = DeviceListRepository();
    Future<List<EchonetLiteDevice>> devList =  fetchDeviceList(list);
    _timer = Timer.periodic(Duration(seconds: 30), (_timer) async {
      if (!_controller!.isClosed) {
          updateList(list);
          chart.updateList(await devList as List<dynamic>);
      }
    });
  }

  Future<List<EchonetLiteDevice>> fetchDeviceList(Future<RegisteredDeviceList> list) async {
    if (!displayFlag!) {
      deviceListSink.add(Response<List<EchonetLiteDevice>>.loading('Loading device list'));
      displayFlag = true;
    }
List<EchonetLiteDevice> devices = [];
    try {
      
            RegisteredDeviceList newlist = await list;
              for (Profile profile in newlist.profiles){
       devices.add( await _repository!.fetchDeviceList(profile));
      deviceListSink.add(Response<List<EchonetLiteDevice>>.completed(devices));}

      init(devices);
    } catch (e) {
      deviceListSink.add(Response<List<EchonetLiteDevice>>.error(e.toString()));
      print('error ' + e.toString());
    }
    
    return devices;
  }

  updateList(Future<RegisteredDeviceList> list)async{
      if (!displayFlag!) {
      deviceListSink.add(Response<List<EchonetLiteDevice>>.loading('Loading device list'));
      displayFlag = true;
    }

    try {
      
      deviceListSink.add(Response<List<EchonetLiteDevice>>.completed(await _repository!.updateList(await list)));
    } catch (e) {
      deviceListSink.add(Response<List<EchonetLiteDevice>>.error(e.toString()));
      print('error ' + e.toString());
    }
  }



  


  dispose() {
    _timer!.cancel();
    _controller!.close();
  }
}
