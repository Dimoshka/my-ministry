import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ministry/domain/entities/entities.dart';
import 'package:my_ministry/domain/usecases/usecases.dart';
import 'package:my_ministry/presentation/ui/pages/people_edit/bloc/bloc.dart';
import 'package:my_ministry/presentation/utils/form_validator_mixin.dart';

class PeopleEditBloc extends Bloc<PeopleEditEvent, PeopleEditState>
    with FormValidatorMixin {
  final Usecases _usecases;

  PeopleEditBloc(this._usecases);

  String _name;
  PeopleType _peopleType;
  DateTime _birthday;

  List<PeopleType> _peopleTypes = [];
  List<PhoneType> _phoneTypes = [];
  List<AddressType> _addressTypes = [];

  List<Phone> _phones = [];
  List<Address> _addresses = [];

  Phone _addPhone = Phone.empty();
  int _addPhoneTypeIndex = 0;
  Address _addAddress = Address.empty();
  int _addAddressTypeIndex = 0;

  @override
  PeopleEditState get initialState => LoadingState();

  @override
  Stream<PeopleEditState> mapEventToState(PeopleEditEvent event) async* {
    if (event is LoadDataEvent) {
      yield* loadData();
      //return;
    } else if (event is FormDataSubmitEvent) {
      yield editFormData(event);
      //return;
    } else if (event is PhoneRemoveEvent) {
      _phones.removeWhere((element) => element.id == event.phone.id);
      yield _getUserFormState();
      //return;
    } else if (event is AddressRemoveEvent) {
      _addresses.removeWhere((element) => element.id == event.address.id);
      yield _getUserFormState();
      //return;
    } else if (event is AddPhoneChangeEvent) {
      _addPhoneTypeIndex = _getPhoneTypeIndex(event.phoneType);
      _addPhone = _addPhone.clone(
          numberNew: event.number,
          phoneTypeNew: event.phoneType,
          noteNew: event.note);
      yield _getUserFormState();
      //return;
    } else if (event is AddAddressChangeEvent) {
      _addAddressTypeIndex = _getAddressTypeIndex(event.addressType);
      _addAddress = _addAddress.clone(
          locationNew: event.location,
          addressTypeNew: event.addressType,
          noteNew: event.note);
      yield _getUserFormState();
      //return;
    } else if (event is AddPhoneChangeEvent) {
      _phones.add(_addPhone);
      _addPhone = Phone.empty();
      yield _getUserFormState();
      //return;
    } else if (event is AddAddressSubmitEvent) {
      _addresses.add(_addAddress);
      _addAddress = Address.empty();
      yield _getUserFormState();
      return;
    } else if (event is FormSubmitEvent) {
      //return;
    }
  }

  int _getPhoneTypeIndex(PhoneType phoneType) {
    for (var i = 0; i < _phoneTypes.length; i++) {
      if (_phoneTypes[i].id == phoneType.id) {
        return i;
      }
    }
    return -1;
  }

  int _getAddressTypeIndex(AddressType addressType) {
    for (var i = 0; i < _addressTypes.length; i++) {
      if (_addressTypes[i].id == addressType.id) {
        return i;
      }
    }
    return -1;
  }

  UserFormState editFormData(FormDataSubmitEvent event) {
    if (event.name != null) {
      _name = event.name;
    }
    if (event.birthday != null) {
      _birthday = event.birthday;
    }
    if (event.peopleType != null) {
      _peopleType = event.peopleType;
    }
    return _getUserFormState();
  }

  Stream<UserFormState> loadData() async* {
    var peopleTypes = await _usecases.peopleUsecases.getPeopleTypes().first;
    _peopleTypes.clear();
    _peopleTypes.addAll(peopleTypes);

    var phoneTypes = await _usecases.peopleUsecases.getPhoneTypes().first;
    _phoneTypes.clear();
    _phoneTypes.addAll(phoneTypes);

    var addressTypes = await _usecases.peopleUsecases.getAddressTypes().first;
    _addressTypes.clear();
    _addressTypes.addAll(addressTypes);
    yield _getUserFormState();

    _usecases.peopleUsecases.getPeopleTypes().listen((types) async* {
      _peopleTypes.clear();
      _peopleTypes.addAll(types);
      yield _getUserFormState();
    });
    _usecases.peopleUsecases.getPhoneTypes().listen((types) async* {
      _phoneTypes.clear();
      _phoneTypes.addAll(types);
      yield _getUserFormState();
    });
    _usecases.peopleUsecases.getAddressTypes().listen((types) async* {
      _addressTypes.clear();
      _addressTypes.addAll(types);
      yield _getUserFormState();
    });
  }

  UserFormState _getUserFormState() {
    return UserFormState(_peopleType, _birthday, _phones, _addresses, _peopleTypes,
        _phoneTypes, _addressTypes);
  }
}
