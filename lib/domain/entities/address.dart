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

  Address.clone(Address address,
      {String locationNew, AddressType addressTypeNew, String noteNew})
      : id = address.id,
        location = locationNew ?? address.location,
        addressType = addressTypeNew ?? address.addressType,
        note = noteNew ?? address.note;

  final int id;
  final String location;
  final AddressType addressType;
  final String note;

  @override
  List<Object> get props => [id, location, addressType, note];

  @override
  String toString() =>
      'Address { id: $id, location: $location, addressType: ${addressType.toString()}, note: $note }';
}
