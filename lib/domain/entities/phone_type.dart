import 'package:equatable/equatable.dart';
import 'package:my_ministry/data/dto/dto.dart' as hive;

class PhoneType extends Equatable {
  PhoneType(this.id, this.name);

  PhoneType.fromHive(hive.PhoneType phoneTypeHive)
      : id = phoneTypeHive.key as int,
        name = phoneTypeHive.name;

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];

  @override
  String toString() => 'PhoneType { id: $id, name: $name }';
}
