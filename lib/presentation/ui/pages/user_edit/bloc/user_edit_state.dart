import 'package:equatable/equatable.dart';
import 'package:my_ministry/domain/entities/entities.dart';

abstract class UserEditState extends Equatable {
  const UserEditState();

  @override
  List<Object> get props => [];
}

class LoadingState extends UserEditState {}

class UserFormState extends UserEditState {
  /// Main data
  final UserType userType;
  final DateTime birthday;
  final List<Phone> phones;
  final List<Address> addresses;

  final List<UserType> userTypes = [];
  final List<PhoneType> phoneTypes = [];
  final List<AddressType> addressTypes = [];

  final int addPhoneTypeIndex = 0;
  final int addAddressTypeIndex = 0;

  /// Errors
  final String nameError;
  final String userTypeError;

  UserFormState(this.userType, this.birthday, this.phones, this.addresses,
      {this.nameError, this.userTypeError});

  @override
  List<Object> get props => [nameError, userTypeError];
}
