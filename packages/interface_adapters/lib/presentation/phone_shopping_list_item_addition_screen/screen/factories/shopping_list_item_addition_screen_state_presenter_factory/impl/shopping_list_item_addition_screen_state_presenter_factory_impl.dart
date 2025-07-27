import 'package:application/core/use_cases/read_ui_locale/read_ui_locale.dart';
import 'package:application/core/use_cases/watch_ui_locale/watch_ui_locale.dart';
import 'package:application/shopping_list/use_cases/read_shopping_list_item_addition_flow_state/read_shopping_list_item_addition_flow_state.dart';
import 'package:application/shopping_list/use_cases/shared/refs/shopping_list_item_addition_flow_state_ref.dart';
import 'package:application/shopping_list/use_cases/submit_new_shopping_list_item_draft/submit_new_shopping_list_item_draft.dart';
import 'package:application/shopping_list/use_cases/update_new_shopping_list_draft_item_title/update_new_shopping_list_draft_item_title.dart';
import 'package:application/shopping_list/use_cases/watch_shopping_list_item_addition_flow_state/watch_shopping_list_item_addition_flow_state.dart';
import 'package:injectable/injectable.dart';

import '../../../l10n/shopping_list_item_addition_screen_view_translation/shopping_list_item_addition_screen_view_translation.dart';
import '../../../presenters/shopping_list_item_addition_screen_state_presenter/impl/shopping_list_item_addition_screen_idle_state_presenter_impl.dart';
import '../../../presenters/shopping_list_item_addition_screen_state_presenter/impl/shopping_list_item_addition_screen_ready_state_presenter_impl.dart';
import '../../../presenters/shopping_list_item_addition_screen_state_presenter/shopping_list_item_addition_screen_state_presenter.dart';
import '../../shopping_list_item_addition_screen_state_presenter_factory/shopping_list_item_addition_screen_state_presenter_factory.dart';

@LazySingleton(as: ShoppingListItemAdditionScreenStatePresenterFactory)
class ShoppingListItemAdditionScreenStatePresenterFactoryImpl
    implements ShoppingListItemAdditionScreenStatePresenterFactory {
  const ShoppingListItemAdditionScreenStatePresenterFactoryImpl({
    required ReadShoppingListItemAdditionFlowState readShoppingListItemAdditionFlowState,
    required ReadUiLocale readUiLocale,
    required ShoppingListItemAdditionScreenReadyStateViewTranslation
    shoppingListItemAdditionScreenReadyStateViewTranslation,
    required SubmitNewShoppingListItemDraft submitNewShoppingListItemDraft,
    required UpdateNewShoppingListDraftItemTitle updateNewShoppingListDraftItemTitle,
    required WatchShoppingListItemAdditionFlowState watchShoppingListItemAdditionFlowState,
    required WatchUiLocale watchUiLocale,
  }) : _readShoppingListItemAdditionFlowState = readShoppingListItemAdditionFlowState,
       _readUiLocale = readUiLocale,
       _shoppingListItemAdditionScreenReadyStateViewTranslation =
           shoppingListItemAdditionScreenReadyStateViewTranslation,
       _submitNewShoppingListItemDraft = submitNewShoppingListItemDraft,
       _updateNewShoppingListDraftItemTitle = updateNewShoppingListDraftItemTitle,
       _watchShoppingListItemAdditionFlowState = watchShoppingListItemAdditionFlowState,
       _watchUiLocale = watchUiLocale;

  final ReadShoppingListItemAdditionFlowState _readShoppingListItemAdditionFlowState;
  final ReadUiLocale _readUiLocale;
  final ShoppingListItemAdditionScreenReadyStateViewTranslation
  _shoppingListItemAdditionScreenReadyStateViewTranslation;
  final SubmitNewShoppingListItemDraft _submitNewShoppingListItemDraft;
  final UpdateNewShoppingListDraftItemTitle _updateNewShoppingListDraftItemTitle;
  final WatchShoppingListItemAdditionFlowState _watchShoppingListItemAdditionFlowState;
  final WatchUiLocale _watchUiLocale;

  @override
  ShoppingListItemAdditionScreenStatePresenter create({
    required ShoppingListItemAdditionFlowStateRef shoppingListItemAdditionFlowStateRef,
  }) {
    switch (shoppingListItemAdditionFlowStateRef) {
      case IdleShoppingListItemAdditionFlowStateRef():
      case SuspendedShoppingListItemAdditionFlowStateRef():
        return ShoppingListItemAdditionScreenIdleStatePresenterImpl();

      case OngoingShoppingListItemAdditionFlowStateRef():
        return ShoppingListItemAdditionScreenReadyStatePresenterImpl(
          translation: _shoppingListItemAdditionScreenReadyStateViewTranslation,
          submitNewShoppingListItemDraft: _submitNewShoppingListItemDraft,
          updateNewShoppingListDraftItemTitle: _updateNewShoppingListDraftItemTitle,
          readShoppingListItemAdditionFlowState: _readShoppingListItemAdditionFlowState,
          watchShoppingListItemAdditionFlowState: _watchShoppingListItemAdditionFlowState,
          readUiLocale: _readUiLocale,
          watchUiLocale: _watchUiLocale,
        );
    }
  }
}
