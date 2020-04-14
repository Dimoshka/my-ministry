import 'package:flutter/material.dart';
import 'package:my_ministry/domain/usecases/usecases.dart';
import 'package:my_ministry/presentation/ui/pages/users/users.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usecases = Usecases();
    return Provider(
      create: (_) => usecases,
      child: FutureBuilder(
        future: usecases.init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: Users(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
