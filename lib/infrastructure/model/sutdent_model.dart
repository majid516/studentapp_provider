import 'package:hive_flutter/hive_flutter.dart';
 part 'sutdent_model.g.dart';
@HiveType(typeId: 0)
class StudentModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String age;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final String guardian;
  @HiveField(5)
  final String image;

  StudentModel(
      {
      this.id,
      required this.name,
      required this.age,
      required this.phone,
      required this.guardian,
      required this.image
      });
}
