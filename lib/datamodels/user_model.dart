import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String profilePic;

  @HiveField(2)
  String fatherName;

  @HiveField(3)
  String email;

  @HiveField(4)
  List<String> phoneNumber;

  @HiveField(5)
  String gotra;

  @HiveField(6)
  String actualAddress;

  @HiveField(7)
  List<Map<String, String>> relationships;

  @HiveField(8)
  String currentAddress;

  @HiveField(9)
  String userId;

  @HiveField(10)
  String subDocId;

  UserModel({
    required this.name,
    required this.profilePic,
    required this.fatherName,
    required this.email,
    required this.phoneNumber,
    required this.gotra,
    required this.actualAddress,
    required this.relationships,
    required this.currentAddress,
    required this.userId,
    required this.subDocId
  });
}
