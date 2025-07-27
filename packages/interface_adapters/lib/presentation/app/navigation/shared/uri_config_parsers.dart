import 'uri_configs.dart';

sealed class UriConfigParser<T extends UriConfig> {
  T? tryParse(Uri uri);

  Uri? toUri(T uriConfig);
}

class ShoppingListOverviewUriConfigParser
    implements UriConfigParser<ShoppingListOverviewUriConfig> {
  const ShoppingListOverviewUriConfigParser();

  @override
  ShoppingListOverviewUriConfig? tryParse(Uri uri) {
    if (uri.pathSegments.isEmpty) {
      return const ShoppingListOverviewUriConfig();
    }

    return null;
  }

  @override
  Uri? toUri(ShoppingListOverviewUriConfig uriConfig) {
    return Uri.parse('/');
  }
}

class ShoppingListItemAdditionUriConfigParser
    implements UriConfigParser<ShoppingListItemAdditionUriConfig> {
  const ShoppingListItemAdditionUriConfigParser();

  @override
  ShoppingListItemAdditionUriConfig? tryParse(Uri uri) {
    if (uri.pathSegments.length == 1 && uri.pathSegments[0] == 'add') {
      return const ShoppingListItemAdditionUriConfig();
    }

    return null;
  }

  @override
  Uri? toUri(ShoppingListItemAdditionUriConfig uriConfig) {
    return Uri.parse('/add');
  }
}
