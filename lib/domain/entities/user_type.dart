import 'package:equatable/equatable.dart';
import 'package:my_ministry/data/dto/dto.dart' as hive;

class UserType extends Equatable {
  UserType(this.id, this.name);

  UserType.fromHive(hive.UserType userTypeHive)
      : id = userTypeHive.key as int,
        name = userTypeHive.name;

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];

  @override
  String toString() => 'UserType { id: $id, name: $name }';
}
