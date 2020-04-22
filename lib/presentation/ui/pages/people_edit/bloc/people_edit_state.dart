import 'package:equatable/equatable.dart';
import 'package:my_ministry/data/repositories/database/hive_const.dart';
import 'package:my_ministry/domain/entities/entities.dart';

abstract class PeopleEditState extends Equatable {
  const PeopleEditState();

  @override
  List<Object> get props => [];
}

class LoadingState extends PeopleEditState {}

class UserFormState extends PeopleEditState {
  /// Main data
  final PeopleType peopleType;
  final DateTime birthday;
  final List<Phone> phones;
  final List<Address> addresses;

  final List<PeopleType> peopleTypes;
  final List<PhoneType> phoneTypes;
  final List<AddressType> addressTypes;

  final int addPhoneTypeIndex = 0;
  final int addAddressTypeIndex = 0;

  /// Errors
  final String nameError;
  final String peopleTypeError;

  UserFormState(this.peopleType, this.birthday, this.phones, this.addresses,
      this.peopleTypes, this.phoneTypes, this.addressTypes,
      {this.nameError, this.peopleTypeError});

  @override
  List<Object> get props => [
        peopleType.id,
        birthday,
        phones.length,
        addresses.length,
        peopleTypes.length,
        phoneTypes.length,
        addressTypes.length,
        addPhoneTypeIndex,
        addAddressTypeIndex,
        nameError,
        peopleTypeError
      ];
}
