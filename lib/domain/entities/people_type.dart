import 'package:equatable/equatable.dart';
import 'package:my_ministry/data/dto/dto.dart' as hive;

class PeopleType extends Equatable {
  PeopleType(this.id, this.name);

  PeopleType.fromHive(hive.PeopleType peopleTypeHive)
      : id = peopleTypeHive.key as int,
        name = peopleTypeHive.name;

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];

  @override
  bool get stringify => true;
}
