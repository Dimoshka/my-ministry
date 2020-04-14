import 'package:my_ministry/data/dto/dto.dart' as hive;
import 'entities.dart';

class User {
  User.empty() {
    phones = [];
    addresses = [];
  }

  User(this.id, this.name, this.userType,
      {this.birthday, this.phones, this.addresses}) {
    phones ??= [];
    addresses ??= [];
  }

  User.fromHive(hive.User userHive) {
    id = userHive.key as int;
    name = userHive.name;
    userType = UserType.fromHive(userHive.userType);
    birthday = userHive.birthday;

    if (userHive.phones == null) {
      phones = [];
    } else {
      userHive.phones.forEach((phoneHive) {
        phones.add(Phone.fromHive(phoneHive));
      });
    }

    if (userHive.addresses == null) {
      addresses = [];
    } else {
      userHive.addresses.forEach((addressHive) {
        addresses.add(Address.fromHive(addressHive));
      });
    }
  }

  int id;
  String name;
  UserType userType;
  DateTime birthday;
  List<Phone> phones;
  List<Address> addresses;
}
