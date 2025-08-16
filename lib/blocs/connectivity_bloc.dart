import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityBloc {
  late StreamController<ConnectivityResult> _connectivityController;
  StreamSink get connectivityResultSink =>
      _connectivityController.sink;
  Stream<ConnectivityResult>? get connectivityResultStream =>
      _connectivityController.stream;

  ConnectivityBloc() {
    _connectivityController = StreamController<ConnectivityResult>.broadcast();
    checkCurrentConnectivity();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectivityResultSink.add(result);
    });
  }

  void checkCurrentConnectivity() async {
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    connectivityResultSink.add(connectivityResult);
  }

  dispose() {
    _connectivityController.close();
  }
}
