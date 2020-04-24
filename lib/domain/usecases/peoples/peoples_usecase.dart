import 'package:my_ministry/domain/entities/entities.dart';
import 'package:my_ministry/domain/entities/people.dart';
import 'package:my_ministry/domain/entities/people_type.dart';
import 'package:my_ministry/domain/providers/providers.dart';
import 'package:my_ministry/domain/usecases/usecases.dart';

class PeopleUsecase extends IPeopleUsecases {
  final DbProvider _dbProvider;

  PeopleUsecase(this._dbProvider);

  @override
  Stream<List<People>> getPeoples() {
    return _dbProvider.getPeoples().map((peoples) {
      peoples.sort((user1, user2) {
        return user1.name.compareTo(user2.name);
      });
      return peoples;
    });
  }

    @override
  Future<void> savePeople(People people) {
    // TODO: implement savePeople
    throw UnimplementedError();
  }

  @override
  Future<void> deletePeople(People people) {
    return _dbProvider.deletePeople(people);
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
  Stream<List<PeopleType>> getPeopleTypes() {
    return _dbProvider.getPeopleTypes();
  }
}
