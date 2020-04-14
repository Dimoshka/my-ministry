import 'package:flutter/material.dart';
import 'package:my_ministry/domain/entities/entities.dart';

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

  final User _user;
  Phone _addPhone = Phone.empty();
  Address _addAddress = Address.empty();

  final _formKey = GlobalKey<FormState>();

  final _userTypes = <String>[
    'Unbaptized publisher',
    'Publisher',
    'Auxiliary pioneer',
    'Pioneer',
    'Fulltime ministry'
  ];

  final _phoneTypes = <String>[
    'Mobile',
    'Home',
    'Work',
    'Etc',
  ];

  final _addressTypes = <String>[
    'Home',
    'Work',
    'Etc',
  ];

/*   final _phones = <Phone>[
    Phone('+380503607060', PhoneType.mobile, note: 'njdjkfnjsdncjskdncj'),
    Phone('+380503607060', PhoneType.mobile)
  ];
  final _addresses = <Address>[
    Address('23 Августа 63', AddressType.home, note: 'njdjkfnjsdncjskdncj'),
  ];
 */
  _UserEditState(this._user) : _isNewUser = _user.id == null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isNewUser ? 'New user' : _user.name),
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
                      _user.name = value;
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
                    child: ToggleButtons(
                        onPressed: (index) {
                          setState(() {
                            _user.userType = _getUserTypeByIndex(index);
                          });
                        },
                        children: _getUserTypes(),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        isSelected: _getUserTypesIsSelected()),
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
                      children: _getPhones(),
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
                      children: _getAdresses(),
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

  List<Widget> _getUserTypes() {
    final widgets = <Widget>[];
    _userTypes.forEach((type) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(type),
      ));
    });
    return widgets;
  }

  List<bool> _getUserTypesIsSelected() {
    final selecteds = <bool>[];
    for (var i = 0; i < _userTypes.length; i++) {
      selecteds.add(_user != null && _user.userType == _getUserTypeByIndex(i));
    }
    return selecteds;
  }

  UserType _getUserTypeByIndex(int index) {
    return null;
    /* switch (index) {
      case 0:
        return UserType.unbaptized_publisher;
      case 1:
        return UserType.publisher;
      case 2:
        return UserType.auxiliary_pioneer;
      case 3:
        return UserType.pioneer;
      case 4:
        return UserType.fulltime_ministry;
      default:
        return UserType.unbaptized_publisher;
    } */
  }

  PhoneType _getPhoneTypeByIndex(int index) {
    return null;
    /* switch (index) {
      case 0:
        return PhoneType.mobile;
      case 1:
        return PhoneType.home;
      case 2:
        return PhoneType.work;
      case 3:
        return PhoneType.etc;
      default:
        return PhoneType.mobile;
    } */
  }

  AddressType _getAddressTypeByIndex(int index) {
    return null;
    /* switch (index) {
      case 0:
        return AddressType.home;
      case 1:
        return AddressType.work;
      case 2:
        return AddressType.etc;
      default:
        return AddressType.home;
    } */
  }

  List<Widget> _getPhones() {
    final widgets = <Widget>[];
    if (_user.phones != null) {
      for (var i = 0; i < _user.phones.length; i++) {
        var phone = _user.phones[i];
        widgets.add(ListTile(
          title: Text(phone.number),
          isThreeLine: phone.note != null && phone.note.isNotEmpty,
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(phone.phoneType.toString()),
              Text(phone.note.toString())
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
                        _user.phones.removeAt(i);
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
            _addPhone.number = value;
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
        subtitle: DropdownButton(
            isExpanded: true,
            items: _getPhoneTypeWidgetList(),
            onChanged: (item) {
              _addAddress.addressType = _getAddressTypeByIndex(item as int);
            }),
        trailing: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _user.phones.add(_addPhone);
                _addPhone = Phone.empty();
              });
            }),
      ),
    );

    return widgets;
  }

  List<DropdownMenuItem<int>> _getPhoneTypeWidgetList() {
    var dropdownMenuItems = <DropdownMenuItem<int>>[];
    for (var i = 0; i < _phoneTypes.length; i++) {
      dropdownMenuItems
          .add(DropdownMenuItem<int>(child: Text(_phoneTypes[i]), value: i));
    }
    return dropdownMenuItems;
  }

  List<Widget> _getAdresses() {
    final widgets = <Widget>[];
    if (_user.addresses != null) {
      for (var i = 0; i < _user.addresses.length; i++) {
        var adress = _user.addresses[i];
        widgets.add(ListTile(
          title: Text(adress.location),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(adress.addressType.toString()),
              Text(adress.note.toString())
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
                        _user.addresses.removeAt(i);
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
            _addAddress.location = value;
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
        subtitle: DropdownButton(
            isExpanded: true,
            items: _getAddressTypeWidgetList(),
            onChanged: (item) {
              _addAddress.addressType = _getAddressTypeByIndex(item as int);
            }),
        trailing: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _user.addresses.add(_addAddress);
                _addAddress = Address.empty();
              });
            }),
      ),
    );

    return widgets;
  }

  List<DropdownMenuItem<int>> _getAddressTypeWidgetList() {
    var dropdownMenuItems = <DropdownMenuItem<int>>[];
    for (var i = 0; i < _addressTypes.length; i++) {
      dropdownMenuItems
          .add(DropdownMenuItem<int>(child: Text(_addressTypes[i]), value: i));
    }
    return dropdownMenuItems;
  }
}
