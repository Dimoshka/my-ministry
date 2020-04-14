import 'package:my_ministry/data/dto/dto.dart' as hive;

import 'entities.dart';

class Address {
  Address.empty();

  Address.fromHive(hive.Address addressHive) {
    id = addressHive.key as int;
    location = addressHive.location;
    addressType = AddressType.fromHive(addressHive.addressType);
    note = addressHive.note;
  }

  int id;
  String location;
  AddressType addressType;
  String note;
}
