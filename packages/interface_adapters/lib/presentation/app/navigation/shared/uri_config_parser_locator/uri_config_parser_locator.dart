import '../uri_config_parsers.dart';
import '../uri_configs.dart';

abstract interface class UriConfigParserLocator {
  UriConfigParser getParserByUriConfig(UriConfig uriConfig);

  UriConfigParser? getParserByUri(Uri uri);
}
