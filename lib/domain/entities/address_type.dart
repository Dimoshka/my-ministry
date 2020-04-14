import 'package:my_ministry/data/dto/dto.dart' as hive;

class AddressType {
  AddressType.fromHive(hive.AddressType addressTypeHive) {
    id = addressTypeHive.key as int;
    name = addressTypeHive.name;
  }

  int id;
  String name;
}
