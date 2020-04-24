import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ministry/domain/entities/entities.dart';
import 'package:my_ministry/domain/usecases/usecases.dart';
import 'package:my_ministry/presentation/ui/pages/people_edit/bloc/bloc.dart';
import 'package:my_ministry/presentation/utils/form_validator_mixin.dart';

class PeopleEditBloc extends Bloc<PeopleEditEvent, PeopleEditState>
    with FormValidatorMixin {
  final Usecases _usecases;
  final People _people;

  PeopleEditBloc(this._usecases, this._people);

  String _name;
  PeopleType _peopleType;
  DateTime _birthday;

  final List<PeopleType> _peopleTypes = [];
  final List<PhoneType> _phoneTypes = [];
  final List<AddressType> _addressTypes = [];

  final List<Phone> _phones = [];
  final List<Address> _addresses = [];

  Phone _addPhone = Phone.empty();
  int _addPhoneTypeIndex;
  Address _addAddress = Address.empty();
  int _addAddressTypeIndex;

  @override
  PeopleEditState get initialState => LoadingState();

  @override
  Stream<PeopleEditState> mapEventToState(PeopleEditEvent event) async* {
    if (event is LoadDataEvent) {
      yield* loadData();
    } else if (event is FormDataSubmitEvent) {
      yield _getFormDataSubmitEventState(event);
    } else if (event is PhoneRemoveEvent) {
      _phones.removeWhere((element) => element.id == event.phone.id);
      yield _createPeopleEditState();
    } else if (event is AddressRemoveEvent) {
      _addresses.removeWhere((element) => element.id == event.address.id);
      yield _createPeopleEditState();
    } else if (event is AddPhoneChangeEvent) {
      _addPhoneTypeIndex = _getPhoneTypeIndex(event.phoneType);
      _addPhone = _addPhone.clone(
          numberNew: event.number,
          phoneTypeNew: event.phoneType,
          noteNew: event.note);
      yield _createPeopleEditState();
    } else if (event is AddAddressChangeEvent) {
      _addAddressTypeIndex = _getAddressTypeIndex(event.addressType);
      _addAddress = _addAddress.clone(
          locationNew: event.location,
          addressTypeNew: event.addressType,
          noteNew: event.note);
      yield _createPeopleEditState();
    } else if (event is AddPhoneSubmitEvent) {
      if (_addPhone.number != null &&
          _addPhone.number.isNotEmpty &&
          _addPhone.phoneType != null &&
          validatePhoneNumber(_addPhone.number)) {
        _phones.add(_addPhone);
        _addPhone = Phone.empty();
        _addPhoneTypeIndex = null;
        yield _createPeopleEditState();
      } else {
        yield _createPeopleEditState(
            addPhoneError: 'Phone number or type not valid!');
      }
    } else if (event is AddAddressSubmitEvent) {
      if (_addAddress.location != null &&
          _addAddress.location.isNotEmpty &&
          _addAddress.addressType != null) {
        _addresses.add(_addAddress);
        _addAddress = Address.empty();
        _addAddressTypeIndex = null;
        yield _createPeopleEditState();
      } else {
        yield _createPeopleEditState(
            addPhoneError: 'Address location or type not valid!');
      }
    } else if (event is FormSubmitEvent) {
      if (_name != null && _name.isNotEmpty && _peopleType != null) {
        var id = _people != null ? _people.id : null;
        await _usecases.peopleUsecases.savePeople(People(id, _name, _peopleType,
            birthday: _birthday, phones: _phones, addresses: _addresses));
        yield SuccessState();
      } else {
        if (_peopleType != null) {
          yield _createPeopleEditState(
              nameError: 'The name should not be empty!');
        } else {
          yield _createPeopleEditState(
              peopleTypeError: 'The people type should be selected!');
        }
      }
    }
  }

  int _getPhoneTypeIndex(PhoneType phoneType) {
    if (phoneType == null) {
      return null;
    }
    for (var i = 0; i < _phoneTypes.length; i++) {
      if (_phoneTypes[i].id == phoneType.id) {
        return i;
      }
    }
    return null;
  }

  int _getAddressTypeIndex(AddressType addressType) {
    if (addressType == null) {
      return null;
    }
    for (var i = 0; i < _addressTypes.length; i++) {
      if (_addressTypes[i].id == addressType.id) {
        return i;
      }
    }
    return null;
  }

  Stream<PeopleFormState> loadData() async* {
    var peopleTypes = await _usecases.peopleUsecases.getPeopleTypes().first;
    _peopleTypes.clear();
    _peopleTypes.addAll(peopleTypes);

    var phoneTypes = await _usecases.peopleUsecases.getPhoneTypes().first;
    _phoneTypes.clear();
    _phoneTypes.addAll(phoneTypes);

    var addressTypes = await _usecases.peopleUsecases.getAddressTypes().first;
    _addressTypes.clear();
    _addressTypes.addAll(addressTypes);
    yield _createPeopleEditState();

    _usecases.peopleUsecases.getPeopleTypes().listen((types) async* {
      _peopleTypes.clear();
      _peopleTypes.addAll(types);
      yield _createPeopleEditState();
    });
    _usecases.peopleUsecases.getPhoneTypes().listen((types) async* {
      _phoneTypes.clear();
      _phoneTypes.addAll(types);
      yield _createPeopleEditState();
    });
    _usecases.peopleUsecases.getAddressTypes().listen((types) async* {
      _addressTypes.clear();
      _addressTypes.addAll(types);
      yield _createPeopleEditState();
    });
  }

  PeopleFormState _getFormDataSubmitEventState(FormDataSubmitEvent event) {
    if (event.name != null) {
      _name = event.name;
    }
    if (event.birthday != null) {
      _birthday = event.birthday;
    }
    if (event.peopleType != null) {
      _peopleType = event.peopleType;
    }
    return _createPeopleEditState();
  }

  PeopleFormState _createPeopleEditState(
      {String nameError,
      String peopleTypeError,
      String addPhoneError,
      String addAddressError}) {
    return PeopleFormState(
        _peopleType,
        _birthday,
        _phones,
        _addresses,
        _peopleTypes,
        _phoneTypes,
        _addressTypes,
        _addPhoneTypeIndex,
        _addAddressTypeIndex,
        nameError: nameError,
        peopleTypeError: peopleTypeError,
        addPhoneError: addPhoneError,
        addAddressError: addAddressError);
  }
}
