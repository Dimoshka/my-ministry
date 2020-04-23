import 'package:equatable/equatable.dart';
import 'package:my_ministry/domain/entities/entities.dart';

abstract class PeopleEditEvent extends Equatable {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class LoadDataEvent extends PeopleEditEvent {}

class FormDataSubmitEvent extends PeopleEditEvent {
  final String name;
  final PeopleType peopleType;
  final DateTime birthday;

  FormDataSubmitEvent({this.name, this.peopleType, this.birthday});

  @override
  List<Object> get props => [name, peopleType, birthday];
}

class PhoneRemoveEvent extends PeopleEditEvent {
  final Phone phone;

  PhoneRemoveEvent(this.phone);

  @override
  List<Object> get props => [phone];
}

class AddPhoneChangeEvent extends PeopleEditEvent {
  final String number;
  final PhoneType phoneType;
  final String note;

  AddPhoneChangeEvent({this.number, this.phoneType, this.note});

  @override
  List<Object> get props => [number, phoneType];
}

class AddPhoneSubmitEvent extends PeopleEditEvent {}

class AddressRemoveEvent extends PeopleEditEvent {
  final Address address;

  AddressRemoveEvent(this.address);

  @override
  List<Object> get props => [address];
}

class AddAddressChangeEvent extends PeopleEditEvent {
  final String location;
  final AddressType addressType;
  final String note;

  AddAddressChangeEvent({this.location, this.addressType, this.note});

  @override
  List<Object> get props => [location, addressType];
}

class AddAddressSubmitEvent extends PeopleEditEvent {}

class FormSubmitEvent extends PeopleEditEvent {}
