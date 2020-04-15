export 'users/users_usecase.dart';
import 'package:async/async.dart';
import 'package:my_ministry/domain/entities/entities.dart';
import 'package:my_ministry/domain/providers/db_provider.dart';
import 'package:my_ministry/domain/usecases/users/users_usecase.dart';

class Usecases {
  final DbProvider _dbProvider;
  IUserUsecases userUsecases;

  Usecases() : _dbProvider = DbProvider() {
    userUsecases = UserUsecase(_dbProvider);
  }

  Future<void> init() async {
    await _dbProvider.initData();
  }
}

abstract class IUserUsecases {
  Stream<List<User>> getUsers();
  Future<void> deleteUser(User user);
  Stream<List<UserType>> getUserTypes();
  Stream<List<PhoneType>> getPhoneTypes();
  Stream<List<AddressType>> getAddressTypes();
  StreamZip<List<dynamic>> getTypes();
}
