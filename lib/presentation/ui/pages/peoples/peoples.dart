import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_ministry/domain/entities/entities.dart';
import 'package:my_ministry/domain/usecases/usecases.dart';
import 'package:my_ministry/presentation/ui/pages/people_edit/people_edit.dart';
import 'package:my_ministry/presentation/ui/widgets/drawer/drawer.dart';
import 'package:provider/provider.dart';

class Peoples extends StatefulWidget {
  Peoples({Key key}) : super(key: key);

  @override
  _PeoplesState createState() => _PeoplesState();
}

class _PeoplesState extends State<Peoples> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peoples'),
      ),
      drawer: Drawer(
        semanticLabel: 'Menu',
        child: DrawerApp(DrawerMenu.peoples),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PeopleEdit()),
            );
          }),
      body: SafeArea(
        child: StreamBuilder<List<People>>(
          stream: Provider.of<Usecases>(context).peopleUsecases.getPeoples(),
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.error == null &&
                snapshot.connectionState == ConnectionState.done) {
              var peoples = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: peoples.length,
                itemBuilder: (context, index) {
                  var people = peoples[index];
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
                          SnackBar(content: Text('${people.name} people deleted')));
                      Provider.of<Usecases>(context)
                          .peopleUsecases
                          .deletePeople(people);
                    },
                    key: Key(people.id.toString()),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PeopleEdit(
                                    people: people,
                                  )),
                        );
                      },
                      title: Text(people.name),
                      subtitle: Text(people.peopleType.toString()),
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
