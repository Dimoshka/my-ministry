import 'package:hive/hive.dart';
import 'package:my_ministry/data/repositories/dadabase/hive_const.dart';

part 'user_type.g.dart';

@HiveType(typeId: userTypeTypeId)
class UserType extends HiveObject {
  @HiveField(0)
  String name;
}
