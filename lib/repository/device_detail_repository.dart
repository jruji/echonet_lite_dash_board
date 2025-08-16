import '../edit.dart';
import 'package:el_webapi_api/src/models/models.dart';
import '/config.dart';


class DeviceDetailRepository {
  DeviceDetailRepository({required this.deviceId, required this.deviceType});
  final String deviceId;
  final DeviceType deviceType;
  ElWebApiClient _provider = ElWebApiClient(url: serverUrl, header: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $accessToken',
  });
  Future<EchonetLiteDevice?> fetchDeviceInformation() async{
    return await _provider.getDeviceResources(deviceType, deviceId) ;
  }

  Future<bool> updateDevice(String property, dynamic value) {
    return _provider.setPropertyNameWithValue(deviceId, property, value);
  }

  Future<void> turnON() {
    print("turn on"); 
    return _provider.setOperationStatus(deviceId, true);
  }

  Future<void> turnOFF() {
    print("turn off");
    return _provider.setOperationStatus(deviceId, false);
  }
}
