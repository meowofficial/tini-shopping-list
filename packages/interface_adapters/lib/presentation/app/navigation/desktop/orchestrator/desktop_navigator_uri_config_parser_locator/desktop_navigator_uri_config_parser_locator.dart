import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../shared/uri_configs.dart';
import '../desktop_navigator_uri_config_parsers.dart';

abstract interface class DesktopNavigatorUriConfigParserLocator {
  DesktopNavigatorUriConfigParser getParserByUriConfig(UriConfig uriConfig);

  IList<DesktopNavigatorUriConfigParser> getAllParsers();
}
