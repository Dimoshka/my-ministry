import 'package:equatable/equatable.dart';
import 'package:my_ministry/data/dto/dto.dart' as hive;

import 'entities.dart';

class Phone extends Equatable {
  Phone(this.id, this.number, this.phoneType, this.note);

  Phone.empty()
      : id = null,
        number = null,
        phoneType = null,
        note = null;

  Phone.fromHive(hive.Phone phoneHive)
      : id = phoneHive.key as int,
        number = phoneHive.number,
        phoneType = PhoneType.fromHive(phoneHive.phoneType),
        note = phoneHive.note;

  Phone.clone(Phone phone,
      {String numberNew, PhoneType phoneTypeNew, String noteNew})
      : id = phone.id,
        number = numberNew ?? phone.number,
        phoneType = phoneTypeNew ?? phone.phoneType,
        note = noteNew ?? phone.note;

  final int id;
  final String number;
  final PhoneType phoneType;
  final String note;

  @override
  List<Object> get props => [id, number, phoneType, note];

  @override
  String toString() =>
      'Phone { id: $id, number: $number, phoneType: ${phoneType.toString()}, note: $note }';
}
