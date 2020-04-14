import 'package:hive/hive.dart';
import 'package:my_ministry/data/repositories/database/hive_const.dart';

import 'address.dart';
import 'phone.dart';
import 'user_type.dart';

part 'user.g.dart';

@HiveType(typeId: userTypeId)
class User extends HiveObject {
  User(this.name, this.userType, {this.birthday, this.phones, this.addresses});

  @HiveField(0)
  String name;

  @HiveField(1)
  UserType userType;

  @HiveField(2)
  DateTime birthday;

  @HiveField(3)
  HiveList<Phone> phones;

  @HiveField(4)
  HiveList<Address> addresses;
}
