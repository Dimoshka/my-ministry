import 'package:equatable/equatable.dart';
import 'package:my_ministry/data/dto/dto.dart' as hive;
import 'entities.dart';

class User extends Equatable {
  User(this.id, this.name, this.userType,
      {this.birthday, this.phones, this.addresses});

  User.empty()
      : id = null,
        name = null,
        userType = null,
        birthday = null,
        phones = [],
        addresses = [];

  User.fromHive(hive.User userHive)
      : id = userHive.key as int,
        name = userHive.name,
        userType = UserType.fromHive(userHive.userType),
        birthday = userHive.birthday,
        phones = [],
        addresses = [] {
    if (userHive.phones != null) {
      userHive.phones.forEach((phoneHive) {
        phones.add(Phone.fromHive(phoneHive));
      });
    }

    if (userHive.addresses != null) {
      userHive.addresses.forEach((addressHive) {
        addresses.add(Address.fromHive(addressHive));
      });
    }
  }

  final int id;
  final String name;
  final UserType userType;
  final DateTime birthday;
  final List<Phone> phones;
  final List<Address> addresses;

  @override
  List<Object> get props => [id, name, userType, birthday, phones, addresses];

  @override
  String toString() =>
      'User { id: $id, name: $name, userType: ${userType.toString()}, birthday: $birthday, phones: ${phones.toString()}, addresses: ${addresses.toString()} }';
}
