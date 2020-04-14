import 'package:async/src/stream_zip.dart';
import 'package:my_ministry/domain/entities/entities.dart';
import 'package:my_ministry/domain/entities/user.dart';
import 'package:my_ministry/domain/entities/user_type.dart';
import 'package:my_ministry/domain/providers/providers.dart';
import 'package:my_ministry/domain/usecases/usecases.dart';

class UserUsecase extends IUserUsecases {
  final DbProvider _dbProvider;

  UserUsecase(this._dbProvider);

  @override
  Stream<List<User>> getUsers() {
    return _dbProvider.getUsers().map((users) {
      users.sort((user1, user2) {
        return user1.name.compareTo(user2.name);
      });
      return users;
    });
  }

  @override
  Future<void> deleteUser(User user) {
    return _dbProvider.deleteUser(user);
  }

  @override
  Stream<List<AddressType>> getAddressTypes() {
    return _dbProvider.getAddressTypes();
  }

  @override
  Stream<List<PhoneType>> getPhoneTypes() {
    return _dbProvider.getPhoneTypes();
  }

  @override
  Stream<List<UserType>> getUserTypes() {
    return _dbProvider.getUserTypes();
  }

  @override
  StreamZip<List<dynamic>> getTypes() {
    return StreamZip([getUserTypes(), getPhoneTypes(), getAddressTypes()]);
  }
}
