import 'package:injectable/injectable.dart';

import '../../uri_configs.dart';
import '../uri_config_holder.dart';

@LazySingleton(as: UriConfigHolder)
class UriConfigHolderImpl implements UriConfigHolder {
  UriConfigHolderImpl();

  @override
  UriConfig? lastKnownUriConfig;
}
