// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/shopping_list/factories/shopping_list_item_factory.dart'
    as _i463;
import 'package:domain/shopping_list/validation/shopping_list_item_title_validator/shopping_list_item_title_validator.dart'
    as _i364;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'app/stores/app_initialization_flow_store/app_initialization_flow_store.dart'
    as _i437;
import 'app/stores/app_initialization_flow_store/impl/app_initialization_flow_store_impl.dart'
    as _i561;
import 'app/use_cases/handle_app_launch/handle_app_launch.dart' as _i395;
import 'app/use_cases/handle_app_launch/impl/handle_app_launch_impl.dart'
    as _i57;
import 'app/use_cases/initialize_app_initialization_flow_store/impl/initialize_app_initialization_flow_store_impl.dart'
    as _i881;
import 'app/use_cases/initialize_app_initialization_flow_store/initialize_app_initialization_flow_store.dart'
    as _i470;
import 'app/use_cases/read_app_initialization_flow_state/impl/read_app_initialization_flow_state_impl.dart'
    as _i787;
import 'app/use_cases/read_app_initialization_flow_state/read_app_initialization_flow_state.dart'
    as _i207;
import 'app/use_cases/shared/factories/app_initialization_flow_state_ref_factory/app_initialization_flow_state_ref_factory.dart'
    as _i867;
import 'app/use_cases/shared/factories/app_initialization_flow_state_ref_factory/impl/app_initialization_flow_state_ref_factory_impl.dart'
    as _i403;
import 'app/use_cases/watch_app_initialization_flow_state/impl/watch_app_initialization_flow_state_impl.dart'
    as _i147;
import 'app/use_cases/watch_app_initialization_flow_state/watch_app_initialization_flow_state.dart'
    as _i390;
import 'core/stores/ui_locale_store/impl/ui_locale_store_impl.dart' as _i123;
import 'core/stores/ui_locale_store/ui_locale_store.dart' as _i905;
import 'core/use_cases/read_ui_locale/impl/read_ui_locale_impl.dart' as _i991;
import 'core/use_cases/read_ui_locale/read_ui_locale.dart' as _i751;
import 'core/use_cases/shared/factories/ui_locale_output_dto_factory/impl/ui_locale_output_dto_factory_impl.dart'
    as _i224;
import 'core/use_cases/shared/factories/ui_locale_output_dto_factory/ui_locale_output_dto_factory.dart'
    as _i706;
import 'core/use_cases/watch_ui_locale/impl/watch_ui_locale_impl.dart' as _i275;
import 'core/use_cases/watch_ui_locale/watch_ui_locale.dart' as _i1035;
import 'shopping_list/repositories/local/shopping_list_local_repository/factories/shopping_list_item_local_dto_factory/impl/shopping_list_item_local_dto_factory_impl.dart'
    as _i390;
import 'shopping_list/repositories/local/shopping_list_local_repository/factories/shopping_list_item_local_dto_factory/shopping_list_item_local_dto_factory.dart'
    as _i37;
import 'shopping_list/repositories/local/shopping_list_local_repository/shopping_list_local_repository.dart'
    as _i747;
import 'shopping_list/stores/shopping_list_flow_store/impl/shopping_list_flow_store_impl.dart'
    as _i1027;
import 'shopping_list/stores/shopping_list_flow_store/shopping_list_flow_store.dart'
    as _i518;
import 'shopping_list/use_cases/cancel_shopping_list_item_editing/cancel_shopping_list_item_editing.dart'
    as _i27;
import 'shopping_list/use_cases/cancel_shopping_list_item_editing/impl/cancel_shopping_list_item_editing_impl.dart'
    as _i171;
import 'shopping_list/use_cases/complete_shopping_list_item_editing/complete_shopping_list_item_editing.dart'
    as _i581;
import 'shopping_list/use_cases/complete_shopping_list_item_editing/impl/complete_shopping_list_item_editing_impl.dart'
    as _i751;
import 'shopping_list/use_cases/load_shopping_list_items/impl/load_shopping_list_items_impl.dart'
    as _i615;
import 'shopping_list/use_cases/load_shopping_list_items/load_shopping_list_items.dart'
    as _i628;
import 'shopping_list/use_cases/read_shopping_list_item_addition_flow_state/impl/read_shopping_list_item_addition_flow_state_impl.dart'
    as _i634;
import 'shopping_list/use_cases/read_shopping_list_item_addition_flow_state/read_shopping_list_item_addition_flow_state.dart'
    as _i586;
import 'shopping_list/use_cases/read_shopping_list_overview_flow_state/impl/read_shopping_list_overview_flow_state_impl.dart'
    as _i917;
import 'shopping_list/use_cases/read_shopping_list_overview_flow_state/read_shopping_list_overview_flow_state.dart'
    as _i333;
import 'shopping_list/use_cases/shared/factories/existing_shopping_list_draft_item_ref_factory/existing_shopping_list_draft_item_ref_factory.dart'
    as _i223;
import 'shopping_list/use_cases/shared/factories/existing_shopping_list_draft_item_ref_factory/impl/existing_shopping_list_draft_item_ref_factory_impl.dart'
    as _i922;
import 'shopping_list/use_cases/shared/factories/new_shopping_list_draft_item_ref_factory/impl/new_shopping_list_draft_item_ref_factory_impl.dart'
    as _i10;
import 'shopping_list/use_cases/shared/factories/new_shopping_list_draft_item_ref_factory/new_shopping_list_draft_item_ref_factory.dart'
    as _i564;
import 'shopping_list/use_cases/shared/factories/shopping_list_item_addition_flow_state_ref_factory/impl/shopping_list_item_addition_flow_state_ref_factory_impl.dart'
    as _i721;
import 'shopping_list/use_cases/shared/factories/shopping_list_item_addition_flow_state_ref_factory/shopping_list_item_addition_flow_state_ref_factory.dart'
    as _i757;
import 'shopping_list/use_cases/shared/factories/shopping_list_item_editing_flow_state_ref_factory/impl/shopping_list_item_editing_flow_state_ref_factory_impl.dart'
    as _i680;
import 'shopping_list/use_cases/shared/factories/shopping_list_item_editing_flow_state_ref_factory/shopping_list_item_editing_flow_state_ref_factory.dart'
    as _i653;
import 'shopping_list/use_cases/shared/factories/shopping_list_item_title_validation_error_output_dto_factory/impl/shopping_list_item_title_validation_error_output_dto_factory_impl.dart'
    as _i842;
import 'shopping_list/use_cases/shared/factories/shopping_list_item_title_validation_error_output_dto_factory/shopping_list_item_title_validation_error_output_dto_factory.dart'
    as _i827;
import 'shopping_list/use_cases/shared/factories/shopping_list_overview_flow_state_ref_factory/impl/shopping_list_overview_flow_state_ref_factory_impl.dart'
    as _i1059;
import 'shopping_list/use_cases/shared/factories/shopping_list_overview_flow_state_ref_factory/shopping_list_overview_flow_state_ref_factory.dart'
    as _i435;
import 'shopping_list/use_cases/start_shopping_list_item_addition/impl/start_shopping_list_item_addition_impl.dart'
    as _i1042;
import 'shopping_list/use_cases/start_shopping_list_item_addition/start_shopping_list_item_addition.dart'
    as _i1056;
import 'shopping_list/use_cases/start_shopping_list_item_editing/impl/start_shopping_list_item_editing_impl.dart'
    as _i398;
import 'shopping_list/use_cases/start_shopping_list_item_editing/start_shopping_list_item_editing.dart'
    as _i268;
import 'shopping_list/use_cases/stop_shopping_list_item_addition/impl/stop_shopping_list_item_addition_impl.dart'
    as _i227;
import 'shopping_list/use_cases/stop_shopping_list_item_addition/stop_shopping_list_item_addition.dart'
    as _i97;
import 'shopping_list/use_cases/submit_new_shopping_list_item_draft/impl/submit_new_shopping_list_item_draft_impl.dart'
    as _i155;
import 'shopping_list/use_cases/submit_new_shopping_list_item_draft/submit_new_shopping_list_item_draft.dart'
    as _i485;
import 'shopping_list/use_cases/suspend_shopping_list_item_addition/impl/suspend_shopping_list_item_addition_impl.dart'
    as _i917;
import 'shopping_list/use_cases/suspend_shopping_list_item_addition/suspend_shopping_list_item_addition.dart'
    as _i930;
import 'shopping_list/use_cases/toggle_shopping_list_item_check/impl/toggle_shopping_list_item_check_impl.dart'
    as _i851;
import 'shopping_list/use_cases/toggle_shopping_list_item_check/toggle_shopping_list_item_check.dart'
    as _i372;
import 'shopping_list/use_cases/update_existing_shopping_list_draft_item_title/impl/update_existing_shopping_list_draft_item_title_impl.dart'
    as _i157;
import 'shopping_list/use_cases/update_existing_shopping_list_draft_item_title/update_existing_shopping_list_draft_item_title.dart'
    as _i800;
import 'shopping_list/use_cases/update_new_shopping_list_draft_item_title/impl/update_new_shopping_list_draft_item_title_impl.dart'
    as _i320;
import 'shopping_list/use_cases/update_new_shopping_list_draft_item_title/update_new_shopping_list_draft_item_title.dart'
    as _i431;
import 'shopping_list/use_cases/watch_shopping_list_item_addition_flow_state/impl/watch_shopping_list_item_addition_flow_state_impl.dart'
    as _i656;
import 'shopping_list/use_cases/watch_shopping_list_item_addition_flow_state/watch_shopping_list_item_addition_flow_state.dart'
    as _i927;
import 'shopping_list/use_cases/watch_shopping_list_item_editing_flow_state/impl/watch_shopping_list_item_editing_flow_state_impl.dart'
    as _i240;
import 'shopping_list/use_cases/watch_shopping_list_item_editing_flow_state/watch_shopping_list_item_editing_flow_state.dart'
    as _i358;
import 'shopping_list/use_cases/watch_shopping_list_overview_flow_state/impl/watch_shopping_list_overview_flow_state_impl.dart'
    as _i449;
import 'shopping_list/use_cases/watch_shopping_list_overview_flow_state/watch_shopping_list_overview_flow_state.dart'
    as _i335;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i435.ShoppingListOverviewFlowStateRefFactory>(
      () => const _i1059.ShoppingListOverviewFlowStateRefFactoryImpl(),
    );
    gh.lazySingleton<_i706.UiLocaleOutputDtoFactory>(
      () => const _i224.UiLocaleOutputDtoFactoryImpl(),
    );
    gh.lazySingleton<_i867.AppInitializationFlowStateRefFactory>(
      () => const _i403.AppInitializationFlowStateRefFactoryImpl(),
    );
    gh.lazySingleton<_i518.ShoppingListFlowStore>(
      () => _i1027.ShoppingListFlowStoreImpl(),
    );
    gh.lazySingleton<_i37.ShoppingListItemLocalDtoFactory>(
      () => const _i390.ShoppingListItemLocalDtoFactoryImpl(),
    );
    gh.lazySingleton<_i437.AppInitializationFlowStore>(
      () => _i561.AppInitializationFlowStoreImpl(),
    );
    gh.lazySingleton<_i333.ReadShoppingListOverviewFlowState>(
      () => _i917.ReadShoppingListOverviewFlowStateImpl(
        shoppingListFlowStore: gh<_i518.ShoppingListFlowStore>(),
        shoppingListOverviewFlowStateRefFactory:
            gh<_i435.ShoppingListOverviewFlowStateRefFactory>(),
      ),
    );
    gh.lazySingleton<_i905.UiLocaleStore>(() => _i123.UiLocaleStoreImpl());
    gh.lazySingleton<
      _i827.ShoppingListItemTitleValidationErrorOutputDtoFactory
    >(
      () =>
          const _i842.ShoppingListItemTitleValidationErrorOutputDtoFactoryImpl(),
    );
    gh.lazySingleton<_i390.WatchAppInitializationFlowState>(
      () => _i147.WatchAppInitializationFlowStateImpl(
        appInitializationFlowStore: gh<_i437.AppInitializationFlowStore>(),
        appInitializationFlowStateRefFactory:
            gh<_i867.AppInitializationFlowStateRefFactory>(),
      ),
    );
    gh.lazySingleton<_i930.SuspendShoppingListItemAddition>(
      () => _i917.SuspendShoppingListItemAdditionImpl(
        shoppingListFlowStore: gh<_i518.ShoppingListFlowStore>(),
      ),
    );
    gh.lazySingleton<_i564.NewShoppingListDraftItemRefFactory>(
      () => _i10.NewShoppingListDraftItemRefFactoryImpl(
        shoppingListItemTitleValidationErrorOutputDtoFactory:
            gh<_i827.ShoppingListItemTitleValidationErrorOutputDtoFactory>(),
      ),
    );
    gh.lazySingleton<_i751.ReadUiLocale>(
      () => _i991.ReadUiLocaleImpl(
        uiLocaleOutputDtoFactory: gh<_i706.UiLocaleOutputDtoFactory>(),
        uiLocaleStore: gh<_i905.UiLocaleStore>(),
      ),
    );
    gh.lazySingleton<_i268.StartShoppingListItemEditing>(
      () => _i398.StartShoppingListItemEditingImpl(
        shoppingListItemTitleValidator:
            gh<_i364.ShoppingListItemTitleValidator>(),
        shoppingListFlowStore: gh<_i518.ShoppingListFlowStore>(),
      ),
    );
    gh.lazySingleton<_i470.InitializeAppInitializationFlowStore>(
      () => _i881.InitializeAppInitializationFlowStoreImpl(
        appInitializationFlowStore: gh<_i437.AppInitializationFlowStore>(),
      ),
    );
    gh.lazySingleton<_i97.StopShoppingListItemAddition>(
      () => _i227.StopShoppingListItemAdditionImpl(
        shoppingListFlowStore: gh<_i518.ShoppingListFlowStore>(),
      ),
    );
    gh.lazySingleton<_i1035.WatchUiLocale>(
      () => _i275.WatchUiLocaleImpl(
        uiLocaleOutputDtoFactory: gh<_i706.UiLocaleOutputDtoFactory>(),
        uiLocaleStore: gh<_i905.UiLocaleStore>(),
      ),
    );
    gh.lazySingleton<_i581.CompleteShoppingListItemEditing>(
      () => _i751.CompleteShoppingListItemEditingImpl(
        shoppingListFlowStore: gh<_i518.ShoppingListFlowStore>(),
      ),
    );
    gh.lazySingleton<_i372.ToggleShoppingListItemCheck>(
      () => _i851.ToggleShoppingListItemCheckImpl(
        shoppingListFlowStore: gh<_i518.ShoppingListFlowStore>(),
      ),
    );
    gh.lazySingleton<_i757.ShoppingListItemAdditionFlowStateRefFactory>(
      () => _i721.ShoppingListItemAdditionFlowStateRefFactoryImpl(
        newShoppingListDraftItemRefFactory:
            gh<_i564.NewShoppingListDraftItemRefFactory>(),
      ),
    );
    gh.lazySingleton<_i1056.StartShoppingListItemAddition>(
      () => _i1042.StartShoppingListItemAdditionImpl(
        shoppingListItemTitleValidator:
            gh<_i364.ShoppingListItemTitleValidator>(),
        shoppingListFlowStore: gh<_i518.ShoppingListFlowStore>(),
      ),
    );
    gh.lazySingleton<_i800.UpdateExistingShoppingListDraftItemTitle>(
      () => _i157.UpdateExistingShoppingListDraftItemTitleImpl(
        shoppingListItemTitleValidator:
            gh<_i364.ShoppingListItemTitleValidator>(),
        shoppingListFlowStore: gh<_i518.ShoppingListFlowStore>(),
      ),
    );
    gh.lazySingleton<_i485.SubmitNewShoppingListItemDraft>(
      () => _i155.SubmitNewShoppingListItemDraftImpl(
        shoppingListItemFactory: gh<_i463.ShoppingListItemFactory>(),
        shoppingListFlowStore: gh<_i518.ShoppingListFlowStore>(),
        shoppingListItemTitleValidator:
            gh<_i364.ShoppingListItemTitleValidator>(),
      ),
    );
    gh.lazySingleton<_i27.CancelShoppingListItemEditing>(
      () => _i171.CancelShoppingListItemEditingImpl(
        shoppingListFlowStore: gh<_i518.ShoppingListFlowStore>(),
      ),
    );
    gh.lazySingleton<_i431.UpdateNewShoppingListDraftItemTitle>(
      () => _i320.UpdateNewShoppingListDraftItemTitleImpl(
        shoppingListItemTitleValidator:
            gh<_i364.ShoppingListItemTitleValidator>(),
        shoppingListFlowStore: gh<_i518.ShoppingListFlowStore>(),
      ),
    );
    gh.lazySingleton<_i223.ExistingShoppingListDraftItemRefFactory>(
      () => _i922.ExistingShoppingListDraftItemRefFactoryImpl(
        shoppingListItemTitleValidationErrorOutputDtoFactory:
            gh<_i827.ShoppingListItemTitleValidationErrorOutputDtoFactory>(),
      ),
    );
    gh.lazySingleton<_i335.WatchShoppingListOverviewFlowState>(
      () => _i449.WatchShoppingListOverviewFlowStateImpl(
        shoppingListFlowStore: gh<_i518.ShoppingListFlowStore>(),
        shoppingListOverviewFlowStateRefFactory:
            gh<_i435.ShoppingListOverviewFlowStateRefFactory>(),
      ),
    );
    gh.lazySingleton<_i207.ReadAppInitializationFlowState>(
      () => _i787.ReadAppInitializationFlowStateImpl(
        appInitializationFlowStore: gh<_i437.AppInitializationFlowStore>(),
        appInitializationFlowStateRefFactory:
            gh<_i867.AppInitializationFlowStateRefFactory>(),
      ),
    );
    gh.lazySingleton<_i628.LoadShoppingListItems>(
      () => _i615.LoadShoppingListItemsImpl(
        shoppingListFlowStore: gh<_i518.ShoppingListFlowStore>(),
        shoppingListItemLocalDtoFactory:
            gh<_i37.ShoppingListItemLocalDtoFactory>(),
        shoppingListRepository: gh<_i747.ShoppingListLocalRepository>(),
      ),
    );
    gh.lazySingleton<_i586.ReadShoppingListItemAdditionFlowState>(
      () => _i634.ReadShoppingListItemAdditionFlowStateImpl(
        shoppingListFlowStore: gh<_i518.ShoppingListFlowStore>(),
        shoppingListItemAdditionFlowStateRefFactory:
            gh<_i757.ShoppingListItemAdditionFlowStateRefFactory>(),
      ),
    );
    gh.lazySingleton<_i395.HandleAppLaunch>(
      () => _i57.HandleAppLaunchImpl(
        appInitializationFlowStore: gh<_i437.AppInitializationFlowStore>(),
        uiLocaleStore: gh<_i905.UiLocaleStore>(),
        shoppingListFlowStore: gh<_i518.ShoppingListFlowStore>(),
      ),
    );
    gh.lazySingleton<_i927.WatchShoppingListItemAdditionFlowState>(
      () => _i656.WatchShoppingListItemAdditionFlowStateImpl(
        shoppingListFlowStore: gh<_i518.ShoppingListFlowStore>(),
        shoppingListItemAdditionFlowStateRefFactory:
            gh<_i757.ShoppingListItemAdditionFlowStateRefFactory>(),
      ),
    );
    gh.lazySingleton<_i653.ShoppingListItemEditingFlowStateRefFactory>(
      () => _i680.ShoppingListItemEditingFlowStateRefFactoryImpl(
        existingShoppingListDraftItemRefFactory:
            gh<_i223.ExistingShoppingListDraftItemRefFactory>(),
      ),
    );
    gh.lazySingleton<_i358.WatchShoppingListItemEditingFlowState>(
      () => _i240.WatchShoppingListItemEditingFlowStateImpl(
        shoppingListFlowStore: gh<_i518.ShoppingListFlowStore>(),
        shoppingListItemEditingFlowStateRefFactory:
            gh<_i653.ShoppingListItemEditingFlowStateRefFactory>(),
      ),
    );
    return this;
  }
}
