// ignore_for_file: lines_longer_than_80_chars, avoid_print
import 'package:echonet_lite_dashboard/config.dart';
import 'package:el_webapi_api/el_webapi_api.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class ElWebApiClient {
  @override
  ElWebApiClient({required String url, http.Client? client, Object? header})
      : _baseUrl = url.contains(CommonUri.root) ? url : url + CommonUri.root,
        _httpClient = client ?? http.Client(),
        _header = header ??
            {'Content-Type': 'application/json', 'Accept': 'application/json'};
  final String _baseUrl;
  final http.Client _httpClient;
  // ignore: prefer_typing_uninitialized_variables
  final _header;
  Future<List<EchonetLiteDevice>> getDeviceResourcesByType(
      DeviceType type, RegisteredDeviceList? registeredDeviceList) async {
    registeredDeviceList = registeredDeviceList ?? await getRegisteredDevices();
    final List<EchonetLiteDevice> devices = [];
    for (final profile in registeredDeviceList.profiles) {
      if (profile.deviceType == type) {
        switch (type) {
          case DeviceType.airCleaner:
            final dev = await getGeneralLighting(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.airConditionerVentilationFan:
            final dev = await getAirConditionerVentilationFan(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.bathHeatingStatusSensor:
            final dev = await getBathHeatingStatusSensor(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.bathroomHeaterDryer:
            final dev = await getBathroomHeaterDryer(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.co2Sensor:
            final dev = await getCo2Sensor(profile.id);
            if (dev != null) {
              devices.add(dev);
            }

            break;
          case DeviceType.coldOrHotWaterHeatSourceEquipment:
            final dev = await getColdOrHotWaterHeatSourceEquipment(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.commercialAirConditionerIndoorUnit:
            final dev = await getCommercialAirConditionerIndoorUnit(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.commercialAirConditionerOutdoorUnit:
            final dev =
                await getCommercialAirConditionerOutdoorUnit(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.commercialShowcase:
            final dev = await getCommercialShowcase(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.commercialShowcaseOutdoorUnit:
            final dev = await getCommercialShowcaseOutdoorUnit(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.controller:
            final dev = await getController(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.cookingHeater:
            final dev = await getCookingHeater(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.currentSensor:
            final dev = await getCurrentSensor(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.electricEnergySensor:
            final dev = await getElectricEnergySensor(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.electricLock:
            final dev = await getElectricLock(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.electricRainDoor:
            final dev = await getElectricRainDoor(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.electricWaterHeater:
            final dev = await getElectricWaterHeater(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.emergencyButton:
            final dev = await getEmergencyButton(profile.id);
            if (dev != null) {
              devices.add(dev);
            }

            break;
          case DeviceType.enhancedLightingSystem:
            final dev = await getEnhancedLightingSystem(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.evCharger:
            final dev = await getEvCharger(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;

          case DeviceType.evChargerDischarger:
            final dev = await getEvChargerDischarger(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.floorHeater:
            final dev = await getFloorHeater(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.fuelCell:
            final dev = await getFuelCell(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.gasMeter:
            final dev = await getGasMeter(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.generalLighting:
            final GeneralLighting? light = await getGeneralLighting(profile.id);
            if (light != null) {
              devices.add(light);
            }
            break;
          case DeviceType.homeAirConditioner:
            final dev = await getHomeAirConditioner(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.humanDetectionSensor:
            final dev = await getHumanDetectionSensor(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.humiditySensor:
            final dev = await getHumiditySensor(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.hvSmartElectricEnergyMeter:
            final dev = await getHvSmartElectricEnergyMeter(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.hybridWaterHeater:
            final dev = await getHybridWaterHeater(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.illuminanceSensor:
            final dev = await getIlluminanceSensor(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.instantaneousWaterHeater:
            final dev = await getInstantaneousWaterHeater(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.lightingSystem:
            final dev = await getLightingSystem(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.lvSmartElectricEnergyMeter:
            final dev = await getLvSmartElectricEnergyMeter(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.monoFunctionalLighting:
            final dev = await getMonoFunctionalLighting(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.powerDistributionBoardMetering:
            final dev = await getPowerDistributionBoardMetering(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.pvPowerGeneration:
            final dev = await getPvPowerGeneration(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.refrigerator:
            final dev = await getRefrigerator(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.riceCooker:
            final dev = await getRiceCooker(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.smartElectricEnergySubMeter:
            final dev = await getSmartElectricEnergySubMeter(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.storageBattery:
            final dev = await getStorageBattery(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.electricSwitch:
            final dev = await getSwitch(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.temperatureSensor:
            print(profile.id);
            final dev = await getTemperatureSensor(profile.id);
            if (dev != null) {
              devices.add(dev);
            }

            break;
          case DeviceType.tv:
            final dev = await getTv(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.ventilationFan:
            final dev = await getVentilationFan(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.vocSensor:
            final dev = await getVocSensor(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;

          case DeviceType.washerDryer:
            final dev = await getWasherDryer(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.waterFlowMeter:
            final dev = await getWaterFlowMeter(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.wattHourMeter:
            final dev = await getWattHourMeter(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.electricCurtain:
            final dev = await getElectricCurtain(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.electricWindow:
            final dev = await getElectricWindow(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.electricShade:
            final dev = await getElectricShade(profile.id);
            if (dev != null) {
              devices.add(dev);
            }
            break;
          case DeviceType.notYetSupported:
            break;
        }
      }
    }
    return devices;
  }

  // ignore: body_might_complete_normally_nullable
  Future<Future<EchonetLiteDevice?>> getDeviceResources(
      DeviceType deviceType, String id) async {
    switch (deviceType) {
      case DeviceType.airCleaner:
        return getAirCleaner(id);
      case DeviceType.electricCurtain:
        return getElectricCurtain(id);
      case DeviceType.electricWindow:
        return getElectricWindow(id);
      case DeviceType.electricShade:
        return getElectricShade(id);
      case DeviceType.airConditionerVentilationFan:
        return getAirConditionerVentilationFan(id);
      case DeviceType.bathHeatingStatusSensor:
        return getBathHeatingStatusSensor(id);
      case DeviceType.bathroomHeaterDryer:
        return getBathroomHeaterDryer(id);
      case DeviceType.co2Sensor:
        return getCo2Sensor(id);
      case DeviceType.coldOrHotWaterHeatSourceEquipment:
        return getColdOrHotWaterHeatSourceEquipment(id);
      case DeviceType.commercialAirConditionerIndoorUnit:
        return getCommercialAirConditionerIndoorUnit(id);
      case DeviceType.commercialAirConditionerOutdoorUnit:
        return getCommercialAirConditionerOutdoorUnit(id);
      case DeviceType.commercialShowcase:
        return getCommercialShowcase(id);
      case DeviceType.commercialShowcaseOutdoorUnit:
        return getCommercialShowcaseOutdoorUnit(id);
      case DeviceType.controller:
        return getController(id);
      case DeviceType.cookingHeater:
        return getCookingHeater(id);
      case DeviceType.currentSensor:
        return getCurrentSensor(id);
      case DeviceType.electricEnergySensor:
        return getElectricEnergySensor(id);
      case DeviceType.electricLock:
        return getElectricLock(id);
      case DeviceType.electricRainDoor:
        return getElectricRainDoor(id);
      case DeviceType.electricWaterHeater:
        return getElectricWaterHeater(id);
      case DeviceType.emergencyButton:
        return getEmergencyButton(id);
      case DeviceType.enhancedLightingSystem:
        return getEnhancedLightingSystem(id);
      case DeviceType.evCharger:
        return getEvCharger(id);
      case DeviceType.evChargerDischarger:
        return getEvChargerDischarger(id);
      case DeviceType.floorHeater:
        return getFloorHeater(id);
      case DeviceType.fuelCell:
        return getFuelCell(id);
      case DeviceType.gasMeter:
        return getGasMeter(id);
      case DeviceType.generalLighting:
        return getGeneralLighting(id);
      case DeviceType.homeAirConditioner:
        return getHomeAirConditioner(id);
      case DeviceType.humanDetectionSensor:
        return getHumanDetectionSensor(id);
      case DeviceType.humiditySensor:
        return getHumiditySensor(id);
      case DeviceType.hvSmartElectricEnergyMeter:
        return getHvSmartElectricEnergyMeter(id);
      case DeviceType.hybridWaterHeater:
        return getHybridWaterHeater(id);
      case DeviceType.illuminanceSensor:
        return getIlluminanceSensor(id);
      case DeviceType.instantaneousWaterHeater:
        return getInstantaneousWaterHeater(id);
      case DeviceType.lightingSystem:
        return getLightingSystem(id);
      case DeviceType.lvSmartElectricEnergyMeter:
        return getLvSmartElectricEnergyMeter(id);
      case DeviceType.monoFunctionalLighting:
        return getMonoFunctionalLighting(id);
      case DeviceType.powerDistributionBoardMetering:
        return getPowerDistributionBoardMetering(id);
      case DeviceType.pvPowerGeneration:
        return getPvPowerGeneration(id);
      case DeviceType.refrigerator:
        return getRefrigerator(id);
      case DeviceType.riceCooker:
        return getRiceCooker(id);
      case DeviceType.smartElectricEnergySubMeter:
        return getSmartElectricEnergySubMeter(id);
      case DeviceType.storageBattery:
        return getStorageBattery(id);
      case DeviceType.electricSwitch:
        return getSwitch(id);
      case DeviceType.temperatureSensor:
        return getTemperatureSensor(id);
      case DeviceType.tv:
        return getTv(id);
      case DeviceType.ventilationFan:
        return getVentilationFan(id);
      case DeviceType.vocSensor:
        return getVocSensor(id);
      case DeviceType.washerDryer:
        return getWasherDryer(id);
      case DeviceType.waterFlowMeter:
        return getWaterFlowMeter(id);
      case DeviceType.wattHourMeter:
        return getWattHourMeter(id);
      case DeviceType.notYetSupported:
        break;
    }
    dynamic device;
    return device;
  }

  /// Get all registered devices
  ///
  /// HTTP GET : xxx/v1/devices/
  /// Return: Json string "device:[{list of device}], hasMore: {bool},
  /// limit: {number}, offset: {number}"
  Future<RegisteredDeviceList> getRegisteredDevices() async {
    final request = Uri.parse('$_baseUrl${CommonUri.devices}');
    final response = await _httpClient.get(request, headers: _header);
        print('Status code: ${response.statusCode}');
print('Response body: ${response.body}');
    if (response.statusCode != 200) {
      throw WebAPIServerRequestFail();
    }
 

    return RegisteredDeviceList.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  ///Get all registered devices with detailed information directly
  ///from an abstracted list of registered devices
  Future<EchonetLiteDevice> fetchRegisteredDevicesResources(
      Profile profile) async {
        EchonetLiteDevice device;
      print(profile.id);
      switch (profile.deviceType) {
        case DeviceType.airCleaner:
           device = (await getAirCleaner(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.electricCurtain:
           device = (await getElectricCurtain(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.electricWindow:
           device = (await getElectricWindow(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.electricShade:
           device = (await getElectricShade(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.airConditionerVentilationFan:
           device = (await getAirConditionerVentilationFan(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.bathHeatingStatusSensor:
           device = (await getBathHeatingStatusSensor(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.bathroomHeaterDryer:
           device = (await getBathroomHeaterDryer(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.co2Sensor:
           device = (await getCo2Sensor(profile.id)) as EchonetLiteDevice;

        case DeviceType.coldOrHotWaterHeatSourceEquipment:
           device = (await getColdOrHotWaterHeatSourceEquipment(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.commercialAirConditionerIndoorUnit:
           device =
              (await getCommercialAirConditionerIndoorUnit(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.commercialAirConditionerOutdoorUnit:
           device =
              (await getCommercialAirConditionerOutdoorUnit(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.commercialShowcase:
           device = (await getCommercialShowcase(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.commercialShowcaseOutdoorUnit:
           device = (await getCommercialShowcaseOutdoorUnit(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.controller:
           device = (await getController(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.cookingHeater:
           device = (await getCookingHeater(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.currentSensor:
           device = (await getCurrentSensor(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.electricEnergySensor:
           device = (await getElectricEnergySensor(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.electricLock:
           device = (await getElectricLock(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.electricRainDoor:
           device = (await getElectricRainDoor(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.electricWaterHeater:
           device = (await getElectricWaterHeater(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.emergencyButton:
           device = (await getEmergencyButton(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.enhancedLightingSystem:
           device = (await getEnhancedLightingSystem(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.evCharger:
           device = (await getEvCharger(profile.id)) as EchonetLiteDevice;
           

        case DeviceType.evChargerDischarger:
           device = (await getEvChargerDischarger(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.floorHeater:
           device = (await getFloorHeater(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.fuelCell:
           device = (await getFuelCell(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.gasMeter:
           device = (await getGasMeter(profile.id)) as EchonetLiteDevice;
           

        case DeviceType.generalLighting:
           device = (await getGeneralLighting(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.homeAirConditioner:
           device = (await getHomeAirConditioner(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.humanDetectionSensor:
           device = (await getHumanDetectionSensor(profile.id)) as EchonetLiteDevice;

        case DeviceType.humiditySensor:
           device = (await getHumiditySensor(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.hvSmartElectricEnergyMeter:
           device = (await getHvSmartElectricEnergyMeter(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.hybridWaterHeater:
           device = (await getHybridWaterHeater(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.illuminanceSensor:
           device = (await getIlluminanceSensor(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.instantaneousWaterHeater:
           device = (await getInstantaneousWaterHeater(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.lightingSystem:
           device = (await getLightingSystem(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.lvSmartElectricEnergyMeter:
           device = (await getLvSmartElectricEnergyMeter(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.monoFunctionalLighting:
           device = (await getMonoFunctionalLighting(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.powerDistributionBoardMetering:
           device = (await getPowerDistributionBoardMetering(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.pvPowerGeneration:
           device = (await getPvPowerGeneration(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.refrigerator:
           device = (await getRefrigerator(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.riceCooker:
           device = (await getHomeAirConditioner(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.smartElectricEnergySubMeter:
           device = (await getSmartElectricEnergySubMeter(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.storageBattery:
           device = (await getStorageBattery(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.electricSwitch:
           device = (await getSwitch(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.temperatureSensor:
           device = (await getTemperatureSensor(profile.id)) as EchonetLiteDevice;

        case DeviceType.tv:
           device = (await getTv(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.ventilationFan:
           device = (await getVentilationFan(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.vocSensor:
           device = (await getVocSensor(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.washerDryer:
           device = (await getWasherDryer(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.waterFlowMeter:
           device = (await getWaterFlowMeter(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.wattHourMeter:
           device = (await getWattHourMeter(profile.id)) as EchonetLiteDevice;
           
        case DeviceType.notYetSupported:
          device = (await getNotSupported()) as EchonetLiteDevice;
          break;
      }
      return device;
    }


  
  ///Get all registered devices with detailed information directly
  ///from an abstracted list of registered devices
  Future<List<EchonetLiteDevice>> fetchAllRegisteredDevicesResources(
      RegisteredDeviceList? registeredDeviceList) async {
    registeredDeviceList = registeredDeviceList ?? await getRegisteredDevices();
    final List<EchonetLiteDevice> devices = [];
    for (final profile in registeredDeviceList.profiles) {
      print(profile.id);
      switch (profile.deviceType) {
        case DeviceType.airCleaner:
          final device = await getAirCleaner(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.electricCurtain:
          final device = await getElectricCurtain(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.electricWindow:
          final device = await getElectricWindow(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.electricShade:
          final device = await getElectricShade(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.airConditionerVentilationFan:
          final device = await getAirConditionerVentilationFan(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.bathHeatingStatusSensor:
          final device = await getBathHeatingStatusSensor(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.bathroomHeaterDryer:
          final device = await getBathroomHeaterDryer(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.co2Sensor:
          final device = await getCo2Sensor(profile.id);
          if (device != null) {
            devices.add(device);
          }

          break;
        case DeviceType.coldOrHotWaterHeatSourceEquipment:
          final device = await getColdOrHotWaterHeatSourceEquipment(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.commercialAirConditionerIndoorUnit:
          final device =
              await getCommercialAirConditionerIndoorUnit(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.commercialAirConditionerOutdoorUnit:
          final device =
              await getCommercialAirConditionerOutdoorUnit(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.commercialShowcase:
          final device = await getCommercialShowcase(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.commercialShowcaseOutdoorUnit:
          final device = await getCommercialShowcaseOutdoorUnit(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.controller:
          final device = await getController(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.cookingHeater:
          final device = await getCookingHeater(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.currentSensor:
          final device = await getCurrentSensor(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.electricEnergySensor:
          final device = await getElectricEnergySensor(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.electricLock:
          final device = await getElectricLock(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.electricRainDoor:
          final device = await getElectricRainDoor(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.electricWaterHeater:
          final device = await getElectricWaterHeater(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.emergencyButton:
          final device = await getEmergencyButton(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.enhancedLightingSystem:
          final device = await getEnhancedLightingSystem(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.evCharger:
          final device = await getEvCharger(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;

        case DeviceType.evChargerDischarger:
          final device = await getEvChargerDischarger(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.floorHeater:
          final device = await getFloorHeater(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.fuelCell:
          final device = await getFuelCell(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.gasMeter:
          final device = await getGasMeter(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;

        case DeviceType.generalLighting:
          final device = await getGeneralLighting(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.homeAirConditioner:
          final device = await getHomeAirConditioner(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.humanDetectionSensor:
          final device = await getHumanDetectionSensor(profile.id);
          if (device != null) {
            devices.add(device);
          }

          break;
        case DeviceType.humiditySensor:
          final device = await getHumiditySensor(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.hvSmartElectricEnergyMeter:
          final device = await getHvSmartElectricEnergyMeter(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.hybridWaterHeater:
          final device = await getHybridWaterHeater(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.illuminanceSensor:
          final device = await getIlluminanceSensor(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.instantaneousWaterHeater:
          final device = await getInstantaneousWaterHeater(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.lightingSystem:
          final device = await getLightingSystem(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.lvSmartElectricEnergyMeter:
          final device = await getLvSmartElectricEnergyMeter(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.monoFunctionalLighting:
          final device = await getMonoFunctionalLighting(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.powerDistributionBoardMetering:
          final device = await getPowerDistributionBoardMetering(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.pvPowerGeneration:
          final device = await getPvPowerGeneration(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.refrigerator:
          final device = await getRefrigerator(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.riceCooker:
          final device = await getRiceCooker(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.smartElectricEnergySubMeter:
          final device = await getSmartElectricEnergySubMeter(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.storageBattery:
          final device = await getStorageBattery(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.electricSwitch:
          final device = await getSwitch(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.temperatureSensor:
          print(profile.id);
          final device = await getTemperatureSensor(profile.id);
          if (device != null) {
            devices.add(device);
          }

          break;
        case DeviceType.tv:
          final device = await getTv(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.ventilationFan:
          final device = await getVentilationFan(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.vocSensor:
          final device = await getVocSensor(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.washerDryer:
          final device = await getWasherDryer(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.waterFlowMeter:
          final device = await getWaterFlowMeter(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.wattHourMeter:
          final device = await getWattHourMeter(profile.id);
          if (device != null) {
            devices.add(device);
          }
          break;
        case DeviceType.notYetSupported:
          break;
      }
    }
    return devices;
  }

  
  Future<EchonetLiteDevice> getNotSupported(){
    return new CommonProperty(operationStatus: false, installationLocation: "installationLocation", protocol: Protocol(), faultStatus: true, manufacturer: Manufacturer()) as Future<EchonetLiteDevice>;
  }
  Future<BathHeatingStatusSensor?> getBathHeatingStatusSensor(
      String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = BathHeatingStatusSensor.fromJson(
          responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<Co2Sensor?> getCo2Sensor(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = Co2Sensor.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<CurrentSensor?> getCurrentSensor(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = CurrentSensor.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<ElectricEnergySensor?> getElectricEnergySensor(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device =
          ElectricEnergySensor.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<EmergencyButton?> getEmergencyButton(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = EmergencyButton.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<HumanDetectionSensor?> getHumanDetectionSensor(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device =
          HumanDetectionSensor.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<HumiditySensor?> getHumiditySensor(String deviceId) async {
    dynamic dev;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        dev = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      dev = HumiditySensor.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      dev = null;
    }
    return dev;
  }

  Future<IlluminanceSensor?> getIlluminanceSensor(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = IlluminanceSensor.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<TemperatureSensor?> getTemperatureSensor(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      
      device = TemperatureSensor.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<ElectricCurtain?> getElectricCurtain(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = ElectricCurtain.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<ElectricWindow?> getElectricWindow(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = ElectricWindow.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<ElectricShade?> getElectricShade(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = ElectricShade.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<VocSensor?> getVocSensor(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = VocSensor.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<AirCleaner?> getAirCleaner(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = AirCleaner.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<AirConditionerVentilationFan?> getAirConditionerVentilationFan(
      String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = AirConditionerVentilationFan.fromJson(
          responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<CommercialAirConditionerIndoorUnit?>
      getCommercialAirConditionerIndoorUnit(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = CommercialAirConditionerIndoorUnit.fromJson(
          responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<CommercialAirConditionerOutdoorUnit?>
      getCommercialAirConditionerOutdoorUnit(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = CommercialAirConditionerOutdoorUnit.fromJson(
          responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<VentilationFan?> getVentilationFan(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = VentilationFan.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<BathroomHeaterDryer?> getBathroomHeaterDryer(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device =
          BathroomHeaterDryer.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<ColdOrHotWaterHeatSourceEquipment?>
      getColdOrHotWaterHeatSourceEquipment(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = ColdOrHotWaterHeatSourceEquipment.fromJson(
          responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<ElectricLock?> getElectricLock(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = ElectricLock.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<ElectricRainDoor?> getElectricRainDoor(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = ElectricRainDoor.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<ElectricWaterHeater?> getElectricWaterHeater(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device =
          ElectricWaterHeater.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<EnhancedLightingSystem?> getEnhancedLightingSystem(
      String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device =
          EnhancedLightingSystem.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<EvChargerDischarger?> getEvChargerDischarger(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device =
          EvChargerDischarger.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<EvCharger?> getEvCharger(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = EvCharger.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<FloorHeater?> getFloorHeater(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = FloorHeater.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<FuelCell?> getFuelCell(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = FuelCell.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<GasMeter?> getGasMeter(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = GasMeter.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<GeneralLighting?> getGeneralLighting(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = GeneralLighting.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<HomeAirConditioner?> getHomeAirConditioner(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device =
          HomeAirConditioner.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<HvSmartElectricEnergyMeter?> getHvSmartElectricEnergyMeter(
      String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = HvSmartElectricEnergyMeter.fromJson(
          responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<HybridWaterHeater?> getHybridWaterHeater(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = HybridWaterHeater.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<InstantaneousWaterHeater?> getInstantaneousWaterHeater(
      String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = InstantaneousWaterHeater.fromJson(
          responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<LightingSystem?> getLightingSystem(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = LightingSystem.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<LvSmartElectricEnergyMeter?> getLvSmartElectricEnergyMeter(
      String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = LvSmartElectricEnergyMeter.fromJson(
          responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<MonoFunctionalLighting?> getMonoFunctionalLighting(
      String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device =
          MonoFunctionalLighting.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<PowerDistributionBoardMetering?> getPowerDistributionBoardMetering(
      String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = PowerDistributionBoardMetering.fromJson(
          responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<PvPowerGeneration?> getPvPowerGeneration(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = PvPowerGeneration.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<SmartElectricEnergySubMeter?> getSmartElectricEnergySubMeter(
      String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = SmartElectricEnergySubMeter.fromJson(
          responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<StorageBattery?> getStorageBattery(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = StorageBattery.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<WattHourMeter?> getWattHourMeter(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = WattHourMeter.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<WaterFlowMeter?> getWaterFlowMeter(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = WaterFlowMeter.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<CommercialShowcaseOutdoorUnit?> getCommercialShowcaseOutdoorUnit(
      String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = CommercialShowcaseOutdoorUnit.fromJson(
          responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<CommercialShowcase?> getCommercialShowcase(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device =
          CommercialShowcase.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<CookingHeater?> getCookingHeater(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = CookingHeater.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<Refrigerator?> getRefrigerator(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = Refrigerator.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<RiceCooker?> getRiceCooker(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = RiceCooker.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<WasherDryer?> getWasherDryer(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = WasherDryer.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<Switch?> getSwitch(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = Switch.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<Controller?> getController(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = Controller.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<Tv?> getTv(String deviceId) async {
    dynamic device;
    final request = Uri.parse(
        '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}');
    try {
      final response = await _httpClient.get(request, headers: _header);
      if (response.statusCode != 200) {
        device = null;
        throw WebAPIServerRequestFail();
      }
      final responseData = jsonDecode(response.body);
      responseData[Keywords.deviceId] = deviceId;
      device = Tv.fromJson(responseData as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      device = null;
    }
    return device;
  }

  Future<bool> setPropertyNameWithValue(
      String deviceId, String propertyName, var value) async {
    final response = await http.post(
        Uri.parse(
            '$_baseUrl${CommonUri.devices}/$deviceId/${CommonUri.properties}/$propertyName'),
        headers: _header,
        body: jsonEncode({propertyName: value}));
        print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // ignore: avoid_positional_boolean_parameters
  Future<bool> setOperationStatus(String deviceId, bool status) async =>
      setPropertyNameWithValue(deviceId, CommonUri.operationStatus, status);

}