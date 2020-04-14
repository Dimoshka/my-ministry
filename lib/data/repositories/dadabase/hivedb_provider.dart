import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_ministry/data/dto/dto.dart';
import 'package:my_ministry/data/repositories/dadabase/db_repository.dart';

class HiveDbProvider extends DbRepository {
  HiveDbProvider() {
    _initDb();
  }

  void _initDb() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(UserTypeAdapter());
    Hive.registerAdapter(PhoneAdapter());
    Hive.registerAdapter(PhoneTypeAdapter());
    Hive.registerAdapter(AddressAdapter());
    Hive.registerAdapter(AddressTypeAdapter());
  }

  Future<Box<T>> _openBox<T>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Future.value(Hive.box(boxName));
    } else {
      return await Hive.openBox(boxName);
    }
  }
}
