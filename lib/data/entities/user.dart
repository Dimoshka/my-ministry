import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0, adapterName: "user")
class User extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;
}

@HiveType(typeId: 1, adapterName: "user_type")
enum UserType {
  @HiveField(0)
  brown,

  @HiveField(1)
  blond,

  @HiveField(2)
  black,
}
