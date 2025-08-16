import 'dart:async';

import 'package:el_webapi_api/src/models/models.dart';
import '/config.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../repository/repositories.dart';

class DeviceGroupBloc {
  DeviceGroupRepository? _repository;
  StreamController<Response<List<EchonetLiteDevice>>>? _controller;
  int numberOfDevice;
  DeviceType deviceType;
  Timer? _timer;
  bool? _displayFlag;
  StreamSink get deviceGroupSink =>
      _controller!.sink;
  Stream<Response<List<EchonetLiteDevice>>>? get deviceGroupStream =>
      _controller!.stream;

  DeviceGroupBloc({required this.numberOfDevice, required this.deviceType}) {
    _displayFlag = false;
    _controller =
        StreamController<Response<List<EchonetLiteDevice>>>.broadcast();
    _repository = DeviceGroupRepository(type: this.deviceType);
    _timer =
        Timer.periodic(Duration(seconds: 3 * this.numberOfDevice), (_timer) {
      if (!_controller!.isClosed) {
        fetchDeviceGroupInfor();
      }
    });
  }

  fetchDeviceGroupInfor() async {
    if (!_displayFlag!) {
      deviceGroupSink.add(
          Response<List<EchonetLiteDevice>>.loading('Loading ${this.deviceType} information by type'));
      _displayFlag = true;
    }

    try {
      List<EchonetLiteDevice> device =
          await _repository!.fetchDeviceGroupInfor();
      deviceGroupSink.add(Response<List<EchonetLiteDevice>>.completed(device));
    } catch (e) {
      deviceGroupSink.add(Response<List<EchonetLiteDevice>>.error(e.toString()));
      print('error ' + e.toString());
    }
  }

  dispose() {
    _controller!.close();
    _timer!.cancel();
  }
}
