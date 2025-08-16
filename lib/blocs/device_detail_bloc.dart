import 'dart:async';

import '../repository/device_detail_repository.dart';
import 'package:el_webapi_api/src/models/models.dart';

import '../models/models.dart';

class DeviceDetailBloc {
  DeviceDetailRepository? repository;
  StreamController<Response<EchonetLiteDevice>>? _controller;
  Timer? _timer;
  bool? _displayFlag;
  StreamSink get deviceInformationSink =>
      _controller!.sink;
  Stream<Response<EchonetLiteDevice>> get deviceInformationStream =>
      _controller!.stream;

  DeviceDetailBloc({required this.repository}) {
    _displayFlag = false;
    _controller = StreamController<Response<EchonetLiteDevice>>.broadcast();
    _timer = Timer.periodic(Duration(seconds: 5), (_timer) {
      if (!_controller!.isClosed) {
        fetchDeviceInformation();
      }
    });
  }

  fetchDeviceInformation() async {
    if (!_displayFlag!) {
      deviceInformationSink.add(Response<EchonetLiteDevice>.loading('Loading device list'));
      _displayFlag = true;
    }

    try {
      EchonetLiteDevice device = (await this.repository?.fetchDeviceInformation()) as EchonetLiteDevice;
      deviceInformationSink.add(Response<EchonetLiteDevice>.completed(device));
    } catch (e) {
      deviceInformationSink.add(Response<EchonetLiteDevice>.error(e.toString()));
      print('error ' + e.toString());
    }
  }

  dispose() {
    _controller!.close();
    _timer!.cancel();
  }
}
