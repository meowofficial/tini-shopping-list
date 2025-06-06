import 'uri_config_parsers.dart';
import 'uri_configs.dart';

class UriConfigParserLocator {
  final _uriConfigTypeToParser = <Type, UriConfigParser>{
    ShoppingListOverviewUriConfig: const ShoppingListOverviewUriConfigParser(),
    ShoppingListItemAdditionUriConfig: const ShoppingListItemAdditionUriConfigParser(),
  };

  UriConfigParser getParserByUriConfig(UriConfig uriConfig) {
    return _uriConfigTypeToParser[uriConfig.runtimeType]!;
  }

  UriConfigParser? getParserByUri(Uri uri) {
    for (final parser in _uriConfigTypeToParser.values) {
      if (parser.tryParse(uri) != null) {
        return parser;
      }
    }

    return null;
  }
}
