import 'package:my_ministry/data/repositories/repositories.dart';
import 'package:my_ministry/domain/entities/entities.dart';

class DbProvider {
  final Repositories _repos;

  IDbRepository _db;

  DbProvider() : _repos = Repositories() {
    _db = _repos.dbRepository;
  }

  Future<void> initData() async {
    await _repos.initData();
  }

  Stream<List<People>> getPeoples() {
    return _db.getPeoples().map((peoples) {
      var newUsers = <People>[];
      peoples.forEach((people) {
        newUsers.add(People.fromHive(people));
      });
      return newUsers;
    }).asBroadcastStream();
  }

    Future<void> savePeople(People people) async {
    if (people == null && people.id == null) {
      return Future.error('Wrong people data!');
    } else {
      return _db.deletePeople(people.id);
    }
  }

  Future<void> deletePeople(People people) async {
    if (people == null && people.id == null) {
      return Future.error('Wrong people data!');
    } else {
      return _db.deletePeople(people.id);
    }
  }

  Stream<List<PeopleType>> getPeopleTypes() {
    return _db.getPeopleTypes().map((types) {
      var newTypes = <PeopleType>[];
      types.forEach((type) {
        newTypes.add(PeopleType.fromHive(type));
      });
      return newTypes;
    }).asBroadcastStream();
  }

  Stream<List<PhoneType>> getPhoneTypes() {
    return _db.getPhoneTypes().map((types) {
      var newTypes = <PhoneType>[];
      types.forEach((type) {
        newTypes.add(PhoneType.fromHive(type));
      });
      return newTypes;
    }).asBroadcastStream();
  }

  Stream<List<AddressType>> getAddressTypes() {
    return _db.getAddressTypes().map((types) {
      var newTypes = <AddressType>[];
      types.forEach((type) {
        newTypes.add(AddressType.fromHive(type));
      });
      return newTypes;
    }).asBroadcastStream();
  }
}
