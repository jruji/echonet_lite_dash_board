import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:el_webapi_api/el_webapi_api.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

import '../blocs/blocs.dart';
import '../edit.dart' as edit;
import '../models/models.dart';
import '../view/views.dart';
import '../colorVar.dart';
import '../config.dart';

class GetDeviceList extends StatefulWidget {
  static const Key k = Key('');
  const GetDeviceList({Key? key = k}) : super(key: key);
  @override
  State<GetDeviceList> createState() => _GetDeviceListState();
}

class _GetDeviceListState extends State<GetDeviceList> {
  late ConnectivityBloc _netBloc;
  late DeviceListBloc _bloc;
  late DisplayFilter displayFilter;
  late bool _on_selected;
  late bool _off_selected;
  late bool _error_selected;
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
    _on_selected = true;
    _off_selected = true;
    _error_selected = true;
    displayFilter = DisplayFilter(
        on_device: _on_selected,
        off_device: _off_selected,
        error_device: _error_selected,
        filter: "");
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
          title: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Color.fromARGB(50, 176, 196, 231),
              border: Border.all(
                color: const Color.fromARGB(255, 176, 196, 231),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              onChanged: (value) {
                this.displayFilter.filter = value.toLowerCase();
                setState(() {});
              },
              decoration: InputDecoration(
                  hintText: 'Filter By Room', prefixIcon: Icon(Icons.search),
                  labelStyle: TextStyle(fontSize: 18, fontFamily: 'Quicksand'),
                  border: InputBorder.none,
              )    
            ),
          ),
          actions: <Widget>[
            Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.all(10),
                child: FilterChip(
                  label: Text("ON devices"),
                  selected: _on_selected,
                  onSelected: (bool value) {
                    _on_selected = value;
                    this.displayFilter.on_device = _on_selected;
                    setState(() {});
                  },
                  pressElevation: 15,
                  selectedColor: colorVar().onC,
                )),
            Container(
                
                alignment: Alignment.topCenter,
                margin: EdgeInsets.all(10),
                child: FilterChip(
                  label: Text("OFF devices"),
                  selected: _off_selected,
                  onSelected: (bool value) {
                    _off_selected = value;
                    this.displayFilter.off_device = _off_selected;
                    setState(() {});
                  },
                  pressElevation: 15,
                  selectedColor: colorVar().offC,
                )),
            Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.all(10),
                child: FilterChip(
                  label: Text("Error devices"),
                  selected: _error_selected,
                  onSelected: (bool value) {
                    _error_selected = value;
                    this.displayFilter.error_device = _error_selected;
                    setState(() {});
                  },
                  pressElevation: 15,
                  selectedColor: colorVar().errC,
                ))
          ]),
      body: StreamBuilder<ConnectivityResult>(
          stream: _netBloc.connectivityResultStream!.asBroadcastStream(),
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case ConnectivityResult.mobile:
              case ConnectivityResult.wifi:
              case ConnectivityResult.ethernet:
              Future<RegisteredDeviceList> list = _provider.getRegisteredDevices();
                //_bloc.fetchDeviceList(list);
                print('NET : ');
                return RefreshIndicator(
                  onRefresh: () async => updateList(await _bloc.fetchDeviceList(list)),
                  child: 
                  StreamBuilder<Response<List<EchonetLiteDevice>>>(
                    stream: _bloc.deviceStream.asBroadcastStream(),
                    builder: (context, snapshot) {
                      // _provider.fetchRegisteredDevicesResources(snapshot.data.data);
                      if (snapshot.hasData) {
                        switch (snapshot.data!.status) {
                          case Status.LOADING:
                            return Loading(
                                loadingMessage: snapshot.data!.message);
                          case Status.COMPLETED:
                            List<EchonetLiteDevice> devices =
                                _filterListFilter(snapshot.data!.data);
                            if (devices.isEmpty) {
                              return Text('No device found!');
                            } else {
                              return DeviceList(devList: devices);
                            }
                          case Status.ERROR:
                            break;
                        }
                      }
                      // return DeviceList(devList: _bloc.fetchDeviceList(list));
                      return Loading(loadingMessage: 'Connecting');
                    },
                  )
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
    );
  }

  List<EchonetLiteDevice> _filterListFilter(List<EchonetLiteDevice> oldList)  {
    List<EchonetLiteDevice> newList = [];
    oldList.forEach((dev) {
      if (dev.faultStatus &&
          displayFilter.error_device &&
          dev.installationLocation
              .toLowerCase()
              .contains(displayFilter.filter)) {
        newList.add(dev);
      } else if (!dev.faultStatus &&
          dev.operationStatus &&
          displayFilter.on_device &&
          dev.installationLocation
              .toLowerCase()
              .contains(displayFilter.filter)) {
        newList.add(dev);
      } else if (!dev.faultStatus &&
          !dev.operationStatus &&
          displayFilter.off_device &&
          dev.installationLocation
              .toLowerCase()
              .contains(displayFilter.filter)) {
        newList.add(dev);
      }
    });
    return newList;
  }
  
 
}

class Loading extends StatelessWidget {
  const Loading({Key? key, required this.loadingMessage}) : super(key: key);
  final String loadingMessage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          SizedBox(height: 30),
          CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(const Color.fromARGB(255, 136, 216, 138)))
        ],
      ),
    );
  }
}

class DeviceList extends StatelessWidget {
  final List<EchonetLiteDevice> devList;
  const DeviceList({Key? key, required this.devList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        padding: EdgeInsets.only(top: 20),
        itemBuilder: ((context, index) {
          EchonetLiteDevice el = devList[index];
          return DeviceInfor(
            aDevice: el,
          );
        }),
        itemCount: devList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width>1200?7:6, childAspectRatio: 4 / 5),
      ),
    );
  }
}

class DeviceInfor extends StatelessWidget {
  final EchonetLiteDevice aDevice;
  const DeviceInfor({Key? key, required this.aDevice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(35),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GetDeviceDetailView(device: aDevice)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.width/60, left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: aDevice.faultStatus? const Color.fromARGB(255, 245, 99, 99): _tileColorByStatus(aDevice), width: 2),
            gradient: LinearGradient(begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              _tileColorByStatus(aDevice), Colors.white
            ]),
          ),
          child: Column(
                children: [
                  Image(
                    image: this.aDevice.deviceType==DeviceType.generalLighting||this.aDevice.deviceType==DeviceType.electricCurtain||this.aDevice.deviceType==DeviceType.electricWindow? AssetImage("assets/${this.aDevice.deviceType.toString().split('DeviceType.')[1]}${aDevice.operationStatus}.png"):AssetImage("assets/${this.aDevice.deviceType.toString().split('DeviceType.')[1]}.png"), 
                    //color: colorVar().DevNameC,
                    width: MediaQuery.of(context).size.width > 1000?35:30,
                    height: MediaQuery.of(context).size.width > 1000?35:30,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top:MediaQuery.of(context).size.width > 1300?MediaQuery.of(context).size.width/60:MediaQuery.of(context).size.width > 650?20:10),
                        child: MediaQuery.of(context).size.width > 940
                          ?Text(
                          aDevice.deviceType
                              .toString()
                              .split('DeviceType.')[1]
                              .titleCase,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                              color: colorVar().DevNameC,
                              fontWeight: FontWeight.bold, height: 1.1, fontSize: MediaQuery.of(context).size.width>1300?15:13),
                        ):null,
                      ),
                        Container(
                          child:  Text(aDevice.installationLocation,
                            textAlign: TextAlign.center,
                            style: TextStyle( color: Colors.black, height: 1.1, fontSize: MediaQuery.of(context).size.width>1300?14:MediaQuery.of(context).size.width > 640?12: 10, 
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: MediaQuery.of(context).size.width > 1200?5:MediaQuery.of(context).size.width > 750?3:2,
                            ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top:8),
                          child:aDevice.deviceType.toString().toLowerCase().contains("sensor")&&MediaQuery.of(context).size.width > 1030? Text(getValue(aDevice),
                                textAlign: TextAlign.center,
                                style: TextStyle( color: colorVar().DevNameC, height: 1.1, fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width>1300?14:12, 
                                )): null
                        )
                    ],
                  ),
                ],
              ),
        ),
      ),
    );
  }
}

Color _tileColorByStatus(EchonetLiteDevice device) {
  if (device.operationStatus) {
    return colorVar().onC;
  } else {
    return colorVar().offC;
  }
}

class DisplayFilter {
  DisplayFilter(
      {required this.on_device,
      required this.off_device,
      required this.error_device,
      required this.filter});
  bool on_device;
  bool off_device;
  bool error_device;
  String filter;
}
