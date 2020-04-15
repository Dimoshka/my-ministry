import 'package:equatable/equatable.dart';
import 'package:my_ministry/domain/entities/entities.dart';

abstract class UserEditEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FormDataSubmitEvent extends UserEditEvent {
  final String name;
  final UserType userType;
  final DateTime birthday;
  final List<Phone> phones;
  final List<Address> addresses;

/*  final Phone _addPhone = Phone.empty();
 final int _addPhoneTypeIndex = 0;
 final Address _addAddress = Address.empty();
 final int _addAddressTypeIndex = 0; */

  FormDataSubmitEvent(
      {this.name, this.userType, this.birthday, this.phones, this.addresses});

  @override
  List<Object> get props => [name, userType];
}

class PhoneRemoveEvent extends UserEditEvent {
  final Phone phone;

  PhoneRemoveEvent(this.phone);

  @override
  List<Object> get props => [phone];
}

class AddPhoneChangeEvent extends UserEditEvent {
  final String number;
  final PhoneType phoneType;
  final String note;

  AddPhoneChangeEvent({this.number, this.phoneType, this.note});

  @override
  List<Object> get props => [number, phoneType];
}

class AddPhoneSubmitEvent extends UserEditEvent {}

class AddressRemoveEvent extends UserEditEvent {
  final Address address;

  AddressRemoveEvent(this.address);

  @override
  List<Object> get props => [address];
}

class AddAddressChangeEvent extends UserEditEvent {
  final String location;
  final AddressType addressType;
  final String note;

  AddAddressChangeEvent({this.location, this.addressType, this.note});

  @override
  List<Object> get props => [location, location];
}

class AddAddressSubmitEvent extends UserEditEvent {}

class FormSubmitEvent extends UserEditEvent {}
