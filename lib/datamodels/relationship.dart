import 'package:hive/hive.dart';

part 'relationship.g.dart';

@HiveType(typeId: 1)
class Relationship extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String relation;

  Relationship({required this.name, required this.relation});
}
