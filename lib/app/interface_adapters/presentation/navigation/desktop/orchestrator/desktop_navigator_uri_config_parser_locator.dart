import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../injection_container.dart';
import '../../shared/uri_configs.dart';
import 'desktop_navigator_uri_config_parsers.dart';

abstract interface class DesktopNavigatorUriConfigParserLocator {
  DesktopNavigatorUriConfigParser getParserByUriConfig(UriConfig uriConfig);

  IList<DesktopNavigatorUriConfigParser> getAllParsers();
}

@LazySingleton(as: DesktopNavigatorUriConfigParserLocator)
class DesktopNavigatorUriConfigParserLocatorImpl implements DesktopNavigatorUriConfigParserLocator {
  DesktopNavigatorUriConfigParserLocatorImpl();

  final _uriConfigTypeToParser = <Type, DesktopNavigatorUriConfigParser>{
    ShoppingListOverviewUriConfig: ShoppingListOverviewUriConfigParser(
      uuidGenerator: di(),
    ),
    ShoppingListItemAdditionUriConfig: ShoppingListItemAdditionUriConfigParser(
      uuidGenerator: di(),
    ),
  };

  @override
  DesktopNavigatorUriConfigParser getParserByUriConfig(UriConfig uriConfig) {
    return _uriConfigTypeToParser[uriConfig.runtimeType]!;
  }

  @override
  IList<DesktopNavigatorUriConfigParser> getAllParsers() {
    return IList<DesktopNavigatorUriConfigParser>(_uriConfigTypeToParser.values);
  }
}
