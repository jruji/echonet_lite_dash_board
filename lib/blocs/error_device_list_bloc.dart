import 'dart:async';

import 'package:el_webapi_api/src/models/models.dart';
import '/config.dart';
import '../models/models.dart';
import '../repository/repositories.dart';

class ErrorDeviceListBloc {
  DeviceListRepository? _repository;
  StreamController<Response<List<EchonetLiteDevice>>>? _controller;
  Timer? _timer;
  bool? displayFlag;
  StreamSink get deviceListSink =>
      _controller!.sink;
  Stream<Response<List<EchonetLiteDevice>>> get deviceStream =>
      _controller!.stream;

  ErrorDeviceListBloc(Future<RegisteredDeviceList> list) {
    displayFlag = false;
    _controller =
        StreamController<Response<List<EchonetLiteDevice>>>.broadcast();
    _repository = DeviceListRepository();
    _timer = Timer.periodic(Duration(seconds: 30), (_timer) {
      if (!_controller!.isClosed) {
        fetchDeviceList(list);
      }
    });
  }

  fetchDeviceList(Future<RegisteredDeviceList> list) async {
    if (!displayFlag!) {
      deviceListSink.add(Response<List<EchonetLiteDevice>>.loading('Loading error device list'));
      displayFlag = true;
    }

    try {
      EchonetLiteDevice device;
      final errorList = <EchonetLiteDevice>{};

      RegisteredDeviceList newlist = await list;
      for (Profile profile in newlist.profiles){
       device = (await _repository!.fetchDeviceList(profile));
       if(device.faultStatus) errorList.add(device);
      }

      deviceListSink.add(Response<List<EchonetLiteDevice>>.completed(errorList.toList()));
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
