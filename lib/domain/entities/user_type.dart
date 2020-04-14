import 'package:my_ministry/data/dto/dto.dart' as hive;

class UserType {
  UserType.fromHive(hive.UserType userTypeHive) {
    id = userTypeHive.key as int;
    name = userTypeHive.name;
  }

  int id;
  String name;
}
