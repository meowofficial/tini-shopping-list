import 'package:injectable/injectable.dart';

import 'uri_configs.dart';

abstract interface class UriConfigHolder {
  UriConfig? get lastKnownUriConfig;

  set lastKnownUriConfig(UriConfig? value);
}

@LazySingleton(as: UriConfigHolder)
class UriConfigHolderImpl implements UriConfigHolder {
  UriConfigHolderImpl();

  @override
  UriConfig? lastKnownUriConfig;
}
