import 'package:hive/hive.dart';
import 'package:my_ministry/data/repositories/database/hive_const.dart';

part 'db_info.g.dart';

@HiveType(typeId: dbInfoTypeId)
class DbInfo extends HiveObject {
  @HiveField(0)
  String version;
}
