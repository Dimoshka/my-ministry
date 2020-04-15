import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ministry/domain/entities/entities.dart';
import 'package:my_ministry/presentation/ui/pages/user_edit/bloc/bloc.dart';
import 'package:my_ministry/presentation/utils/form_validator_mixin.dart';

class UserEditBloc extends Bloc<UserEditEvent, UserEditState>
    with FormValidatorMixin {
  String _name;
  UserType _userType;
  DateTime _birthday;
  List<Phone> _phones;
  List<Address> _addresses;

  Phone _addPhone = Phone.empty();
  int _addPhoneTypeIndex = 0;
  Address _addAddress = Address.empty();
  int _addAddressTypeIndex = 0;

  @override
  UserEditState get initialState => null;

  @override
  Stream<UserEditState> mapEventToState(UserEditEvent event) async* {
    if (event is FormDataSubmitEvent) {
      if (event.name != null) _name = event.name;
      if (event.userType != null) _userType = event.userType;

      /* if (isFieldEmpty(event.name)) {
        yield UserFormState(nameError: 'Please enter some text');
        return;
      }

      if (!isNotNull(event.userType)) {
        yield UserFormState(userTypeError: 'Please select user type');
        return;
      } */
    }
  }
}
