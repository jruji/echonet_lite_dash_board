import '../edit.dart';
import 'package:el_webapi_api/src/models/models.dart';
import '/config.dart';
class ProfileListRepository {
  ElWebApiClient _provider = ElWebApiClient(url: serverUrl, header: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $accessToken',
  });
  Future<List<EchonetLiteDevice>> fetchDeviceList() async {
    return await _provider.fetchAllRegisteredDevicesResources(null);
  }
}
