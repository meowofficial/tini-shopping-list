import 'package:injectable/injectable.dart';

import 'uri_config_parsers.dart';
import 'uri_configs.dart';

abstract interface class UriConfigParserLocator {
  UriConfigParser getParserByUriConfig(UriConfig uriConfig);

  UriConfigParser? getParserByUri(Uri uri);
}

@LazySingleton(as: UriConfigParserLocator)
class UriConfigParserLocatorImpl implements UriConfigParserLocator {
  final _uriConfigTypeToParser = <Type, UriConfigParser>{
    ShoppingListOverviewUriConfig: const ShoppingListOverviewUriConfigParser(),
    ShoppingListItemAdditionUriConfig: const ShoppingListItemAdditionUriConfigParser(),
  };

  @override
  UriConfigParser getParserByUriConfig(UriConfig uriConfig) {
    return _uriConfigTypeToParser[uriConfig.runtimeType]!;
  }

  @override
  UriConfigParser? getParserByUri(Uri uri) {
    for (final parser in _uriConfigTypeToParser.values) {
      if (parser.tryParse(uri) != null) {
        return parser;
      }
    }

    return null;
  }
}
