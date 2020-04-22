import 'package:hive/hive.dart';
import 'package:my_ministry/data/repositories/database/hive_const.dart';

part 'people_type.g.dart';

@HiveType(typeId: peopleTypeTypeId)
class PeopleType extends HiveObject {
  @HiveField(0)
  String name;
}
