import 'package:my_ministry/data/dto/dto.dart' as hive;

class PhoneType {
  PhoneType.fromHive(hive.PhoneType phoneTypeHive) {
    id = phoneTypeHive.key as int;
    name = phoneTypeHive.name;
  }

  int id;
  String name;
}
