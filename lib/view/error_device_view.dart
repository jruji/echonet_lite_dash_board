import 'package:connectivity_plus/connectivity_plus.dart';
import '../edit.dart' as edit;
import 'package:el_webapi_api/src/models/models.dart';
import '../config.dart';
import 'package:flutter/material.dart';

import '../blocs/blocs.dart';
import '../models/models.dart';
import 'device_list_view.dart' as view;

class GetErrorDeviceListView extends StatefulWidget {
  const GetErrorDeviceListView({Key? key}) : super(key: key);

  @override
  State<GetErrorDeviceListView> createState() => _GetErrorDeviceListState();
}

class _GetErrorDeviceListState extends State<GetErrorDeviceListView> {
  late ConnectivityBloc _connectivityBloc;
  late DeviceListBloc _bloc;
  edit.ElWebApiClient _provider = edit.ElWebApiClient(url: serverUrl, header: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $accessToken',
  });
    @override
  void initState() {
        Future<RegisteredDeviceList> list = _provider.getRegisteredDevices();

    super.initState();
    _connectivityBloc = ConnectivityBloc();
    _bloc = DeviceListBloc(list);
  }

  @override
  void dispose() {
    _connectivityBloc.dispose();
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
          'Error Devices',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<ConnectivityResult>(
          stream:
              _connectivityBloc.connectivityResultStream?.asBroadcastStream(),
          builder: (context, snapshot) {
            print(snapshot.data);
            switch (snapshot.data) {
              case ConnectivityResult.mobile:
              case ConnectivityResult.wifi:
              case ConnectivityResult.ethernet:
               Future<RegisteredDeviceList> list = _provider.getRegisteredDevices();
              //  _bloc.fetchDeviceList(list);
                //print('NET : ');
                return RefreshIndicator(
                  onRefresh: () => _bloc.fetchDeviceList(list),
                  child: StreamBuilder<Response<List<EchonetLiteDevice>>>(
                    stream: _bloc.deviceStream.asBroadcastStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data!.status) {
                          case Status.LOADING:
                            return view.Loading(
                                loadingMessage: snapshot.data!.message);
                            break;
                          case Status.COMPLETED:
                            List<EchonetLiteDevice> devices =
                                _filterListFilter(snapshot.data!.data);
                            return view.DeviceList(devList: devices);
                            break;
                          case Status.ERROR:
                            break;
                        }
                      }
                      return view.Loading(loadingMessage: 'Connecting');
                    },
                  ),
                );
                break;
              case ConnectivityResult.none:
              case ConnectivityResult.bluetooth:
                return Center(
                  child: Text('No internet'),
                );
                break;
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
            return Container();
          }),
    );
  }

    List<EchonetLiteDevice> _filterListFilter(List<EchonetLiteDevice> oldList) {
      List<EchonetLiteDevice> newList = [];
    oldList.forEach((dev) {if(dev.faultStatus) newList.add(dev);
    });
    return newList;}
}
