import 'package:my_ministry/data/repositories/repositories.dart';
import 'package:my_ministry/domain/entities/entities.dart';

class DbProvider {
  final Repositories _repos;

  IDbRepository _db;

  DbProvider() : _repos = Repositories() {
    _db = _repos.dbRepository;
  }

  Future<void> initData() {
    return _repos.initData();
  }

  Stream<List<User>> getUsers() {
    return _db.getUsers().map((users) {
      var newUsers = <User>[];
      users.forEach((user) {
        newUsers.add(User.fromHive(user));
      });
      return newUsers;
    }).asBroadcastStream();
  }

  Future<void> deleteUser(User user) async {
    if (user == null && user.id == null) {
      return Future.error('Wrong user data!');
    } else {
      return _db.deleteUser(user.id);
    }
  }

  Stream<List<UserType>> getUserTypes() {
    return _db.getUserTypes().map((types) {
      var newTypes = <UserType>[];
      types.forEach((type) {
        newTypes.add(UserType.fromHive(type));
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
