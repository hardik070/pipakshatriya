import 'package:hive/hive.dart';

part 'login_info.g.dart';

@HiveType(typeId: 2)
class LoginInfo extends HiveObject {
  @HiveField(0)
  String token;

  @HiveField(1)
  DateTime loginTime;

  LoginInfo({required this.token, required this.loginTime});
}
