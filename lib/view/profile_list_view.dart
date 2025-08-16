import 'package:connectivity_plus/connectivity_plus.dart';
import '../colorVar.dart';
import '../view/device_group_view.dart';
import 'package:el_webapi_api/src/models/models.dart';
import '/config.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

import '../blocs/blocs.dart';
import '../models/models.dart';
import 'views.dart';

class GetProfilesView extends StatefulWidget {
  const GetProfilesView({Key? key}) : super(key: key);

  @override
  State<GetProfilesView> createState() => _GetProfilesViewsState();
}

class _GetProfilesViewsState extends State<GetProfilesView> {
  late ConnectivityBloc _netBloc;
  late ProfileListBloc _bloc;
  late DisplayFilter displayFilter;
  late bool _normal_selected;
  late bool _warning_selected;
  late bool _error_selected;

  @override
  void initState() {
    _netBloc = ConnectivityBloc();
    _bloc = ProfileListBloc();
    _normal_selected = true;
    _warning_selected = true;
    _error_selected = true;
    displayFilter = DisplayFilter(
        on_device: _normal_selected,
        off_device: _warning_selected,
        error_device: _error_selected, filter: '');
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
        elevation: 4,
        centerTitle: true,
        title: Text(
          'Group of ECHONET Lite devices',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.all(10),
              child: FilterChip(
                label: Text("Normal Groups"),
                selected: _normal_selected,
                onSelected: (bool value) {
                  _normal_selected = value;
                  this.displayFilter.on_device = _normal_selected;
                  setState(() {});
                },
                pressElevation: 15,
                selectedColor: const Color.fromRGBO(182, 239, 184, 1),
              )),
          Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.all(10),
              child: FilterChip(
                label: Text("Warning Groups"),
                selected: _warning_selected,
                onSelected: (bool value) {
                  _warning_selected = value;
                  this.displayFilter.off_device = _warning_selected;
                  setState(() {});
                },
                pressElevation: 15,
                selectedColor: const Color.fromARGB(255, 243, 233, 147),
              )),
          Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.all(10),
              child: FilterChip(
                label: Text("Error Group"),
                selected: _error_selected,
                onSelected: (bool value) {
                  _error_selected = value;
                  this.displayFilter.error_device = _error_selected;
                  setState(() {});
                },
                pressElevation: 15,
                selectedColor: colorVar().redC,
              ))
        ],
      ),
      body: StreamBuilder<ConnectivityResult>(
          stream: _netBloc.connectivityResultStream!.asBroadcastStream(),
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case ConnectivityResult.mobile:
              case ConnectivityResult.wifi:
              case ConnectivityResult.ethernet:
                _bloc.fetchProfiles();
                //print('NET : ');
                return RefreshIndicator(
                  onRefresh: () => _bloc.fetchProfiles(),
                  child: StreamBuilder<Response<List<EchonetLiteDevice>>>(
                    stream: _bloc.profileListStream!.asBroadcastStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data!.status) {
                          case Status.LOADING:
                            return Loading(
                                loadingMessage: snapshot.data!.message);
                            break;
                          case Status.COMPLETED:
                            List<ProfileCard> profiles = _applyFilter(
                                _getProfileCards(snapshot.data!.data));

                            if (profiles.length == 0) {
                              return Text('No group found!');
                            } else {
                              return DisplayProfile(profileCards: profiles);
                            }
                            break;
                          case Status.ERROR:
                            break;
                        }
                      }
                      return Loading(loadingMessage: 'Connecting');
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

  List<ProfileCard> _applyFilter(List<ProfileCard> oldList) {
    List<ProfileCard> newList = [];
    oldList.forEach((card) {
      if (card.errorCount == card.elementCount && displayFilter.error_device) {
        newList.add(card);
      } else if (card.errorCount > 0 &&
          card.errorCount < card.elementCount &&
          displayFilter.off_device) {
        newList.add(card);
      } else if (card.errorCount == 0 && displayFilter.on_device) {
        newList.add(card);
      }
    });
    return newList;
  }

  List<ProfileCard> _getProfileCards(List<EchonetLiteDevice> devices) {
    List<ProfileCard> list = [];
    Map<DeviceType, int> typeMap = new Map();
    devices.forEach((element) {
      if (!typeMap.containsKey(element.deviceType)) {
        typeMap[element.deviceType] = 1;
      } else {
        var count = typeMap[element.deviceType];
        typeMap[element.deviceType] = count!+1;
      }
    });

    typeMap.entries.forEach((element) {
      list.add(ProfileCard(
          type: element.key,
          elementCount: element.value,
          errorCount: _countError(devices, element.key)));
    });

    return list;
  }

  int _countError(List<EchonetLiteDevice> devices, DeviceType type) {
    int count = 0;
    devices.forEach((element) {
      if (element.deviceType == type && element.faultStatus) {
        count++;
      }
    });
    return count;
  }
}

class DisplayProfile extends StatelessWidget {
  final List<ProfileCard> profileCards;
  DisplayProfile({Key? key, required this.profileCards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: GridView.builder(
        itemBuilder: ((context, index) {
          return DislayProfileCard(profileCard: profileCards[index]);
        }),
        itemCount: profileCards.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6, childAspectRatio: 4 / 5),
      ),
    );
  }
}

class DislayProfileCard extends StatelessWidget {
  final ProfileCard profileCard;
  const DislayProfileCard({Key? key, required this.profileCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: profileCard.type == DeviceType.notYetSupported
          ? null
          : () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GetDeviceGroupView(
                            deviceType: profileCard.type,
                            numberOfDevice: profileCard.elementCount,
                            numberOfError: profileCard.errorCount,
                          )));
            },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.width/100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: _borderColor(), width: 2),
            gradient: LinearGradient(begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              _borderColor(), Colors.white
            ]),
          ),

          child: Container(
            padding: EdgeInsets.only(top:MediaQuery.of(context).size.width > 1300?  MediaQuery.of(context).size.width/40: 10, left: 10, right: 10),
            child: Column(
              children: [
                Image(
                      image: AssetImage("assets/${this.profileCard.type.toString().split('DeviceType.')[1]}.png"), 
                      //color: colorVar().DevNameC,
                      width: MediaQuery.of(context).size.width > 1300?50:MediaQuery.of(context).size.width > 1000?40:30,
                      height: MediaQuery.of(context).size.width > 1300?50:MediaQuery.of(context).size.width > 1000?40:30,
                    ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.width > 1300?20:10),
                          child:  Text(
                            '${profileCard.elementCount} of ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: colorVar().DevNameC,
                                fontSize:  10,
                                fontWeight: FontWeight.bold, height: 1 ),
                                
                              )
                          ,
                        ),
                          Container(
                            child: Text(
                                profileCard.type
                                    .toString()
                                    .split('DeviceType.')[1]
                                    .titleCase,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:  MediaQuery.of(context).size.width > 640?12:10,
                                    fontWeight: FontWeight.normal, height: 1
                                    ),
                                    overflow: TextOverflow.ellipsis, maxLines: MediaQuery.of(context).size.width > 750?3:2
                                    ),
                          ),
                        
                      ],
                    ),
                  ],
                ),
                Container(
                  child: _displayNumberOfError(profileCard.errorCount),
                  padding: EdgeInsets.only(top: 10),
                )
            
              ],
            ),
          ),
        ),
      ),
    );
  }

  LinearGradient _tileColor() {
    var error = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: [
        0.1,
        0.4,
        0.6,
        0.9,
      ],
      colors: [
        Colors.white,
        const Color.fromARGB(255, 255, 150, 161),
        const Color.fromARGB(255, 230, 116, 116),
        Colors.red,
      ],
    );
    var warning = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: [
        0.1,
        0.4,
        0.6,
        0.9,
      ],
      colors: [
        Colors.white,
        const Color.fromARGB(255, 255, 224, 178),
        const Color.fromARGB(255, 255, 183, 77),
        Colors.orange,
      ],
    );
    var notSupport = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: [
        0.1,
        0.4,
        0.6,
        0.9,
      ],
      colors: [
        Colors.white,
        Colors.black12,
        Colors.black38,
        Colors.black54,
      ],
    );
    var normal = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: [
        0.1,
        0.4,
        0.6,
        0.9,
      ],
      colors: [
        Colors.green,
        Colors.green,
        Colors.green,
        Colors.green,
      ],
    );
    if (profileCard.type == DeviceType.notYetSupported) {
      return notSupport;
    }
    if (profileCard.errorCount == profileCard.elementCount) {
      return error;
    } else if (profileCard.errorCount == 0) {
      return normal;
    } else {
      return warning;
    }
  }

  Color _borderColor() {
    if (profileCard.type == DeviceType.notYetSupported) {
      return Colors.grey;
    }
    if (profileCard.errorCount == profileCard.elementCount) {
      return colorVar().redC;
    } else if (profileCard.errorCount == 0) {
      return const Color.fromARGB(255, 171, 233, 173);
    } else {
      return const Color.fromARGB(255, 240, 230, 145);
    }
  }
}

Widget _displayNumberOfError(int error) {
  if (error > 0) {
    return Container(
      child: Container(
        padding: EdgeInsets.all(2),
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: colorVar().redC),
        alignment: Alignment.center,
        child: Text(
          '$error',
          style: TextStyle(fontSize: 10, color: Colors.white),
        ),
      ),
    );
  } else {
    return Container();
  }
}

class DisplayError extends StatelessWidget {
  final String errorMsg;
  DisplayError({Key? key, required this.errorMsg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        this.errorMsg,
        style: TextStyle(color: colorVar().redC, fontSize: 40),
      ),
    );
  }
}
