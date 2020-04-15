import 'package:flutter/material.dart';
import 'package:my_ministry/domain/entities/entities.dart';
import 'package:my_ministry/domain/usecases/usecases.dart';
import 'package:provider/provider.dart';

class UserEdit extends StatefulWidget {
  final User _user;

  UserEdit(User user, {Key key})
      : _user = user ?? User.empty(),
        super(key: key);

  @override
  _UserEditState createState() => _UserEditState(_user);
}

class _UserEditState extends State<UserEdit> {
  final bool _isNewUser;
  final _formKey = GlobalKey<FormState>();
  final int id;

  String _name;
  UserType _userType;
  DateTime _birthday;
  List<Phone> _phones;
  List<Address> _addresses;

  Phone _addPhone = Phone.empty();
  int _addPhoneTypeIndex = 0;
  Address _addAddress = Address.empty();
  int _addAddressTypeIndex = 0;

  _UserEditState(User user)
      : _isNewUser = user.id == null,
        id = user.id {
    _name = user.name;
    _userType = user.userType;
    _birthday = user.birthday;
    _phones = user.phones;
    _addresses = user.addresses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isNewUser ? 'New user' : _name),
      ),
      body: SafeArea(
        child: Center(
          child: Form(
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
                        labelText: 'User name',
                        hintText: 'Put the user name',
                        icon: Icon(Icons.supervised_user_circle)),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      _name = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'User type',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                  Center(
                    child: StreamBuilder<List<UserType>>(
                      stream: Provider.of<Usecases>(context)
                          .userUsecases
                          .getUserTypes(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          var userTypes = snapshot.data ?? [];
                          return ToggleButtons(
                              onPressed: (index) {
                                setState(() {
                                  _userType = userTypes[index];
                                });
                              },
                              children: _getUserTypes(userTypes),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              isSelected: _getUserTypesIsSelected(userTypes));
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
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
                    child: StreamBuilder<List<PhoneType>>(
                      stream: Provider.of<Usecases>(context)
                          .userUsecases
                          .getPhoneTypes(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          var phoneTypes = snapshot.data ?? [];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: _getPhones(phoneTypes),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
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
                    child: StreamBuilder<List<AddressType>>(
                      stream: Provider.of<Usecases>(context)
                          .userUsecases
                          .getAddressTypes(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          var addressTypes = snapshot.data ?? [];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: _getAdresses(addressTypes),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
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
                    child: Text(_isNewUser ? 'Add a new user' : 'Save user'),
                  ),
                ],
              ),
            ),
          ),
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
      setState(() {
        //selectedDate = picked;
      });
    }
  }

  List<Widget> _getUserTypes(List<UserType> userTypes) {
    final widgets = <Widget>[];
    userTypes.forEach((type) {
      widgets.add(Padding(
        key: Key('UserType${type.id}'),
        padding: const EdgeInsets.all(8.0),
        child: Text(type.name),
      ));
    });
    return widgets;
  }

  List<bool> _getUserTypesIsSelected(List<UserType> userTypes) {
    final selecteds = <bool>[];
    for (var i = 0; i < userTypes.length; i++) {
      selecteds.add(_userType != null &&
          _userType.id != null &&
          _userType.id == userTypes[i].id);
    }
    return selecteds;
  }

  List<Widget> _getPhones(List<PhoneType> phoneTypes) {
    final widgets = <Widget>[];
    if (_phones != null) {
      for (var i = 0; i < _phones.length; i++) {
        var phone = _phones[i];
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
                      setState(() {
                        _phones.removeAt(i);
                      });
                    }),
              ],
            ),
          ),
        ));
      }
    }

    widgets.add(
      ListTile(
        title: TextFormField(
          onChanged: (value) {
            _addPhone = Phone.clone(_addPhone, numberNew: value);
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
            value: _addPhoneTypeIndex,
            onChanged: (index) {
              setState(() {
                _addPhoneTypeIndex = index;
                _addPhone =
                    Phone.clone(_addPhone, phoneTypeNew: phoneTypes[index]);
              });
            }),
        trailing: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _phones.add(_addPhone);
                _addPhone = Phone.empty();
              });
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

  List<Widget> _getAdresses(List<AddressType> addressTypes) {
    final widgets = <Widget>[];
    for (var i = 0; i < _addresses.length; i++) {
      var adress = _addresses[i];
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
                    setState(() {
                      _addresses.removeAt(i);
                    });
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
            _addAddress = Address.clone(_addAddress, locationNew: value);
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
            value: _addAddressTypeIndex,
            onChanged: (index) {
              setState(() {
                _addAddressTypeIndex = index;
                _addAddress = Address.clone(_addAddress,
                    addressTypeNew: addressTypes[index]);
              });
            }),
        trailing: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _addresses.add(_addAddress);
                _addAddress = Address.empty();
              });
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
