import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ministry/domain/entities/entities.dart';
import 'package:my_ministry/domain/usecases/usecases.dart';
import 'package:my_ministry/presentation/resources/resources.dart';
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
            child: BlocListener<PeopleEditBloc, PeopleEditState>(
              listener: (context, state) {
                if (state is PeopleFormState &&
                    (state.nameError != null ||
                        state.peopleTypeError != null ||
                        state.addPhoneError != null ||
                            state.addAddressError != null)) {
                             
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(state.nameError ??
                          state.peopleTypeError ??
                          state.addPhoneError ??
                          state.addAddressError ??
                          '')));
                }
              },
              child: BlocBuilder<PeopleEditBloc, PeopleEditState>(
                  builder: (context, state) {
                final peopleEditBloc = BlocProvider.of<PeopleEditBloc>(context);
                if (state is LoadingState) {
                  return CircularProgressIndicator();
                } else if (state is PeopleFormState) {
                  return SingleChildScrollView(
                      child: _getForm(peopleEditBloc, context, state));
                } else {
                  return Container();
                }
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getForm(PeopleEditBloc peopleEditBloc, BuildContext context,
      PeopleFormState state) {
    return Form(
      key: _formKey,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidthWidget),
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
              padding: defaultPadding,
              child: Text(
                'People type',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ToggleButtons(
                  selectedColor: Colors.amber.shade400,
                  constraints: BoxConstraints(maxWidth: maxWidthWidget),
                  onPressed: (index) {
                    peopleEditBloc.add(FormDataSubmitEvent(
                        peopleType: state.peopleTypes[index]));
                  },
                  children: _getpeopleTypes(state.peopleTypes),
                  borderRadius: BorderRadius.all(defaultRadius),
                  isSelected: _getpeopleTypesIsSelected(
                      state.peopleTypes, state.peopleType)),
            ),
            Padding(
              padding: defaultPadding,
              child: Text(
                'Phones',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            Container(
              padding: defaultPadding,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(defaultRadius),
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.black12,
                  ),
                  shape: BoxShape.rectangle),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _getPhones(peopleEditBloc, state),
              ),
            ),
            Padding(
              padding: defaultPadding,
              child: Text(
                'Adresses',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            Container(
              padding: defaultPadding,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(defaultRadius),
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.black12,
                  ),
                  shape: BoxShape.rectangle),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _getAdresses(peopleEditBloc, state),
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
            Align(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                onPressed: () {},
                child:
                    Text(people == null ? 'Add a new people' : 'Save people'),
              ),
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
        padding: defaultPadding,
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

  List<Widget> _getPhones(PeopleEditBloc userEditBloc, PeopleFormState state) {
    final widgets = <Widget>[];
    for (var i = 0; i < state.phones.length; i++) {
      var phone = state.phones[i];
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
                    userEditBloc.add(PhoneRemoveEvent(state.phones[i]));
                  }),
            ],
          ),
        ),
      ));
    }

    widgets.add(_getAddPhoneWidget(userEditBloc, state));

    return widgets;
  }

  Widget _getAddPhoneWidget(
      PeopleEditBloc userEditBloc, PeopleFormState state) {
    return ListTile(
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
          return state.addPhoneError;
        },
      ),
      subtitle: DropdownButton<int>(
          isExpanded: true,
          items: _getPhoneTypeWidgetList(state.phoneTypes),
          value: state.addPhoneTypeIndex,
          onChanged: (index) {
            userEditBloc
                .add(AddPhoneChangeEvent(phoneType: state.phoneTypes[index]));
          }),
      trailing: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            userEditBloc.add(AddPhoneSubmitEvent());
          }),
    );
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
      PeopleEditBloc userEditBloc, PeopleFormState state) {
    final widgets = <Widget>[];
    for (var i = 0; i < state.addresses.length; i++) {
      var adress = state.addresses[i];
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
                    userEditBloc.add(AddressRemoveEvent(state.addresses[i]));
                  }),
            ],
          ),
        ),
      ));
    }

    widgets.add(_getAddAddressWidget(userEditBloc, state));

    return widgets;
  }

  Widget _getAddAddressWidget(
      PeopleEditBloc userEditBloc, PeopleFormState state) {
    return ListTile(
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
          return state.addAddressError;
        },
      ),
      subtitle: DropdownButton<int>(
          isExpanded: true,
          items: _getAddressTypeWidgetList(state.addressTypes),
          value: state.addAddressTypeIndex,
          onChanged: (index) {
            userEditBloc.add(
                AddAddressChangeEvent(addressType: state.addressTypes[index]));
          }),
      trailing: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            userEditBloc.add(AddAddressSubmitEvent());
          }),
    );
  }

  List<DropdownMenuItem<int>> _getAddressTypeWidgetList(
      List<AddressType> addressTypes) {
    var dropdownMenuItems = <DropdownMenuItem<int>>[];
    for (var i = 0; i < addressTypes.length; i++) {
      dropdownMenuItems.add(DropdownMenuItem<int>(
          key: Key(addressTypes[i].toString()),
          child: Text(addressTypes[i].name),
          value: i));
    }
    return dropdownMenuItems;
  }
}
