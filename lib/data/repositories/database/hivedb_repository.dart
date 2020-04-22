import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_ministry/data/dto/dto.dart';
import 'package:my_ministry/data/repositories/database/hive_const.dart';
import 'package:my_ministry/data/repositories/repositories.dart';

class HiveDbRepository extends IDbRepository {
  bool _isIneted = false;

  @override
  Future<void> initDb() async {
    await Hive.initFlutter();
    Hive.registerAdapter(DbInfoAdapter());
    Hive.registerAdapter(PeopleAdapter());
    Hive.registerAdapter(PeopleTypeAdapter());
    Hive.registerAdapter(PhoneAdapter());
    Hive.registerAdapter(PhoneTypeAdapter());
    Hive.registerAdapter(AddressAdapter());
    Hive.registerAdapter(AddressTypeAdapter());
    _isIneted = true;
  }

  @override
  bool isInited() {
    return _isIneted;
  }

  Future<Box<T>> _openBox<T extends HiveObject>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Future<Box<T>>.value(Hive.box<T>(boxName));
    } else {
      return Hive.openBox<T>(boxName);
    }
  }

  Future<T> _getObject<T extends HiveObject>(String boxName, int key,
      {T defaultValue}) async {
    if (!_isIneted) {
      await initDb();
    }
    var box = await _openBox<T>(boxName);
    return Future.value(box.get(key, defaultValue: defaultValue));
  }

  Stream<List<T>> _getObjects<T extends HiveObject>(String boxName) async* {
    if (!_isIneted) {
      await initDb();
    }
    var box = await _openBox<T>(boxName);
    var objects = box.values.toList();
    yield objects;
    var listenable = box.listenable();
    listenable.addListener(() async* {
      yield box.values.toList();
    });
  }

  Future<int> _addObject<T extends HiveObject>(String boxName, T object) async {
    if (!_isIneted) {
      await initDb();
    }
    var box = await _openBox<T>(boxName);
    return box.add(object);
  }

  Future<void> _putObject<T extends HiveObject>(
      String boxName, int key, T object) async {
    if (!_isIneted) {
      await initDb();
    }
    var box = await _openBox<T>(boxName);
    return box.put(key, object);
  }

  Future<void> _deleteObject<T extends HiveObject>(
      String boxName, int key) async {
    if (!_isIneted) {
      await initDb();
    }
    var box = await _openBox<T>(boxName);
    return box.delete(key);
  }

  @override
  Future<DbInfo> getDbInfo() {
    return _getObject<DbInfo>(dbInfoBoxName, 0);
  }

  @override
  Future<void> saveDbInfo(DbInfo info) {
    return _putObject<DbInfo>(dbInfoBoxName, 0, info);
  }

  @override
  Stream<List<People>> getPeoples() {
    return _getObjects<People>(peoplesBoxName).asBroadcastStream();
  }

  @override
  Future<void> deletePeople(int userKey) {
    return _deleteObject<People>(peoplesBoxName, userKey);
  }

  @override
  Stream<List<AddressType>> getAddressTypes() {
    return _getObjects<AddressType>(addressTypesBoxName).asBroadcastStream();
  }

  @override
  Stream<List<PhoneType>> getPhoneTypes() {
    return _getObjects<PhoneType>(phoneTypesBoxName).asBroadcastStream();
  }

  @override
  Stream<List<PeopleType>> getPeopleTypes() {
    return _getObjects<PeopleType>(peopleTypesBoxName).asBroadcastStream();
  }

  @override
  Future<int> addPeopleType(PeopleType peopleType) {
    return _addObject<PeopleType>(peopleTypesBoxName, peopleType);
  }

  @override
  Future<int> addAddressType(AddressType addressType) {
    return _addObject<AddressType>(addressTypesBoxName, addressType);
  }

  @override
  Future<int> addPhoneType(PhoneType phoneType) {
    return _addObject<PhoneType>(phoneTypesBoxName, phoneType);
  }
}
