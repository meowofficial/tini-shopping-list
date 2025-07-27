// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:application/app/use_cases/read_app_initialization_flow_state/read_app_initialization_flow_state.dart'
    as _i896;
import 'package:application/app/use_cases/watch_app_initialization_flow_state/watch_app_initialization_flow_state.dart'
    as _i533;
import 'package:application/core/use_cases/read_ui_locale/read_ui_locale.dart'
    as _i174;
import 'package:application/core/use_cases/watch_ui_locale/watch_ui_locale.dart'
    as _i613;
import 'package:application/shopping_list/repositories/local/shopping_list_local_repository/shopping_list_local_repository.dart'
    as _i176;
import 'package:application/shopping_list/use_cases/read_shopping_list_item_addition_flow_state/read_shopping_list_item_addition_flow_state.dart'
    as _i481;
import 'package:application/shopping_list/use_cases/read_shopping_list_overview_flow_state/read_shopping_list_overview_flow_state.dart'
    as _i139;
import 'package:application/shopping_list/use_cases/start_shopping_list_item_addition/start_shopping_list_item_addition.dart'
    as _i791;
import 'package:application/shopping_list/use_cases/stop_shopping_list_item_addition/stop_shopping_list_item_addition.dart'
    as _i585;
import 'package:application/shopping_list/use_cases/submit_new_shopping_list_item_draft/submit_new_shopping_list_item_draft.dart'
    as _i481;
import 'package:application/shopping_list/use_cases/suspend_shopping_list_item_addition/suspend_shopping_list_item_addition.dart'
    as _i737;
import 'package:application/shopping_list/use_cases/toggle_shopping_list_item_check/toggle_shopping_list_item_check.dart'
    as _i90;
import 'package:application/shopping_list/use_cases/update_new_shopping_list_draft_item_title/update_new_shopping_list_draft_item_title.dart'
    as _i743;
import 'package:application/shopping_list/use_cases/watch_shopping_list_item_addition_flow_state/watch_shopping_list_item_addition_flow_state.dart'
    as _i1014;
import 'package:application/shopping_list/use_cases/watch_shopping_list_overview_flow_state/watch_shopping_list_overview_flow_state.dart'
    as _i254;
import 'package:common/uuid_generator.dart' as _i707;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'presentation/app/navigation/desktop/orchestrator/desktop_navigator_orchestrator/desktop_navigator_orchestrator.dart'
    as _i136;
import 'presentation/app/navigation/desktop/orchestrator/desktop_navigator_orchestrator/impl/desktop_navigator_orchestrator_impl.dart'
    as _i294;
import 'presentation/app/navigation/desktop/orchestrator/desktop_navigator_uri_config_parser_locator/desktop_navigator_uri_config_parser_locator.dart'
    as _i66;
import 'presentation/app/navigation/desktop/orchestrator/desktop_navigator_uri_config_parser_locator/impl/desktop_navigator_uri_config_parser_locator_impl.dart'
    as _i948;
import 'presentation/app/navigation/phone/orchestrator/phone_navigation_orchestrator/impl/phone_navigation_orchestrator_impl.dart'
    as _i1036;
import 'presentation/app/navigation/phone/orchestrator/phone_navigation_orchestrator/phone_navigation_orchestrator.dart'
    as _i102;
import 'presentation/app/navigation/phone/orchestrator/phone_navigator_uri_config_parser_locator/impl/phone_navigator_uri_config_parser_locator_impl.dart'
    as _i618;
import 'presentation/app/navigation/phone/orchestrator/phone_navigator_uri_config_parser_locator/phone_navigator_uri_config_parser_locator.dart'
    as _i360;
import 'presentation/app/navigation/shared/uri_config_holder/impl/uri_config_holder_impl.dart'
    as _i580;
import 'presentation/app/navigation/shared/uri_config_holder/uri_config_holder.dart'
    as _i608;
import 'presentation/app/navigation/shared/uri_config_parser_locator/impl/uri_config_parser_locator.dart'
    as _i103;
import 'presentation/app/navigation/shared/uri_config_parser_locator/uri_config_parser_locator.dart'
    as _i492;
import 'presentation/app/phone_home_shell_screen/l10n/impl/phone_home_shell_screen_view_translation_impl.dart'
    as _i554;
import 'presentation/app/phone_home_shell_screen/l10n/phone_home_shell_screen_view_translation.dart'
    as _i575;
import 'presentation/core/navigation/desktop/navigator/desktop_navigator.dart'
    as _i373;
import 'presentation/core/navigation/desktop/navigator/impl/desktop_navigator_impl.dart'
    as _i814;
import 'presentation/core/navigation/phone/navigator/impl/phone_navigator_impl.dart'
    as _i373;
import 'presentation/core/navigation/phone/navigator/phone_navigator.dart'
    as _i806;
import 'presentation/desktop_shopping_list_item_addition_screen/screen/l10n/shopping_list_item_addition_screen_view_translation/impl/shopping_list_item_addition_screen_view_translation_impl.dart'
    as _i843;
import 'presentation/desktop_shopping_list_item_addition_screen/screen/l10n/shopping_list_item_addition_screen_view_translation/shopping_list_item_addition_screen_view_translation.dart'
    as _i1006;
import 'presentation/desktop_shopping_list_overview_screen/screen/factories/shopping_list_overview_screen_state_presenter_factory/impl/shopping_list_overview_screen_state_presenter_factory_impl.dart'
    as _i768;
import 'presentation/desktop_shopping_list_overview_screen/screen/factories/shopping_list_overview_screen_state_presenter_factory/shopping_list_overview_screen_state_presenter_factory.dart'
    as _i963;
import 'presentation/desktop_shopping_list_overview_screen/screen/l10n/shopping_list_overview_screen_loaded_state_view_translation/impl/shopping_list_overview_screen_loaded_state_view_translation_impl.dart'
    as _i493;
import 'presentation/desktop_shopping_list_overview_screen/screen/l10n/shopping_list_overview_screen_loaded_state_view_translation/shopping_list_overview_screen_loaded_state_view_translation.dart'
    as _i674;
import 'presentation/desktop_shopping_list_overview_screen/screen/l10n/shopping_list_overview_screen_loading_state_view_translation/impl/shopping_list_overview_screen_loading_state_view_translation_impl.dart'
    as _i1011;
import 'presentation/desktop_shopping_list_overview_screen/screen/l10n/shopping_list_overview_screen_loading_state_view_translation/shopping_list_overview_screen_loading_state_view_translation.dart'
    as _i958;
import 'presentation/desktop_shopping_list_overview_screen/shopping_list_item/factories/shopping_list_item_presenter_factory/impl/shopping_list_item_presenter_factory_impl.dart'
    as _i503;
import 'presentation/desktop_shopping_list_overview_screen/shopping_list_item/factories/shopping_list_item_presenter_factory/shopping_list_item_presenter_factory.dart'
    as _i56;
import 'presentation/desktop_shopping_list_overview_screen/shopping_list_item/l10n/shopping_list_item_addition_screen_view_translation/impl/shopping_list_item_addition_screen_view_translation_impl.dart'
    as _i869;
import 'presentation/desktop_shopping_list_overview_screen/shopping_list_item/l10n/shopping_list_item_addition_screen_view_translation/shopping_list_item_addition_screen_view_translation.dart'
    as _i1059;
import 'presentation/phone_shopping_list_item_addition_screen/screen/factories/shopping_list_item_addition_screen_state_presenter_factory/impl/shopping_list_item_addition_screen_state_presenter_factory_impl.dart'
    as _i666;
import 'presentation/phone_shopping_list_item_addition_screen/screen/factories/shopping_list_item_addition_screen_state_presenter_factory/shopping_list_item_addition_screen_state_presenter_factory.dart'
    as _i829;
import 'presentation/phone_shopping_list_item_addition_screen/screen/l10n/shopping_list_item_addition_screen_view_translation/impl/shopping_list_item_addition_screen_view_translation_impl.dart'
    as _i460;
import 'presentation/phone_shopping_list_item_addition_screen/screen/l10n/shopping_list_item_addition_screen_view_translation/shopping_list_item_addition_screen_view_translation.dart'
    as _i1063;
import 'presentation/phone_shopping_list_overview_screen/screen/factories/shopping_list_item_presenter_factory/impl/shopping_list_item_presenter_factory_impl.dart'
    as _i945;
import 'presentation/phone_shopping_list_overview_screen/screen/factories/shopping_list_item_presenter_factory/shopping_list_item_presenter_factory.dart'
    as _i743;
import 'presentation/phone_shopping_list_overview_screen/screen/factories/shopping_list_overview_screen_state_presenter_factory/impl/shopping_list_overview_screen_state_presenter_factory_impl.dart'
    as _i928;
import 'presentation/phone_shopping_list_overview_screen/screen/factories/shopping_list_overview_screen_state_presenter_factory/shopping_list_overview_screen_state_presenter_factory.dart'
    as _i987;
import 'presentation/phone_shopping_list_overview_screen/screen/l10n/shopping_list_overview_screen_loaded_state_view_translation/impl/shopping_list_overview_screen_loaded_state_view_translation_impl.dart'
    as _i872;
import 'presentation/phone_shopping_list_overview_screen/screen/l10n/shopping_list_overview_screen_loaded_state_view_translation/shopping_list_overview_screen_loaded_state_view_translation.dart'
    as _i82;
import 'presentation/phone_shopping_list_overview_screen/screen/l10n/shopping_list_overview_screen_loading_state_view_translation/impl/shopping_list_overview_screen_loading_state_view_translation_impl.dart'
    as _i73;
import 'presentation/phone_shopping_list_overview_screen/screen/l10n/shopping_list_overview_screen_loading_state_view_translation/shopping_list_overview_screen_loading_state_view_translation.dart'
    as _i804;
import 'repositories/shopping_list_repository/shopping_list_repository_impl.dart'
    as _i941;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<
      _i958.ShoppingListOverviewScreenLoadingStateViewTranslation
    >(() => _i1011.ShoppingListOverviewScreenLoadingStateViewTranslationImpl());
    gh.lazySingleton<
      _i1063.ShoppingListItemAdditionScreenReadyStateViewTranslation
    >(
      () => _i460.ShoppingListItemAdditionScreenReadyStateViewTranslationImpl(),
    );
    gh.lazySingleton<_i1059.ShoppingListItemAdditionScreenViewTranslation>(
      () => _i869.ShoppingListItemAdditionScreenViewTranslationImpl(),
    );
    gh.lazySingleton<_i360.PhoneNavigatorUriConfigParserLocator>(
      () => _i618.PhoneNavigatorUriConfigParserLocatorImpl(),
    );
    gh.lazySingleton<_i575.PhoneHomeShellScreenViewTranslation>(
      () => _i554.PhoneHomeShellScreenViewTranslationImpl(),
    );
    gh.lazySingleton<_i492.UriConfigParserLocator>(
      () => _i103.UriConfigParserLocatorImpl(),
    );
    gh.lazySingleton<
      _i804.ShoppingListOverviewScreenLoadingStateViewTranslation
    >(() => _i73.ShoppingListOverviewScreenLoadingStateViewTranslationImpl());
    gh.lazySingleton<_i82.ShoppingListOverviewScreenLoadedStateViewTranslation>(
      () => _i872.ShoppingListOverviewScreenLoadedStateViewTranslationImpl(),
    );
    gh.lazySingleton<_i829.ShoppingListItemAdditionScreenStatePresenterFactory>(
      () => _i666.ShoppingListItemAdditionScreenStatePresenterFactoryImpl(
        readShoppingListItemAdditionFlowState:
            gh<_i481.ReadShoppingListItemAdditionFlowState>(),
        readUiLocale: gh<_i174.ReadUiLocale>(),
        shoppingListItemAdditionScreenReadyStateViewTranslation:
            gh<
              _i1063.ShoppingListItemAdditionScreenReadyStateViewTranslation
            >(),
        submitNewShoppingListItemDraft:
            gh<_i481.SubmitNewShoppingListItemDraft>(),
        updateNewShoppingListDraftItemTitle:
            gh<_i743.UpdateNewShoppingListDraftItemTitle>(),
        watchShoppingListItemAdditionFlowState:
            gh<_i1014.WatchShoppingListItemAdditionFlowState>(),
        watchUiLocale: gh<_i613.WatchUiLocale>(),
      ),
    );
    gh.lazySingleton<_i373.DesktopNavigator>(
      () => _i814.DesktopNavigatorImpl(),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i176.ShoppingListLocalRepository>(
      () => const _i941.ShoppingListLocalRepositoryImpl(),
    );
    gh.lazySingleton<_i66.DesktopNavigatorUriConfigParserLocator>(
      () => _i948.DesktopNavigatorUriConfigParserLocatorImpl(),
    );
    gh.lazySingleton<
      _i674.ShoppingListOverviewScreenLoadedStateViewTranslation
    >(() => _i493.ShoppingListOverviewScreenLoadedStateViewTranslationImpl());
    gh.lazySingleton<_i608.UriConfigHolder>(() => _i580.UriConfigHolderImpl());
    gh.lazySingleton<_i1006.ShoppingListItemAdditionScreenViewTranslation>(
      () => _i843.ShoppingListItemAdditionScreenViewTranslationImpl(),
    );
    gh.lazySingleton<_i806.PhoneNavigator>(() => _i373.PhoneNavigatorImpl());
    gh.lazySingleton<_i102.PhoneNavigationOrchestrator>(
      () => _i1036.PhoneNavigationOrchestratorImpl(
        phoneNavigator: gh<_i806.PhoneNavigator>(),
        phoneNavigatorUriConfigParserLocator:
            gh<_i360.PhoneNavigatorUriConfigParserLocator>(),
        uriConfigHolder: gh<_i608.UriConfigHolder>(),
        uuidGenerator: gh<_i707.UuidGenerator>(),
        suspendShoppingListItemAddition:
            gh<_i737.SuspendShoppingListItemAddition>(),
        readAppInitializationFlowState:
            gh<_i896.ReadAppInitializationFlowState>(),
        readShoppingListItemAdditionFlowState:
            gh<_i481.ReadShoppingListItemAdditionFlowState>(),
        startShoppingListItemAddition:
            gh<_i791.StartShoppingListItemAddition>(),
        watchAppInitializationFlowState:
            gh<_i533.WatchAppInitializationFlowState>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i743.ShoppingListItemPresenterFactory>(
      () => _i945.ShoppingListItemPresenterFactoryImpl(
        toggleShoppingListItemCheck: gh<_i90.ToggleShoppingListItemCheck>(),
      ),
    );
    gh.lazySingleton<_i56.ShoppingListItemPresenterFactory>(
      () => _i503.ShoppingListItemPresenterFactoryImpl(
        toggleShoppingListItemCheck: gh<_i90.ToggleShoppingListItemCheck>(),
      ),
    );
    gh.lazySingleton<_i136.DesktopNavigationOrchestrator>(
      () => _i294.DesktopNavigationOrchestratorImpl(
        navigator: gh<_i373.DesktopNavigator>(),
        navigatorUriConfigParserLocator:
            gh<_i66.DesktopNavigatorUriConfigParserLocator>(),
        uriConfigHolder: gh<_i608.UriConfigHolder>(),
        uuidGenerator: gh<_i707.UuidGenerator>(),
        stopShoppingListItemAddition: gh<_i585.StopShoppingListItemAddition>(),
        readAppInitializationFlowState:
            gh<_i896.ReadAppInitializationFlowState>(),
        readShoppingListItemAdditionFlowState:
            gh<_i481.ReadShoppingListItemAdditionFlowState>(),
        startShoppingListItemAddition:
            gh<_i791.StartShoppingListItemAddition>(),
        watchAppInitializationFlowState:
            gh<_i533.WatchAppInitializationFlowState>(),
        watchShoppingListItemAdditionFlowState:
            gh<_i1014.WatchShoppingListItemAdditionFlowState>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i963.ShoppingListOverviewScreenStatePresenterFactory>(
      () => _i768.ShoppingListOverviewScreenStatePresenterFactoryImpl(
        shoppingListOverviewScreenLoadedStateViewTranslation:
            gh<_i674.ShoppingListOverviewScreenLoadedStateViewTranslation>(),
        shoppingListOverviewScreenLoadingStateViewTranslation:
            gh<_i958.ShoppingListOverviewScreenLoadingStateViewTranslation>(),
        readShoppingListOverviewFlowState:
            gh<_i139.ReadShoppingListOverviewFlowState>(),
        readUiLocale: gh<_i174.ReadUiLocale>(),
        shoppingListItemPresenterFactory:
            gh<_i56.ShoppingListItemPresenterFactory>(),
        watchShoppingListOverviewFlowState:
            gh<_i254.WatchShoppingListOverviewFlowState>(),
        watchUiLocale: gh<_i613.WatchUiLocale>(),
        startShoppingListItemAddition:
            gh<_i791.StartShoppingListItemAddition>(),
      ),
    );
    gh.lazySingleton<_i987.ShoppingListOverviewScreenStatePresenterFactory>(
      () => _i928.ShoppingListOverviewScreenStatePresenterFactoryImpl(
        readShoppingListOverviewFlowState:
            gh<_i139.ReadShoppingListOverviewFlowState>(),
        readUiLocale: gh<_i174.ReadUiLocale>(),
        shoppingListItemPresenterFactory:
            gh<_i743.ShoppingListItemPresenterFactory>(),
        shoppingListOverviewScreenLoadedStateViewTranslation:
            gh<_i82.ShoppingListOverviewScreenLoadedStateViewTranslation>(),
        shoppingListOverviewScreenLoadingStateViewTranslation:
            gh<_i804.ShoppingListOverviewScreenLoadingStateViewTranslation>(),
        watchShoppingListOverviewFlowState:
            gh<_i254.WatchShoppingListOverviewFlowState>(),
        watchUiLocale: gh<_i613.WatchUiLocale>(),
      ),
    );
    return this;
  }
}
