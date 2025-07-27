import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../shared/uri_configs.dart';
import '../phone_navigator_uri_config_parsers.dart';

abstract interface class PhoneNavigatorUriConfigParserLocator {
  PhoneNavigatorUriConfigParser getParserByUriConfig(UriConfig uriConfig);

  IList<PhoneNavigatorUriConfigParser> getAllParsers();
}
