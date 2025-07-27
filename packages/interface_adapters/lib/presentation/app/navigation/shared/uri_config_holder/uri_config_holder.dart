import '../uri_configs.dart';

abstract interface class UriConfigHolder {
  UriConfig? get lastKnownUriConfig;

  set lastKnownUriConfig(UriConfig? value);
}
