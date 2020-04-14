import 'package:flutter/material.dart';
import 'package:my_ministry/presentation/ui/widgets/drawer/drawer.dart';

class Main extends StatefulWidget {
  Main({Key key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerApp(DrawerMenu.main),
      ),
      appBar: AppBar(
        title: Text('Main page'),
      ),
    );
  }
}
