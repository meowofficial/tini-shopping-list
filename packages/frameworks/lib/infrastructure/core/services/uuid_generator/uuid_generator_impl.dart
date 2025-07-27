import 'package:common/uuid_generator.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: UuidGenerator)
class UuidGeneratorImpl implements UuidGenerator {
  const UuidGeneratorImpl();

  Uuid get _uuid => const Uuid();

  @override
  String generateUuid() {
    return _uuid.v4();
  }
}
