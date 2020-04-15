import 'package:flutter/material.dart';
import 'package:my_ministry/presentation/ui/pages/main/main.dart';
import 'package:my_ministry/presentation/ui/pages/users/users.dart';

class DrawerApp extends StatefulWidget {
  final DrawerMenu _selectedMenu;

  DrawerApp(this._selectedMenu, {Key key}) : super(key: key);

  @override
  _DrawerState createState() => _DrawerState(_selectedMenu);
}

class _DrawerState extends State<DrawerApp> {
  final DrawerMenu _selectedMenu;
  _DrawerState(this._selectedMenu);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blue, Colors.red])),
            child: Center(child: Text('My ministry'))),
        ListTile(
          title: Text('Main'),
          selected:  _selectedMenu == DrawerMenu.main,
          enabled: _selectedMenu != DrawerMenu.main,
          onLongPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Main()),
            );
          },
        ),
        ListTile(
          title: Text('Users'),
          enabled: _selectedMenu == DrawerMenu.users,
          onLongPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Users()),
            );
          },
        )
      ],
    );
  }
}

enum DrawerMenu {
  main,
  users,
}
