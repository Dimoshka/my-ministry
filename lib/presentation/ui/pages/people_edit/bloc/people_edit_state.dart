import 'package:equatable/equatable.dart';
import 'package:my_ministry/domain/entities/entities.dart';

abstract class PeopleEditState extends Equatable {
  const PeopleEditState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class LoadingState extends PeopleEditState {}

class PeopleFormState extends PeopleEditState {
  /// Main data
  final PeopleType peopleType;
  final DateTime birthday;
  final List<Phone> phones;
  final List<Address> addresses;

  final List<PeopleType> peopleTypes;
  final List<PhoneType> phoneTypes;
  final List<AddressType> addressTypes;

  final int addPhoneTypeIndex;
  final int addAddressTypeIndex;

  /// Errors
  final String nameError;
  final String peopleTypeError;
  final String addPhoneError;
  final String addAddressError;

  PeopleFormState(
      this.peopleType,
      this.birthday,
      this.phones,
      this.addresses,
      this.peopleTypes,
      this.phoneTypes,
      this.addressTypes,
      this.addPhoneTypeIndex,
      this.addAddressTypeIndex,
      {this.nameError,
      this.peopleTypeError,
      this.addPhoneError,
      this.addAddressError});

  @override
  List<Object> get props => [
        peopleType,
        birthday,
        phones,
        addresses,
        peopleTypes.length,
        phoneTypes.length,
        addressTypes.length,
        addPhoneTypeIndex,
        addAddressTypeIndex,
        nameError,
        peopleTypeError,
        addPhoneError,
        addAddressError
      ];
}
