import 'package:hive/hive.dart';
import 'package:my_ministry/data/repositories/database/hive_const.dart';

import 'address_type.dart';

part 'address.g.dart';

@HiveType(typeId: addressTypeId)
class Address extends HiveObject {

  Address(this.location, this.addressType, {this.note});

  @HiveField(0)
  String location;

  @HiveField(1)
  AddressType addressType;

  @HiveField(2)
  String note;
}
