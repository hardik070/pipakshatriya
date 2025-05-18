import 'package:hive/hive.dart';
import 'relationship.dart';
import 'login_info.dart';
import 'contact.dart';

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
  String phoneNumber;

  @HiveField(5)
  String gotra;

  @HiveField(6)
  String address;

  @HiveField(7)
  List<Relationship> relationships;

  @HiveField(8)
  LoginInfo loginInfo;

  @HiveField(9)
  List<Contact> contacts;

  UserModel({
    required this.name,
    required this.profilePic,
    required this.fatherName,
    required this.email,
    required this.phoneNumber,
    required this.gotra,
    required this.address,
    required this.relationships,
    required this.loginInfo,
    required this.contacts,
  });
}
