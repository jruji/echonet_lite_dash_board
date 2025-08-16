import '../edit.dart';
import 'package:el_webapi_api/src/models/models.dart';
import '/config.dart';

class DeviceGroupRepository {
  final DeviceType type;
  DeviceGroupRepository({required this.type});
  ElWebApiClient _provider = ElWebApiClient(url: serverUrl, header: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $accessToken',
  });
  Future<List<EchonetLiteDevice>> fetchDeviceGroupInfor()  async{
    return await _provider.getDeviceResourcesByType(this.type, null) ;
  }
}
