import 'package:hive/hive.dart';
import 'package:my_ministry/data/repositories/dadabase/hive_const.dart';

import 'phone_type.dart';

part 'phone.g.dart';

@HiveType(typeId: phoneTypeId)
class Phone extends HiveObject {
  Phone(this.number, this.phoneType, {this.note});

  @HiveField(0)
  String number;

  @HiveField(1)
  PhoneType phoneType;

  @HiveField(2)
  String note;
}
