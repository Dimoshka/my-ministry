import 'package:equatable/equatable.dart';
import 'package:my_ministry/data/dto/dto.dart' as hive;

import 'entities.dart';

class Address extends Equatable {
  Address(this.id, this.location, this.addressType, this.note);

  Address.empty()
      : id = null,
        location = null,
        addressType = null,
        note = null;

  Address.fromHive(hive.Address addressHive)
      : id = addressHive.key as int,
        location = addressHive.location,
        addressType = AddressType.fromHive(addressHive.addressType),
        note = addressHive.note;

  Address clone(
      {String locationNew, AddressType addressTypeNew, String noteNew}) {
    return Address(id, locationNew ?? location, addressTypeNew ?? addressType,
        noteNew ?? note);
  }

  final int id;
  final String location;
  final AddressType addressType;
  final String note;

  @override
  List<Object> get props => [id, location, addressType, note];

  @override
  bool get stringify => true;
}
