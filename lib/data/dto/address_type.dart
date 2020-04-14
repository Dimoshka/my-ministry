import 'package:hive/hive.dart';
import 'package:my_ministry/data/repositories/dadabase/hive_const.dart';

part 'address_type.g.dart';

@HiveType(typeId: addressTypeTypeId)
class AddressType extends HiveObject {
  @HiveField(0)
  String name;
}
