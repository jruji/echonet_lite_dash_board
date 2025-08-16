import '../edit.dart';
import 'package:el_webapi_api/src/models/models.dart';
import '/config.dart';

class DeviceListRepository {
  ElWebApiClient _provider = ElWebApiClient(url: serverUrl, header: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $accessToken',
  });
  Future<EchonetLiteDevice> fetchDeviceList(Profile profile) async {
    return _provider.fetchRegisteredDevicesResources(profile);
  }
  Future<List<EchonetLiteDevice>> updateList(RegisteredDeviceList list){
    return _provider.fetchAllRegisteredDevicesResources(list);
  } 

  
}
