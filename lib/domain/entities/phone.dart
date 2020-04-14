import 'package:my_ministry/data/dto/dto.dart' as hive;

import 'entities.dart';

class Phone {
  Phone.empty();

  Phone.fromHive(hive.Phone phoneHive) {
    id = phoneHive.key as int;
    number = phoneHive.number;
    phoneType = PhoneType.fromHive(phoneHive.phoneType);
    note = phoneHive.note;
  }

  int id;
  String number;
  PhoneType phoneType;
  String note;
}
