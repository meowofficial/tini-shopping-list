import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../../injection_container.dart';
import '../shared/uri_configs.dart';
import 'mobile_navigator_uri_config_parsers.dart';

abstract interface class MobileNavigatorUriConfigParserLocator {
  MobileNavigatorUriConfigParser getParserByUriConfig(UriConfig uriConfig);

  IList<MobileNavigatorUriConfigParser> getAllParsers();
}

@LazySingleton(as: MobileNavigatorUriConfigParserLocator)
class MobileNavigatorUriConfigParserLocatorImpl implements MobileNavigatorUriConfigParserLocator {
  MobileNavigatorUriConfigParserLocatorImpl();

  final _uriConfigTypeToParser = <Type, MobileNavigatorUriConfigParser>{
    ShoppingListOverviewUriConfig: ShoppingListOverviewUriConfigParser(
      uuidGenerator: di(),
    ),
    ShoppingListItemAdditionUriConfig: ShoppingListItemAdditionUriConfigParser(
      uuidGenerator: di(),
    ),
  };

  @override
  MobileNavigatorUriConfigParser getParserByUriConfig(UriConfig uriConfig) {
    return _uriConfigTypeToParser[uriConfig.runtimeType]!;
  }

  @override
  IList<MobileNavigatorUriConfigParser> getAllParsers() {
    return IList<MobileNavigatorUriConfigParser>(_uriConfigTypeToParser.values);
  }
}
