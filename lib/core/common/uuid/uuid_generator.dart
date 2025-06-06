import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

abstract interface class UuidGenerator {
  String generateUuid();
}

@LazySingleton(as: UuidGenerator)
class UuidGeneratorImpl implements UuidGenerator {
  const UuidGeneratorImpl() : _uuid = const Uuid();

  final Uuid _uuid;

  @override
  String generateUuid() {
    return _uuid.v4();
  }
}
