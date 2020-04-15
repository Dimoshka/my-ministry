import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_ministry/domain/entities/entities.dart';
import 'package:my_ministry/domain/usecases/usecases.dart';
import 'package:my_ministry/presentation/ui/pages/user_edit/user_edit.dart';
import 'package:my_ministry/presentation/ui/widgets/drawer/drawer.dart';
import 'package:provider/provider.dart';

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
              MaterialPageRoute(builder: (context) => UserEdit()),
            );
          }),
      body: SafeArea(
        child: StreamBuilder<List<User>>(
          stream: Provider.of<Usecases>(context).userUsecases.getUsers(),
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.error == null &&
                snapshot.connectionState == ConnectionState.done) {
              var users = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  var user = users[index];
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
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('${user.name} user deleted')));
                      Provider.of<Usecases>(context)
                          .userUsecases
                          .deleteUser(user);
                    },
                    key: Key(user.id.toString()),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserEdit(
                                    user: user,
                                  )),
                        );
                      },
                      title: Text(user.name),
                      subtitle: Text(user.userType.toString()),
                    ),
                  );
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    Hive.box('usersBoxName').close();
    super.dispose();
  }
}
