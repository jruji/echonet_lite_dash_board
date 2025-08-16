import 'package:connectivity_plus/connectivity_plus.dart';
import '../blocs/blocs.dart';
import '../colorVar.dart';
import 'package:el_webapi_api/src/models/models.dart';
import '/config.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import 'views.dart' as view;

class GetDeviceGroupView extends StatefulWidget {
  final DeviceType deviceType;
  final int numberOfDevice;
  final int numberOfError;
  const GetDeviceGroupView(
      {Key? key, required this.deviceType, required this.numberOfDevice, required this.numberOfError})
      : super(key: key);

  @override
  State<GetDeviceGroupView> createState() => _GetDeviceGroupViewState();
}

class _GetDeviceGroupViewState extends State<GetDeviceGroupView> {
  late ConnectivityBloc _netBloc;
  late DeviceGroupBloc _bloc;
  @override
  void initState() {
    _netBloc = ConnectivityBloc();
    _bloc = DeviceGroupBloc(
        deviceType: widget.deviceType, numberOfDevice: widget.numberOfDevice);
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
        title: Text(
          'List of ${widget.deviceType}',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.warning,
              color: colorVar().errC,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => view.GetErrorDeviceListView()));
            },
            tooltip: 'See error devices',
          )
        ],
      ),
      body: StreamBuilder<ConnectivityResult>(
          stream: _netBloc.connectivityResultStream!.asBroadcastStream(),
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case ConnectivityResult.mobile:
              case ConnectivityResult.wifi:
              case ConnectivityResult.ethernet:
                _bloc.fetchDeviceGroupInfor();
                //print('NET : ');
                return RefreshIndicator(
                  onRefresh: () => _bloc.fetchDeviceGroupInfor(),
                  child: StreamBuilder<Response<List<EchonetLiteDevice>>>(
                    stream: _bloc.deviceGroupStream!.asBroadcastStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data!.status) {
                          case Status.LOADING:
                            return view.Loading(
                                loadingMessage: snapshot.data!.message);
                          case Status.COMPLETED:
                            List<EchonetLiteDevice> devices =
                                snapshot.data!.data;
                            if (devices.isEmpty) {
                              return Text('No device found!');
                            } else {
                              return view.DeviceList(devList: devices);
                            }
                          case Status.ERROR:
                            break;
                        }
                      }
                      return view.Loading(loadingMessage: 'Connecting');
                    },
                  ),
                );
              case ConnectivityResult.none:
              case ConnectivityResult.bluetooth:
                return Center(
                  child: Text('No internet'),
                );
              case null:
                throw UnimplementedError();
              case ConnectivityResult.vpn:
                throw UnimplementedError();
              case ConnectivityResult.other:
                throw UnimplementedError();
            }
          }),
    );
  }
}
