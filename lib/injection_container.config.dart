// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'app/application/mappers/shopping_list_overview_flow_state_ref_mapper.dart'
    as _i879;
import 'app/application/stores/app_initialization_flow_store.dart' as _i355;
import 'app/application/use_cases/handle_app_launch.dart' as _i648;
import 'app/application/use_cases/initialize_stores.dart' as _i465;
import 'app/application/use_cases/read_app_initialization_flow_state.dart'
    as _i116;
import 'app/application/use_cases/watch_app_initialization_flow_state.dart'
    as _i440;
import 'app/interface_adapters/presentation/navigation/desktop/desktop_navigator_presenter.dart'
    as _i208;
import 'app/interface_adapters/presentation/navigation/desktop/desktop_navigator_uri_config_parser_locator.dart'
    as _i287;
import 'app/interface_adapters/presentation/navigation/mobile/mobile_navigator_presenter.dart'
    as _i153;
import 'app/interface_adapters/presentation/navigation/mobile/mobile_navigator_uri_config_parser_locator.dart'
    as _i573;
import 'app/interface_adapters/presentation/navigation/shared/uri_config_holder.dart'
    as _i78;
import 'app/interface_adapters/presentation/navigation/shared/uri_config_parser_locator.dart'
    as _i831;
import 'core/common/uuid/uuid_generator.dart' as _i540;
import 'core/interface_adapters/presentation/navigation/desktop/desktop_navigator.dart'
    as _i31;
import 'core/interface_adapters/presentation/navigation/mobile/mobile_navigator.dart'
    as _i482;
import 'features/shopping_list/application/mappers/shopping_list_item_addition_flow_state_ref_mapper.dart'
    as _i794;
import 'features/shopping_list/application/mappers/shopping_list_item_editing_flow_state_ref_mapper.dart'
    as _i28;
import 'features/shopping_list/application/mappers/shopping_list_overview_flow_state_ref_mapper.dart'
    as _i1061;
import 'features/shopping_list/application/repositories/shopping_list_repository.dart'
    as _i972;
import 'features/shopping_list/application/stores/shopping_list_flow_store.dart'
    as _i1019;
import 'features/shopping_list/application/use_cases/cancel_shopping_list_item_addition.dart'
    as _i625;
import 'features/shopping_list/application/use_cases/cancel_shopping_list_item_editing.dart'
    as _i300;
import 'features/shopping_list/application/use_cases/complete_shopping_list_item_addition.dart'
    as _i817;
import 'features/shopping_list/application/use_cases/complete_shopping_list_item_editing.dart'
    as _i1022;
import 'features/shopping_list/application/use_cases/load_shopping_list_items.dart'
    as _i614;
import 'features/shopping_list/application/use_cases/read_shopping_list_item_addition_flow_state.dart'
    as _i208;
import 'features/shopping_list/application/use_cases/read_shopping_list_overview_flow_state.dart'
    as _i536;
import 'features/shopping_list/application/use_cases/start_shopping_list_item_addition.dart'
    as _i323;
import 'features/shopping_list/application/use_cases/start_shopping_list_item_editing.dart'
    as _i844;
import 'features/shopping_list/application/use_cases/toggle_shopping_list_item_check.dart'
    as _i277;
import 'features/shopping_list/application/use_cases/update_existing_shopping_list_draft_item_title.dart'
    as _i693;
import 'features/shopping_list/application/use_cases/update_new_shopping_list_draft_item_title.dart'
    as _i820;
import 'features/shopping_list/application/use_cases/watch_shopping_list_item_addition_flow_state.dart'
    as _i342;
import 'features/shopping_list/application/use_cases/watch_shopping_list_item_editing_flow_state.dart'
    as _i763;
import 'features/shopping_list/application/use_cases/watch_shopping_list_overview_flow_state.dart'
    as _i669;
import 'features/shopping_list/domain/factories/shopping_list_item_factory.dart'
    as _i829;
import 'features/shopping_list/domain/validation/shopping_list_item/validator.dart'
    as _i1011;
import 'features/shopping_list/interface_adapters/presentation/desktop_shopping_list_overview_screen/interfaces/shopping_list_item_presenter_factory.dart'
    as _i127;
import 'features/shopping_list/interface_adapters/presentation/desktop_shopping_list_overview_screen/interfaces/shopping_list_overview_screen_state_presenter_factory.dart'
    as _i432;
import 'features/shopping_list/interface_adapters/presentation/desktop_shopping_list_overview_screen/presenters/shopping_list_item_presenter_factory.dart'
    as _i61;
import 'features/shopping_list/interface_adapters/presentation/desktop_shopping_list_overview_screen/presenters/shopping_list_overview_screen_state_presenter_factory.dart'
    as _i357;
import 'features/shopping_list/interface_adapters/repositories/shopping_list_repository.dart'
    as _i209;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i78.UriConfigHolder>(() => _i78.UriConfigHolderImpl());
    gh.lazySingleton<_i1011.ShoppingListItemTitleValidator>(
      () => const _i1011.ShoppingListItemTitleValidatorImpl(),
    );
    gh.lazySingleton<_i482.MobileNavigator>(() => _i482.MobileNavigatorImpl());
    gh.lazySingleton<_i127.ShoppingListItemPresenterFactory>(
      () => const _i61.ShoppingListItemPresenterFactoryImpl(),
    );
    gh.lazySingleton<_i28.ShoppingListItemEditingFlowStateRefMapper>(
      () => const _i28.ShoppingListItemEditingFlowStateRefMapperImpl(),
    );
    gh.lazySingleton<_i287.DesktopNavigatorUriConfigParserLocator>(
      () => _i287.DesktopNavigatorUriConfigParserLocatorImpl(),
    );
    gh.lazySingleton<_i1061.ShoppingListOverviewFlowStateRefMapper>(
      () => const _i1061.ShoppingListOverviewFlowStateRefMapperImpl(),
    );
    gh.lazySingleton<_i1019.ShoppingListFlowStore>(
      () => _i1019.ShoppingListFlowStoreImpl(),
    );
    gh.lazySingleton<_i31.DesktopNavigator>(
      () => _i31.DesktopNavigatorImpl(),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i573.MobileNavigatorUriConfigParserLocator>(
      () => _i573.MobileNavigatorUriConfigParserLocatorImpl(),
    );
    gh.lazySingleton<_i540.UuidGenerator>(
      () => const _i540.UuidGeneratorImpl(),
    );
    gh.lazySingleton<_i669.WatchShoppingListOverviewFlowState>(
      () => _i669.WatchShoppingListOverviewFlowStateImpl(
        shoppingListFlowStore: gh<_i1019.ShoppingListFlowStore>(),
        shoppingListOverviewFlowStateRefMapper:
            gh<_i1061.ShoppingListOverviewFlowStateRefMapper>(),
      ),
    );
    gh.lazySingleton<_i355.AppInitializationFlowStore>(
      () => _i355.AppInitializationFlowStoreImpl(),
    );
    gh.lazySingleton<_i972.ShoppingListRepository>(
      () => const _i209.ShoppingListRepositoryImpl(),
    );
    gh.lazySingleton<_i432.ShoppingListOverviewScreenStatePresenterFactory>(
      () => const _i357.ShoppingListOverviewScreenStatePresenterFactoryImpl(),
    );
    gh.lazySingleton<_i879.AppInitializationFlowStateRefMapper>(
      () => const _i879.AppInitializationFlowStateRefMapperImpl(),
    );
    gh.lazySingleton<_i831.UriConfigParserLocator>(
      () => _i831.UriConfigParserLocatorImpl(),
    );
    gh.lazySingleton<_i794.ShoppingListItemAdditionFlowStateRefMapper>(
      () => const _i794.ShoppingListItemAdditionFlowStateRefMapperImpl(),
    );
    gh.lazySingleton<_i844.StartShoppingListItemEditing>(
      () => _i844.StartShoppingListItemEditingImpl(
        shoppingListItemTitleValidator:
            gh<_i1011.ShoppingListItemTitleValidator>(),
        shoppingListFlowStore: gh<_i1019.ShoppingListFlowStore>(),
      ),
    );
    gh.lazySingleton<_i465.InitializeStores>(
      () => _i465.InitializeStoresImpl(
        appInitializationFlowStore: gh<_i355.AppInitializationFlowStore>(),
        shoppingListFlowStore: gh<_i1019.ShoppingListFlowStore>(),
      ),
    );
    gh.lazySingleton<_i829.ShoppingListItemFactory>(
      () => _i829.ShoppingListItemFactoryImpl(
        uuidGenerator: gh<_i540.UuidGenerator>(),
      ),
    );
    gh.lazySingleton<_i208.ReadShoppingListItemAdditionFlowState>(
      () => _i208.ReadShoppingListItemAdditionFlowStateImpl(
        shoppingListFlowStore: gh<_i1019.ShoppingListFlowStore>(),
        shoppingListItemAdditionFlowStateRefMapper:
            gh<_i794.ShoppingListItemAdditionFlowStateRefMapper>(),
      ),
    );
    gh.lazySingleton<_i820.UpdateNewShoppingListDraftItemTitle>(
      () => _i820.UpdateNewShoppingListDraftItemTitleImpl(
        shoppingListItemTitleValidator:
            gh<_i1011.ShoppingListItemTitleValidator>(),
        shoppingListFlowStore: gh<_i1019.ShoppingListFlowStore>(),
      ),
    );
    gh.lazySingleton<_i625.CancelShoppingListItemAddition>(
      () => _i625.CancelShoppingListItemAdditionImpl(
        shoppingListFlowStore: gh<_i1019.ShoppingListFlowStore>(),
      ),
    );
    gh.lazySingleton<_i1022.CompleteShoppingListItemEditing>(
      () => _i1022.CompleteShoppingListItemEditingImpl(
        shoppingListFlowStore: gh<_i1019.ShoppingListFlowStore>(),
      ),
    );
    gh.lazySingleton<_i300.CancelShoppingListItemEditing>(
      () => _i300.CancelShoppingListItemEditingImpl(
        shoppingListFlowStore: gh<_i1019.ShoppingListFlowStore>(),
      ),
    );
    gh.lazySingleton<_i763.WatchShoppingListItemEditingFlowState>(
      () => _i763.WatchShoppingListItemEditingFlowStateImpl(
        shoppingListFlowStore: gh<_i1019.ShoppingListFlowStore>(),
        shoppingListItemEditingFlowStateRefMapper:
            gh<_i28.ShoppingListItemEditingFlowStateRefMapper>(),
      ),
    );
    gh.lazySingleton<_i440.WatchAppInitializationFlowState>(
      () => _i440.WatchAppInitializationFlowStateImpl(
        appInitializationFlowStore: gh<_i355.AppInitializationFlowStore>(),
        appInitializationFlowStateRefMapper:
            gh<_i879.AppInitializationFlowStateRefMapper>(),
      ),
    );
    gh.lazySingleton<_i116.ReadAppInitializationFlowState>(
      () => _i116.ReadAppInitializationFlowStateImpl(
        appInitializationFlowStore: gh<_i355.AppInitializationFlowStore>(),
        appInitializationFlowStateRefMapper:
            gh<_i879.AppInitializationFlowStateRefMapper>(),
      ),
    );
    gh.lazySingleton<_i277.ToggleShoppingListItemCheck>(
      () => _i277.ToggleShoppingListItemCheckImpl(
        shoppingListFlowStore: gh<_i1019.ShoppingListFlowStore>(),
      ),
    );
    gh.lazySingleton<_i342.WatchShoppingListItemAdditionFlowState>(
      () => _i342.WatchShoppingListItemAdditionFlowStateImpl(
        shoppingListFlowStore: gh<_i1019.ShoppingListFlowStore>(),
        shoppingListItemAdditionFlowStateRefMapper:
            gh<_i794.ShoppingListItemAdditionFlowStateRefMapper>(),
      ),
    );
    gh.lazySingleton<_i323.StartShoppingListItemAddition>(
      () => _i323.StartShoppingListItemAdditionImpl(
        shoppingListItemTitleValidator:
            gh<_i1011.ShoppingListItemTitleValidator>(),
        shoppingListFlowStore: gh<_i1019.ShoppingListFlowStore>(),
      ),
    );
    gh.lazySingleton<_i536.ReadShoppingListOverviewFlowState>(
      () => _i536.ReadShoppingListOverviewFlowStateImpl(
        shoppingListFlowStore: gh<_i1019.ShoppingListFlowStore>(),
        shoppingListOverviewFlowStateRefMapper:
            gh<_i1061.ShoppingListOverviewFlowStateRefMapper>(),
      ),
    );
    gh.lazySingleton<_i693.UpdateExistingShoppingListDraftItemTitle>(
      () => _i693.UpdateExistingShoppingListDraftItemTitleImpl(
        shoppingListItemTitleValidator:
            gh<_i1011.ShoppingListItemTitleValidator>(),
        shoppingListFlowStore: gh<_i1019.ShoppingListFlowStore>(),
      ),
    );
    gh.lazySingleton<_i153.MobileNavigatorPresenter>(
      () => _i153.MobileNavigatorPresenterImpl(
        mobileNavigator: gh<_i482.MobileNavigator>(),
        mobileNavigatorUriConfigParserLocator:
            gh<_i573.MobileNavigatorUriConfigParserLocator>(),
        uriConfigHolder: gh<_i78.UriConfigHolder>(),
        uuidGenerator: gh<_i540.UuidGenerator>(),
        cancelShoppingListItemAddition:
            gh<_i625.CancelShoppingListItemAddition>(),
        readAppInitializationFlowState:
            gh<_i116.ReadAppInitializationFlowState>(),
        readShoppingListItemAdditionFlowState:
            gh<_i208.ReadShoppingListItemAdditionFlowState>(),
        startShoppingListItemAddition:
            gh<_i323.StartShoppingListItemAddition>(),
        watchAppInitializationFlowState:
            gh<_i440.WatchAppInitializationFlowState>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i614.LoadShoppingListItems>(
      () => _i614.LoadShoppingListItemsImpl(
        shoppingListFlowStore: gh<_i1019.ShoppingListFlowStore>(),
        shoppingListRepository: gh<_i972.ShoppingListRepository>(),
      ),
    );
    gh.lazySingleton<_i648.HandleAppLaunch>(
      () => _i648.HandleAppLaunchImpl(
        appInitializationFlowStore: gh<_i355.AppInitializationFlowStore>(),
      ),
    );
    gh.lazySingleton<_i817.CompleteShoppingListItemAddition>(
      () => _i817.CompleteShoppingListItemAdditionImpl(
        shoppingListItemFactory: gh<_i829.ShoppingListItemFactory>(),
        shoppingListFlowStore: gh<_i1019.ShoppingListFlowStore>(),
      ),
    );
    gh.lazySingleton<_i208.DesktopNavigatorPresenter>(
      () => _i208.DesktopNavigatorPresenterImpl(
        navigator: gh<_i31.DesktopNavigator>(),
        navigatorUriConfigParserLocator:
            gh<_i287.DesktopNavigatorUriConfigParserLocator>(),
        uriConfigHolder: gh<_i78.UriConfigHolder>(),
        uuidGenerator: gh<_i540.UuidGenerator>(),
        cancelShoppingListItemAddition:
            gh<_i625.CancelShoppingListItemAddition>(),
        readAppInitializationFlowState:
            gh<_i116.ReadAppInitializationFlowState>(),
        readShoppingListItemAdditionFlowState:
            gh<_i208.ReadShoppingListItemAdditionFlowState>(),
        startShoppingListItemAddition:
            gh<_i323.StartShoppingListItemAddition>(),
        watchAppInitializationFlowState:
            gh<_i440.WatchAppInitializationFlowState>(),
        watchShoppingListItemAdditionFlowState:
            gh<_i342.WatchShoppingListItemAdditionFlowState>(),
      ),
      dispose: (i) => i.dispose(),
    );
    return this;
  }
}
