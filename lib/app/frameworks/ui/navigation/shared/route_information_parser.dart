import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../../interface_adapters/presentation/navigation/shared/uri_config_parser_locator.dart';
import '../../../../interface_adapters/presentation/navigation/shared/uri_configs.dart';

class AppRouteInformationParser extends RouteInformationParser<UriConfig> {
  const AppRouteInformationParser({
    required UriConfigParserLocator uriConfigParserLocator,
  }) : _uriConfigParserLocator = uriConfigParserLocator;

  final UriConfigParserLocator _uriConfigParserLocator;

  @override
  Future<UriConfig> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = routeInformation.uri;
    final parser = _uriConfigParserLocator.getParserByUri(uri);
    final uriConfig = parser?.tryParse(uri) ?? const ShoppingListOverviewUriConfig();
    return SynchronousFuture(uriConfig);
  }

  @override
  // ignore: avoid_renaming_method_parameters
  RouteInformation? restoreRouteInformation(UriConfig uriConfig) {
    final parser = _uriConfigParserLocator.getParserByUriConfig(uriConfig);
    final uri = parser.toUri(uriConfig);
    return RouteInformation(uri: uri);
  }
}
