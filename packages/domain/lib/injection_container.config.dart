// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:common/uuid_generator.dart' as _i707;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'shopping_list/factories/impl/shopping_list_item_factory_impl.dart'
    as _i949;
import 'shopping_list/factories/shopping_list_item_factory.dart' as _i61;
import 'shopping_list/validation/shopping_list_item_title_validator/impl/shopping_list_item_title_validator_impl.dart'
    as _i172;
import 'shopping_list/validation/shopping_list_item_title_validator/shopping_list_item_title_validator.dart'
    as _i2;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i2.ShoppingListItemTitleValidator>(
      () => const _i172.ShoppingListItemTitleValidatorImpl(),
    );
    gh.lazySingleton<_i61.ShoppingListItemFactory>(
      () => _i949.ShoppingListItemFactoryImpl(
        uuidGenerator: gh<_i707.UuidGenerator>(),
      ),
    );
    return this;
  }
}
