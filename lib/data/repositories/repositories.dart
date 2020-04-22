import 'package:my_ministry/data/dto/dto.dart';
import 'package:my_ministry/data/repositories/database/hivedb_repository.dart';

import 'initial_data.dart';

class Repositories {
  final IDbRepository dbRepository;
  InitialData _initialData;

  Repositories() : dbRepository = HiveDbRepository() {
    _initialData = InitialData(dbRepository);
  }

  Future<void> initData() async {
    await dbRepository.initDb();
    var info = await dbRepository.getDbInfo();
    if (info == null) {
      await dbRepository.saveDbInfo(DbInfo()..version = '1.0.0');
      await _initialData.init();
    }
  }
}

abstract class IDbRepository {
  Future<void> initDb();
  bool isInited();
  Future<DbInfo> getDbInfo();
  Future<void> saveDbInfo(DbInfo info);
  Stream<List<People>> getPeoples();
  Future<void> deletePeople(int userKey);
  Stream<List<PeopleType>> getPeopleTypes();
  Future<int> addPeopleType(PeopleType peopleType);
  Stream<List<PhoneType>> getPhoneTypes();
  Future<int> addPhoneType(PhoneType phoneType);
  Stream<List<AddressType>> getAddressTypes();
  Future<int> addAddressType(AddressType addressType);
}
