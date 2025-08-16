import 'package:el_webapi_api/src/models/models.dart';

abstract class EchonetLiteDevice {
  DeviceType get deviceType;
  String get deviceId;
  bool get operationStatus;
  String get installationLocation;
  Protocol get protocol;
  String? get id;
  num? get instantaneousElectricPowerConsumption;
  num? get consumedCumulativeElectricEnergy;
  String? get manufacturerFaultCode;
  num? get currentLimit;
  bool get faultStatus;
  String? get faultDescription;
  Manufacturer get manufacturer;
  String? get businessFacilityCode;
  String? get productCode;
  String? get serialNumber;
  DateTime? get productionDate;
  bool? get powerSaving;
  DateTime? get currentDateAndTime;
  num? get powerLimit;
  HourMeter? get hourMeter;

}