import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../injection_container.dart';
import '../../../../shared/uri_configs.dart';
import '../../phone_navigator_uri_config_parsers.dart';
import '../phone_navigator_uri_config_parser_locator.dart';

@LazySingleton(as: PhoneNavigatorUriConfigParserLocator)
class PhoneNavigatorUriConfigParserLocatorImpl implements PhoneNavigatorUriConfigParserLocator {
  PhoneNavigatorUriConfigParserLocatorImpl();

  final _uriConfigTypeToParser = <Type, PhoneNavigatorUriConfigParser>{
    ShoppingListOverviewUriConfig: ShoppingListOverviewUriConfigParser(
      uuidGenerator: di(),
    ),
    ShoppingListItemAdditionUriConfig: ShoppingListItemAdditionUriConfigParser(
      uuidGenerator: di(),
    ),
  };

  @override
  PhoneNavigatorUriConfigParser getParserByUriConfig(UriConfig uriConfig) {
    return _uriConfigTypeToParser[uriConfig.runtimeType]!;
  }

  @override
  IList<PhoneNavigatorUriConfigParser> getAllParsers() {
    return IList<PhoneNavigatorUriConfigParser>(_uriConfigTypeToParser.values);
  }
}
