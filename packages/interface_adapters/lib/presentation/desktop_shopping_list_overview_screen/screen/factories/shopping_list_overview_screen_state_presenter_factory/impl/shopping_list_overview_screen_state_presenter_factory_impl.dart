import 'package:application/core/use_cases/read_ui_locale/read_ui_locale.dart';
import 'package:application/core/use_cases/watch_ui_locale/watch_ui_locale.dart';
import 'package:application/shopping_list/use_cases/read_shopping_list_overview_flow_state/read_shopping_list_overview_flow_state.dart';
import 'package:application/shopping_list/use_cases/shared/refs/shopping_list_overview_flow_state_ref.dart';
import 'package:application/shopping_list/use_cases/start_shopping_list_item_addition/start_shopping_list_item_addition.dart';
import 'package:application/shopping_list/use_cases/watch_shopping_list_overview_flow_state/watch_shopping_list_overview_flow_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../shopping_list_item/factories/shopping_list_item_presenter_factory/shopping_list_item_presenter_factory.dart';
import '../../../l10n/shopping_list_overview_screen_loaded_state_view_translation/shopping_list_overview_screen_loaded_state_view_translation.dart';
import '../../../l10n/shopping_list_overview_screen_loading_state_view_translation/shopping_list_overview_screen_loading_state_view_translation.dart';
import '../../../presenters/shopping_list_overview_screen_state_presenter/impl/shopping_list_overview_screen_loaded_state_presenter_impl.dart';
import '../../../presenters/shopping_list_overview_screen_state_presenter/impl/shopping_list_overview_screen_loading_state_presenter_impl.dart';
import '../../../presenters/shopping_list_overview_screen_state_presenter/shopping_list_overview_screen_state_presenter.dart';
import '../shopping_list_overview_screen_state_presenter_factory.dart';

@LazySingleton(as: ShoppingListOverviewScreenStatePresenterFactory)
class ShoppingListOverviewScreenStatePresenterFactoryImpl
    implements ShoppingListOverviewScreenStatePresenterFactory {
  const ShoppingListOverviewScreenStatePresenterFactoryImpl({
    required ShoppingListOverviewScreenLoadedStateViewTranslation
    shoppingListOverviewScreenLoadedStateViewTranslation,
    required ShoppingListOverviewScreenLoadingStateViewTranslation
    shoppingListOverviewScreenLoadingStateViewTranslation,
    required ReadShoppingListOverviewFlowState readShoppingListOverviewFlowState,
    required ReadUiLocale readUiLocale,
    required ShoppingListItemPresenterFactory shoppingListItemPresenterFactory,
    required WatchShoppingListOverviewFlowState watchShoppingListOverviewFlowState,
    required WatchUiLocale watchUiLocale,
    required StartShoppingListItemAddition startShoppingListItemAddition,
  }) : _shoppingListOverviewScreenLoadedStateViewTranslation =
           shoppingListOverviewScreenLoadedStateViewTranslation,
       _shoppingListOverviewScreenLoadingStateViewTranslation =
           shoppingListOverviewScreenLoadingStateViewTranslation,
       _readShoppingListOverviewFlowState = readShoppingListOverviewFlowState,
       _readUiLocale = readUiLocale,
       _shoppingListItemPresenterFactory = shoppingListItemPresenterFactory,
       _watchShoppingListOverviewFlowState = watchShoppingListOverviewFlowState,
       _watchUiLocale = watchUiLocale,
       _startShoppingListItemAddition = startShoppingListItemAddition;

  final ShoppingListOverviewScreenLoadedStateViewTranslation
  _shoppingListOverviewScreenLoadedStateViewTranslation;
  final ShoppingListOverviewScreenLoadingStateViewTranslation
  _shoppingListOverviewScreenLoadingStateViewTranslation;
  final ReadShoppingListOverviewFlowState _readShoppingListOverviewFlowState;
  final ReadUiLocale _readUiLocale;
  final ShoppingListItemPresenterFactory _shoppingListItemPresenterFactory;
  final WatchShoppingListOverviewFlowState _watchShoppingListOverviewFlowState;
  final WatchUiLocale _watchUiLocale;
  final StartShoppingListItemAddition _startShoppingListItemAddition;

  @override
  ShoppingListOverviewScreenStatePresenter create({
    required ShoppingListOverviewFlowStateRef shoppingListOverviewFlowStateRef,
  }) {
    switch (shoppingListOverviewFlowStateRef) {
      case InitialShoppingListOverviewFlowStateRef():
      case LoadingShoppingListOverviewFlowStateRef():
        return ShoppingListOverviewScreenLoadingStatePresenterImpl(
          translation: _shoppingListOverviewScreenLoadingStateViewTranslation,
          readUiLocale: _readUiLocale,
          watchUiLocale: _watchUiLocale,
        );

      case LoadedShoppingListOverviewFlowStateRef():
        return ShoppingListOverviewScreenLoadedStatePresenterImpl(
          translation: _shoppingListOverviewScreenLoadedStateViewTranslation,
          shoppingListItemPresenterFactory: _shoppingListItemPresenterFactory,
          readShoppingListOverviewFlowState: _readShoppingListOverviewFlowState,
          watchShoppingListOverviewFlowState: _watchShoppingListOverviewFlowState,
          startShoppingListItemAddition: _startShoppingListItemAddition,
          readUiLocale: _readUiLocale,
          watchUiLocale: _watchUiLocale,
        );
    }
  }
}
