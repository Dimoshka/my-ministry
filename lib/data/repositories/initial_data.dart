import 'package:my_ministry/data/dto/dto.dart';
import 'package:my_ministry/data/repositories/repositories.dart';

class InitialData {
  final IDbRepository _dbRepository;

  InitialData(this._dbRepository);

  Future<void> init() async {
    await _addUserTypes();
    await _addPhoneTypes();
    await _addAddressTypes();
  }

  Future<void> _addUserTypes() async {
    final userTypes = <String>[
      'Unbaptized publisher',
      'Publisher',
      'Auxiliary pioneer',
      'Pioneer',
      'Fulltime ministry'
    ];

    await Future.forEach<String>(userTypes, (element) async {
      await _dbRepository.addUserType(UserType()..name = element);
    });
  }

  Future<void> _addPhoneTypes() async {
    final phoneTypes = <String>[
      'Mobile',
      'Home',
      'Work',
      'Etc',
    ];

    await Future.forEach<String>(phoneTypes, (element) async {
      await _dbRepository.addPhoneType(PhoneType()..name = element);
    });
  }

  Future<void> _addAddressTypes() async {
    final addressTypes = <String>[
      'Home',
      'Work',
      'Etc',
    ];

    await Future.forEach<String>(addressTypes, (element) async {
      await _dbRepository.addAddressType(AddressType()..name = element);
    });
  }
}
