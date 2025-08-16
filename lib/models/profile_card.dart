import 'package:el_webapi_api/el_webapi_api.dart';

class ProfileCard {
  ProfileCard({required this.type, required this.elementCount, required this.errorCount});
  final DeviceType type;
  final int elementCount;
  final int errorCount;
}
