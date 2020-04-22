import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ministry/domain/entities/entities.dart';
import 'package:my_ministry/domain/usecases/usecases.dart';
import 'package:my_ministry/presentation/ui/pages/people_edit/bloc/bloc.dart';
import 'package:provider/provider.dart';

class PeopleEdit extends StatelessWidget {
  final People people;
  final _formKey = GlobalKey<FormState>();

  PeopleEdit({this.people, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var useCases = Provider.of<Usecases>(context);
    return BlocProvider<PeopleEditBloc>(
      create: (BuildContext context) =>
          PeopleEditBloc(useCases)..add(LoadDataEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(people == null ? 'New people' : people.name),
        ),
        body: SafeArea(
          child: Center(
            child: BlocBuilder<PeopleEditBloc, PeopleEditState>(
                builder: (context, state) {
              final peopleEditBloc = BlocProvider.of<PeopleEditBloc>(context);
              if (state is LoadingState) {
                return CircularProgressIndicator();
              } else if (state is UserFormState) {
                return _getForm(peopleEditBloc, context, state);
              } else {
                return Container();
              }
            }),
          ),
        ),
      ),
    );
  }

  Widget _getForm(PeopleEditBloc peopleEditBloc, BuildContext context,
      UserFormState state) {
    return Form(
      key: _formKey,
      autovalidate: true,
      child: Container(
        constraints: BoxConstraints(maxWidth: 600.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'People name',
                  hintText: 'Put the people name',
                  icon: Icon(Icons.supervised_user_circle)),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              initialValue: people != null ? people.name : '',
              onChanged: (value) {
                peopleEditBloc.add(FormDataSubmitEvent(name: value));
              },
              validator: (_) {
                return state.nameError;
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'People type',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            Center(
              child: ToggleButtons(
                  onPressed: (index) {
                    peopleEditBloc.add(FormDataSubmitEvent(
                        peopleType: state.peopleTypes[index]));
                  },
                  children: _getpeopleTypes(state.peopleTypes),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  isSelected: _getpeopleTypesIsSelected(
                      state.peopleTypes, state.peopleType)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Phones',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.black12,
                  ),
                  shape: BoxShape.rectangle),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _getPhones(peopleEditBloc, state.phones,
                    state.phoneTypes, state.addPhoneTypeIndex),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Adresses',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.black12,
                  ),
                  shape: BoxShape.rectangle),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _getAdresses(peopleEditBloc, state.addresses,
                    state.addressTypes, state.addAddressTypeIndex),
              ),
            ),
            ListTile(
              title: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Birthday',
                    hintText: 'Put the birthday',
                    icon: Icon(Icons.date_range)),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context),
              ),
            ),
            RaisedButton(
              onPressed: () {},
              child: Text(people == null ? 'Add a new people' : 'Save people'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year - 6),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      //setState(() {
      //selectedDate = picked;
      //});
    }
  }

  List<Widget> _getpeopleTypes(List<PeopleType> peopleTypes) {
    final widgets = <Widget>[];
    peopleTypes.forEach((type) {
      widgets.add(Padding(
        key: Key('peopleType${type.id}'),
        padding: const EdgeInsets.all(8.0),
        child: Text(type.name),
      ));
    });
    return widgets;
  }

  List<bool> _getpeopleTypesIsSelected(
      List<PeopleType> peopleTypes, PeopleType peopleType) {
    final selecteds = <bool>[];
    for (var i = 0; i < peopleTypes.length; i++) {
      selecteds.add(peopleType != null &&
          peopleType.id != null &&
          peopleType.id == peopleTypes[i].id);
    }
    return selecteds;
  }

  List<Widget> _getPhones(PeopleEditBloc userEditBloc, List<Phone> phones,
      List<PhoneType> phoneTypes, int addPhoneTypeIndex) {
    final widgets = <Widget>[];
    for (var i = 0; i < phones.length; i++) {
      var phone = phones[i];
      widgets.add(ListTile(
        onTap: () {},
        title: Text(phone.number),
        isThreeLine: phone.note != null && phone.note.isNotEmpty,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: phone.note != null
              ? <Widget>[Text(phone.phoneType.name), Text(phone.note)]
              : <Widget>[
                  Text(phone.phoneType.name),
                ],
        ),
        trailing: Container(
          constraints: BoxConstraints(maxWidth: 96.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              IconButton(icon: Icon(Icons.edit), onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    userEditBloc.add(PhoneRemoveEvent(phones[i]));
                  }),
            ],
          ),
        ),
      ));
    }

    widgets.add(
      ListTile(
        title: TextFormField(
          onChanged: (value) {
            userEditBloc.add(AddPhoneChangeEvent(number: value));
          },
          decoration: InputDecoration(
              labelText: 'Phone number',
              hintText: 'Put the phone number',
              icon: Icon(Icons.phone)),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        subtitle: DropdownButton<int>(
            isExpanded: true,
            items: _getPhoneTypeWidgetList(phoneTypes),
            value: addPhoneTypeIndex,
            onChanged: (index) {
              userEditBloc
                  .add(AddPhoneChangeEvent(phoneType: phoneTypes[index]));
            }),
        trailing: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              userEditBloc.add(AddPhoneSubmitEvent());
            }),
      ),
    );

    return widgets;
  }

  List<DropdownMenuItem<int>> _getPhoneTypeWidgetList(
      List<PhoneType> phoneTypes) {
    var dropdownMenuItems = <DropdownMenuItem<int>>[];
    for (var i = 0; i < phoneTypes.length; i++) {
      dropdownMenuItems.add(DropdownMenuItem<int>(
          key: Key('PhoneType${phoneTypes[i].id}'),
          child: Text(phoneTypes[i].name),
          value: i));
    }
    return dropdownMenuItems;
  }

  List<Widget> _getAdresses(
      PeopleEditBloc userEditBloc,
      List<Address> addresses,
      List<AddressType> addressTypes,
      int addAddressTypeIndex) {
    final widgets = <Widget>[];
    for (var i = 0; i < addresses.length; i++) {
      var adress = addresses[i];
      widgets.add(ListTile(
        onTap: () {},
        title: Text(adress.location),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: adress.note != null
              ? <Widget>[Text(adress.addressType.name), Text(adress.note)]
              : <Widget>[
                  Text(adress.addressType.name),
                ],
        ),
        isThreeLine: adress.note != null && adress.note.isNotEmpty,
        trailing: Container(
          constraints: BoxConstraints(maxWidth: 96.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              IconButton(icon: Icon(Icons.edit), onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    userEditBloc.add(AddressRemoveEvent(addresses[i]));
                  }),
            ],
          ),
        ),
      ));
    }

    widgets.add(
      ListTile(
        title: TextFormField(
          onChanged: (value) {
            userEditBloc.add(AddAddressChangeEvent(location: value));
          },
          decoration: InputDecoration(
              labelText: 'Address',
              hintText: 'Put the address',
              icon: Icon(Icons.phone)),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        subtitle: DropdownButton<int>(
            isExpanded: true,
            items: _getAddressTypeWidgetList(addressTypes),
            value: addAddressTypeIndex,
            onChanged: (index) {
              userEditBloc
                  .add(AddAddressChangeEvent(addressType: addressTypes[index]));
            }),
        trailing: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              userEditBloc.add(AddAddressSubmitEvent());
            }),
      ),
    );

    return widgets;
  }

  List<DropdownMenuItem<int>> _getAddressTypeWidgetList(
      List<AddressType> addressTypes) {
    var dropdownMenuItems = <DropdownMenuItem<int>>[];
    for (var i = 0; i < addressTypes.length; i++) {
      dropdownMenuItems.add(DropdownMenuItem<int>(
          key: Key('AddressType${addressTypes[i].id}'),
          child: Text(addressTypes[i].name),
          value: i));
    }
    return dropdownMenuItems;
  }
}

/* class _UserEditState extends State<UserEdit> {


  _UserEditState(User user)
      : _isNewUser = user.id == null,
        id = user.id {
    _name = user.name;
    _peopleType = user.peopleType;
    _birthday = user.birthday;
    _phones = user.phones;
    _addresses = user.addresses;
  }

  @override
  Widget build(BuildContext context) {}
} */
