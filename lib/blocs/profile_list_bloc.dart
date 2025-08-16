import 'dart:async';

import 'package:el_webapi_api/src/models/models.dart';
import '/config.dart';
import '../models/models.dart';
import '../repository/repositories.dart';

class ProfileListBloc {
  ProfileListRepository? _repository;
  late StreamController<Response<List<EchonetLiteDevice>>> _controller;
  Timer? _timer;
  bool? _loadingMsgDislayed;
  StreamSink get profileListSink =>
      _controller.sink;
  Stream<Response<List<EchonetLiteDevice>>>? get profileListStream =>
      _controller.stream;

  ProfileListBloc() {
    _loadingMsgDislayed = false;
    _controller =
        StreamController<Response<List<EchonetLiteDevice>>>.broadcast();
    _repository = ProfileListRepository();
    _timer = Timer.periodic(Duration(seconds: 30), (_timer) {
      if (!_controller.isClosed) {
        fetchProfiles();
      }
    });
  }

  fetchProfiles() async {
    if (!_loadingMsgDislayed!) {
      profileListSink.add(Response<List<EchonetLiteDevice>>.loading(
          'Requesting [/elapi/v1/devices/{all_id}/properties/]...'));
      _loadingMsgDislayed = true;
    }

    try {
      List<EchonetLiteDevice> profileList = (await _repository!.fetchDeviceList()) as List<EchonetLiteDevice>;
      profileListSink.add(Response<List<EchonetLiteDevice>>.completed(profileList));
    } catch (e) {
      profileListSink.add(Response<List<EchonetLiteDevice>>.error(e.toString()));
      print('error ' + e.toString());
    }
  }

  dispose() {
    _timer!.cancel();
    _controller.close();
  }
}
