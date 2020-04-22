import 'package:equatable/equatable.dart';
import 'package:my_ministry/data/dto/dto.dart' as hive;
import 'entities.dart';

class People extends Equatable {
  People(this.id, this.name, this.peopleType,
      {this.birthday, this.phones, this.addresses});

  People.empty()
      : id = null,
        name = null,
        peopleType = null,
        birthday = null,
        phones = [],
        addresses = [];

  People.fromHive(hive.People peopleHive)
      : id = peopleHive.key as int,
        name = peopleHive.name,
        peopleType = PeopleType.fromHive(peopleHive.peopleType),
        birthday = peopleHive.birthday,
        phones = [],
        addresses = [] {
    if (peopleHive.phones != null) {
      peopleHive.phones.forEach((phoneHive) {
        phones.add(Phone.fromHive(phoneHive));
      });
    }

    if (peopleHive.addresses != null) {
      peopleHive.addresses.forEach((addressHive) {
        addresses.add(Address.fromHive(addressHive));
      });
    }
  }

  final int id;
  final String name;
  final PeopleType peopleType;
  final DateTime birthday;
  final List<Phone> phones;
  final List<Address> addresses;

  @override
  List<Object> get props => [id, name, peopleType, birthday, phones, addresses];

  @override
  String toString() =>
      'People { id: $id, name: $name, peopleType: ${peopleType.toString()}, birthday: $birthday, phones: ${phones.toString()}, addresses: ${addresses.toString()} }';
}
