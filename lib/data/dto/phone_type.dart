import 'package:hive/hive.dart';
import 'package:my_ministry/data/repositories/dadabase/hive_const.dart';

part 'phone_type.g.dart';

@HiveType(typeId: phoneTypeTypeId)
class PhoneType extends HiveObject {
  @HiveField(0)
  String name;
}
