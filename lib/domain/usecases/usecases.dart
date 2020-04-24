export 'peoples/peoples_usecase.dart';
import 'package:async/async.dart';
import 'package:my_ministry/domain/entities/entities.dart';
import 'package:my_ministry/domain/providers/db_provider.dart';
import 'package:my_ministry/domain/usecases/peoples/peoples_usecase.dart';

class Usecases {
  final DbProvider _dbProvider;
  IPeopleUsecases peopleUsecases;

  Usecases() : _dbProvider = DbProvider() {
    peopleUsecases = PeopleUsecase(_dbProvider);
  }

  Future<void> init() async {
    await _dbProvider.initData();
  }
}

abstract class IPeopleUsecases {
  Stream<List<People>> getPeoples();
  Future<void> savePeople(People people);
  Future<void> deletePeople(People people);
  Stream<List<PeopleType>> getPeopleTypes();
  Stream<List<PhoneType>> getPhoneTypes();
  Stream<List<AddressType>> getAddressTypes();
}
