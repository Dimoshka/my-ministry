import 'package:hive/hive.dart';
import 'package:my_ministry/data/repositories/database/hive_const.dart';

import 'address.dart';
import 'phone.dart';
import 'people_type.dart';

part 'people.g.dart';

@HiveType(typeId: peopleTypeId)
class People extends HiveObject {
  People(this.name, this.peopleType, {this.birthday, this.phones, this.addresses});

  @HiveField(0)
  String name;

  @HiveField(1)
  PeopleType peopleType;

  @HiveField(2)
  DateTime birthday;

  @HiveField(3)
  HiveList<Phone> phones;

  @HiveField(4)
  HiveList<Address> addresses;
}
