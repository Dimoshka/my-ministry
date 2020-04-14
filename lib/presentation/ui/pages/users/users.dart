import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_ministry/domain/entities/entities.dart';
import 'package:my_ministry/presentation/ui/pages/user_edit/user_edit.dart';
import 'package:my_ministry/presentation/ui/widgets/drawer/drawer.dart';

class Users extends StatefulWidget {
  Users({Key key}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Users'),
        ),
        drawer: Drawer(
          semanticLabel: 'Menu',
          child: DrawerApp(DrawerMenu.users),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserEdit(null)),
              );
            }),
        body: FutureBuilder(
            future: Hive.openBox('usersBoxName'),
            builder: (context, snapshot) {
              var usersBox = Hive.box('usersBoxName');
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return CircularProgressIndicator();
                }
                return SafeArea(
                  child: ValueListenableBuilder(
                      valueListenable: usersBox.listenable(),
                      builder: (context, box, widget) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: usersBox.length,
                          itemBuilder: (context, index) {
                            var user = usersBox.getAt(index) as User;
                            return Dismissible(
                              background: Container(
                                alignment: AlignmentDirectional.centerStart,
                                color: Colors.blueAccent,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Icon(
                                    Icons.delete_forever,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              direction: DismissDirection.startToEnd,
                              onDismissed: (direction) {
                                usersBox.deleteAt(index);
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content:
                                        Text('${user.name} user deleted')));
                              },
                              key: Key(user.id.toString()),
                              child: ListTile(
                                onTap: () {},
                                title: Text(user.name),
                                subtitle: Text(user.userType.toString()),
                              ),
                            );
                          },
                        );
                      }),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  @override
  void dispose() {
    Hive.box('usersBoxName').close();
    super.dispose();
  }
}
