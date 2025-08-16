import 'package:connectivity_plus/connectivity_plus.dart';
import '../colorVar.dart';
import '../repository/repositories.dart';
import 'package:el_webapi_api/el_webapi_api.dart' as elDevice;

import 'package:flutter/material.dart';
import 'package:flutter_json_viewer/flutter_json_viewer.dart';
import '../blocs/blocs.dart';
import 'device_list_view.dart' as view;
import '../models/response.dart';
import 'package:recase/recase.dart';


class GetDeviceDetailView extends StatefulWidget {
  final elDevice.EchonetLiteDevice device;
  GetDeviceDetailView({required this.device});

  @override
  State<GetDeviceDetailView> createState() => _GetDeviceResourceState();
}

class _GetDeviceResourceState extends State<GetDeviceDetailView> {
  late ConnectivityBloc _connectivityBloc;
  late DeviceDetailBloc _bloc;
  late DeviceDetailRepository _deviceManager;
  @override
  void initState() {
    _connectivityBloc = ConnectivityBloc();
    _deviceManager = DeviceDetailRepository(
        deviceId: widget.device.deviceId, deviceType: widget.device.deviceType);
    _bloc = DeviceDetailBloc(repository: this._deviceManager);
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    bool isOn = widget.device.operationStatus;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 5.0,
        centerTitle: true,
        title: Text(
          'Device Information',
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
        actions: [
                
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8),
                  child: ElevatedButton(
                    onPressed: (){_deviceManager.turnOFF(); setState(() {
                      isOn = false;
                    });  },
                    child: Text(_deviceTypeToTextOFF(widget.device)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: isOn ? Color.fromARGB(255, 231, 231, 231) : colorVar().offC,
                        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                        fixedSize: Size.fromWidth(60),),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: (){_deviceManager.turnON(); setState(() {
                      isOn = true;
                    }); },
                    child: Text(_deviceTypeToTextON(widget.device)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: isOn? colorVar().onC: Color.fromARGB(255, 231, 231, 231),
                        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                        fixedSize: Size.fromWidth(60)),
                  ),
                ),
         
        ],
      ),
      body: StreamBuilder<ConnectivityResult>(
          stream:
              _connectivityBloc.connectivityResultStream!.asBroadcastStream(),
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case ConnectivityResult.mobile:
              case ConnectivityResult.wifi:
              case ConnectivityResult.ethernet:
                _bloc.fetchDeviceInformation();
                //print('NET : ');
                return RefreshIndicator(
                  onRefresh: () => _bloc.fetchDeviceInformation(),
                  child: StreamBuilder<Response<elDevice.EchonetLiteDevice>>(
                    stream: _bloc.deviceInformationStream.asBroadcastStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data?.status) {
                          case Status.LOADING:
                            return view.Loading(
                                loadingMessage: snapshot.data!.message);
                          case Status.COMPLETED:
                            return Device(aDevice: snapshot.data!.data);
                          case Status.ERROR:
                            break;
                          default:
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
                break;
              case ConnectivityResult.vpn:
                throw UnimplementedError();
              case ConnectivityResult.other:
                throw UnimplementedError();
            }
            return Container();
          }),
    );
  }

  String _deviceTypeToTextON(elDevice.EchonetLiteDevice device) {
    if (device.deviceType == elDevice.DeviceType.electricCurtain ||
        device.deviceType == elDevice.DeviceType.electricWindow) {
      return "OPEN";
    } else {
      return "ON";
    }
  }

  String _deviceTypeToTextOFF(elDevice.EchonetLiteDevice device) {
    if (device.deviceType == elDevice.DeviceType.electricCurtain ||
        device.deviceType == elDevice.DeviceType.electricWindow) {
      return "CLOSE";
    } else {
      return "OFF";
    }
  }
}

class Device extends StatelessWidget {
  final elDevice.EchonetLiteDevice aDevice;
  const Device({Key? key, required this.aDevice}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
          child: Container(
            width: MediaQuery.of(context).size.width-40,
            padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(
                      color:
                          aDevice.operationStatus ? Colors.blue : Colors.grey,
                      width: 5),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: ListView(
                children: [
                  detail(aDevice),
                
                  SingleChildScrollView(
                    child: toDeviceJson(aDevice),
                  ),],
              ),
                )),
    );
  }
}
RichText detail(elDevice.EchonetLiteDevice dev){
  return RichText(
  text: TextSpan(
    children: <TextSpan>[
      TextSpan(text: "${dev.deviceType
                              .toString()
                              .split('DeviceType.')[1].titleCase
                              } at ${dev.installationLocation}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      TextSpan(text: '\n\nDevice id: ${dev.deviceId}', style: TextStyle(fontSize: 16)),
      TextSpan(text: '\n\nFault Status: ${dev.faultStatus}', style: TextStyle(fontSize: 16)),
      dev.faultStatus?TextSpan(text: '\nFault Description: ${dev.faultDescription}', style: TextStyle(fontSize: 16)): TextSpan(text: ""),
      TextSpan(text: '\n\nManufacturer: ${dev.manufacturer.descriptions?.en} (${dev.manufacturer.code})', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      TextSpan(text: '\nManufacturer Fault Code: ${dev.manufacturerFaultCode}'),
      TextSpan(text: '\n\nBusiness Facility Code: ${dev.businessFacilityCode}', style: TextStyle( fontSize: 16)),
      TextSpan(text: '\n\nProduct Code: ${dev.productCode}', style: TextStyle( fontSize: 16)),
      TextSpan(text: '\nProduction Date: ${dev.productionDate}\n\n', style: TextStyle(fontSize: 16)),
    ],
  ),
);
}

Widget toDeviceJson(elDevice.EchonetLiteDevice dev) {
          Map<String, dynamic> newjson;

  switch (dev.deviceType) {
    case elDevice.DeviceType.electricCurtain:
      elDevice.ElectricCurtain json = dev as elDevice.ElectricCurtain;
      newjson = json.toJson();
      break;
    case elDevice.DeviceType.electricShade:
      elDevice.ElectricShade json = dev as elDevice.ElectricShade;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.electricWindow:
      elDevice.ElectricWindow json = dev as elDevice.ElectricWindow;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.airCleaner:
      elDevice.AirCleaner json = dev as elDevice.AirCleaner;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.airConditionerVentilationFan:
      elDevice.AirConditionerVentilationFan json =
          dev as elDevice.AirConditionerVentilationFan;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.bathHeatingStatusSensor:
      elDevice.BathHeatingStatusSensor json =
          dev as elDevice.BathHeatingStatusSensor;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.bathroomHeaterDryer:
      elDevice.BathroomHeaterDryer json = dev as elDevice.BathroomHeaterDryer;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.co2Sensor:
      elDevice.Co2Sensor json = dev as elDevice.Co2Sensor;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.coldOrHotWaterHeatSourceEquipment:
      elDevice.ColdOrHotWaterHeatSourceEquipment json =
          dev as elDevice.ColdOrHotWaterHeatSourceEquipment;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.commercialAirConditionerIndoorUnit:
      elDevice.CommercialAirConditionerIndoorUnit json =
          dev as elDevice.CommercialAirConditionerIndoorUnit;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.commercialAirConditionerOutdoorUnit:
      elDevice.CommercialAirConditionerOutdoorUnit json =
          dev as elDevice.CommercialAirConditionerOutdoorUnit;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.commercialShowcase:
      elDevice.CommercialShowcase json = dev as elDevice.CommercialShowcase;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.commercialShowcaseOutdoorUnit:
      elDevice.CommercialAirConditionerOutdoorUnit json =
          dev as elDevice.CommercialAirConditionerOutdoorUnit;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.controller:
      elDevice.Controller json = dev as elDevice.Controller;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.cookingHeater:
      elDevice.CookingHeater json = dev as elDevice.CookingHeater;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.currentSensor:
      elDevice.CurrentSensor json = dev as elDevice.CurrentSensor;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.electricEnergySensor:
      elDevice.ElectricEnergySensor json = dev as elDevice.ElectricEnergySensor;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.electricLock:
      elDevice.ElectricLock json = dev as elDevice.ElectricLock;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.electricRainDoor:
      elDevice.ElectricRainDoor json = dev as elDevice.ElectricRainDoor;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.electricWaterHeater:
      elDevice.ElectricWaterHeater json = dev as elDevice.ElectricWaterHeater;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.emergencyButton:
      elDevice.EmergencyButton json = dev as elDevice.EmergencyButton;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.enhancedLightingSystem:
      elDevice.EnhancedLightingSystem json =
          dev as elDevice.EnhancedLightingSystem;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.evCharger:
      elDevice.EvCharger json = dev as elDevice.EvCharger;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.evChargerDischarger:
      elDevice.EvChargerDischarger json = dev as elDevice.EvChargerDischarger;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.floorHeater:
      elDevice.FloorHeater json = dev as elDevice.FloorHeater;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.fuelCell:
      elDevice.FuelCell json = dev as elDevice.FuelCell;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.gasMeter:
      elDevice.GasMeter json = dev as elDevice.GasMeter;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.generalLighting:
      elDevice.GeneralLighting json = dev as elDevice.GeneralLighting;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.homeAirConditioner:
      elDevice.HomeAirConditioner json = dev as elDevice.HomeAirConditioner;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.humanDetectionSensor:
      elDevice.HumanDetectionSensor json = dev as elDevice.HumanDetectionSensor;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.humiditySensor:
      elDevice.HumiditySensor json = dev as elDevice.HumiditySensor;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.hvSmartElectricEnergyMeter:
      elDevice.HvSmartElectricEnergyMeter json =
          dev as elDevice.HvSmartElectricEnergyMeter;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.hybridWaterHeater:
      elDevice.HybridWaterHeater json = dev as elDevice.HybridWaterHeater;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.illuminanceSensor:
      elDevice.IlluminanceSensor json = dev as elDevice.IlluminanceSensor;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.instantaneousWaterHeater:
      elDevice.InstantaneousWaterHeater json =
          dev as elDevice.InstantaneousWaterHeater;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.lightingSystem:
      elDevice.LightingSystem json = dev as elDevice.LightingSystem;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.lvSmartElectricEnergyMeter:
      elDevice.LvSmartElectricEnergyMeter json =
          dev as elDevice.LvSmartElectricEnergyMeter;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.monoFunctionalLighting:
      elDevice.MonoFunctionalLighting json =
          dev as elDevice.MonoFunctionalLighting;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.powerDistributionBoardMetering:
      elDevice.PowerDistributionBoardMetering json =
          dev as elDevice.PowerDistributionBoardMetering;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.pvPowerGeneration:
      elDevice.PvPowerGeneration json = dev as elDevice.PvPowerGeneration;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.refrigerator:
      elDevice.Refrigerator json = dev as elDevice.Refrigerator;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.riceCooker:
      elDevice.RiceCooker json = dev as elDevice.RiceCooker;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.smartElectricEnergySubMeter:
      elDevice.SmartElectricEnergySubMeter json =
          dev as elDevice.SmartElectricEnergySubMeter;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.storageBattery:
      elDevice.StorageBattery json = dev as elDevice.StorageBattery;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.electricSwitch:
      elDevice.Switch json = dev as elDevice.Switch;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.temperatureSensor:
      elDevice.TemperatureSensor json = dev as elDevice.TemperatureSensor;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.tv:
      elDevice.Tv json = dev as elDevice.Tv;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.ventilationFan:
      elDevice.VentilationFan json = dev as elDevice.VentilationFan;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.vocSensor:
      elDevice.VocSensor json = dev as elDevice.VocSensor;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.washerDryer:
      elDevice.WasherDryer json = dev as elDevice.WasherDryer;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.waterFlowMeter:
      elDevice.WaterFlowMeter json = dev as elDevice.WaterFlowMeter;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.wattHourMeter:
      elDevice.WattHourMeter json = dev as elDevice.WattHourMeter;
              newjson = json.toJson();
      break;
    case elDevice.DeviceType.notYetSupported:
      return const Text('Not Suppported Device');
  }
      newjson.removeWhere((key, value) => 
                                          key=="deviceId"||
                                          key=="operationStatus"||
                                          key=="installationLocation"||
                                          key=="faultStatus"||
                                          key=="faultDescription"||
                                          key=="manufacturer"||
                                          key=="manufacturerFaultCode"||
                                          key=="businessFacilityCode"||
                                          key=="productCode"||
                                          key=="productionDate"                                          
                                          );
      newjson.removeWhere((key, value) => value==null|| value =="null");
      return JsonViewer(newjson);
}
