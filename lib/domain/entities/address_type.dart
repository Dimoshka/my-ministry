import 'package:equatable/equatable.dart';
import 'package:my_ministry/data/dto/dto.dart' as hive;

class AddressType extends Equatable {
  AddressType(this.id, this.name);

  AddressType.fromHive(hive.AddressType addressTypeHive)
      : id = addressTypeHive.key as int,
        name = addressTypeHive.name;

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];

  @override
  bool get stringify => true;
}
