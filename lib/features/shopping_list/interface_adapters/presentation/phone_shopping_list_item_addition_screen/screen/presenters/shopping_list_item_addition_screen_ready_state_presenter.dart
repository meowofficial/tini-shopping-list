import 'dart:async';

import '../../../../../../../core/application/use_cases/read_ui_locale.dart';
import '../../../../../../../core/application/use_cases/watch_ui_locale.dart';
import '../../../../../../../core/domain/common/ui_locale.dart';
import '../../../../../../../core/interface_adapters/presentation/base_view_streamable_presenter.dart';
import '../../../../../application/refs/flow_state_refs/shopping_list_item_addition_flow_state_ref.dart';
import '../../../../../application/use_cases/read_shopping_list_item_addition_flow_state.dart';
import '../../../../../application/use_cases/submit_new_shopping_list_item_draft.dart';
import '../../../../../application/use_cases/update_new_shopping_list_draft_item_title.dart';
import '../../../../../application/use_cases/watch_shopping_list_item_addition_flow_state.dart';
import '../../../../../domain/entities/new_shopping_list_draft_item.dart';
import '../interfaces/shopping_list_item_addition_screen_state_presenters.dart';
import '../l10n/shopping_list_item_addition_screen_view_translation.dart';
import '../views/shopping_list_item_addition_screen_state_views.dart';

class ShoppingListItemAdditionScreenReadyStatePresenterImpl
    extends BaseViewStreamablePresenter<ShoppingListItemAdditionScreenReadyStateView>
    implements ShoppingListItemAdditionScreenReadyStatePresenter {
  ShoppingListItemAdditionScreenReadyStatePresenterImpl({
    required ShoppingListItemAdditionScreenReadyStateViewTranslation translation,
    required SubmitNewShoppingListItemDraft submitNewShoppingListItemDraft,
    required ReadShoppingListItemAdditionFlowState readShoppingListItemAdditionFlowState,
    required ReadUiLocale readUiLocale,
    required UpdateNewShoppingListDraftItemTitle updateNewShoppingListDraftItemTitle,
    required WatchShoppingListItemAdditionFlowState watchShoppingListItemAdditionFlowState,
    required WatchUiLocale watchUiLocale,
  }) : _translation = translation,
       _submitNewShoppingListItemDraft = submitNewShoppingListItemDraft,
       _readShoppingListItemAdditionFlowState = readShoppingListItemAdditionFlowState,
       _readUiLocale = readUiLocale,
       _updateNewShoppingListDraftItemTitle = updateNewShoppingListDraftItemTitle,
       _watchShoppingListItemAdditionFlowState = watchShoppingListItemAdditionFlowState,
       _watchUiLocale = watchUiLocale {
    _completed = false;

    final uiLocale = _readUiLocale();

    _translation.setUiLocale(uiLocale);

    final shoppingListItemAdditionFlowStateRef =
        _readShoppingListItemAdditionFlowState() as OngoingShoppingListItemAdditionFlowStateRef;

    final newShoppingListDraftItemRef =
        shoppingListItemAdditionFlowStateRef.newShoppingListDraftItemRef;

    final updatedSubmissionButtonEnabled = _getSubmissionButtonEnablementStatus(
      newShoppingListDraftItemSnapshot: newShoppingListDraftItemRef.snapshot,
    );

    final view = ShoppingListItemAdditionScreenReadyStateView(
      title: _translation.title,
      submissionButtonTitle: _translation.submissionButtonTitle,
      shoppingListItemAdditionInputText: newShoppingListDraftItemRef.snapshot.title,
      submissionButtonEnabled: updatedSubmissionButtonEnabled,
    );

    initializeView(view);

    _newShoppingListDraftItemSnapshotStreamSubscription = newShoppingListDraftItemRef.snapshotStream
        .listen(_onNewShoppingListDraftItemSnapshotChanged);

    _shoppingListItemAdditionFlowStateStreamSubscription = _watchShoppingListItemAdditionFlowState(
      sync: true,
    ).listen(_onShoppingListItemAdditionFlowStateChanged);

    _uiLocaleStreamSubscription = _watchUiLocale(
      sync: true,
    ).listen(_onUiLocaleChanged);
  }

  final ShoppingListItemAdditionScreenReadyStateViewTranslation _translation;

  final SubmitNewShoppingListItemDraft _submitNewShoppingListItemDraft;
  final ReadShoppingListItemAdditionFlowState _readShoppingListItemAdditionFlowState;
  final ReadUiLocale _readUiLocale;
  final UpdateNewShoppingListDraftItemTitle _updateNewShoppingListDraftItemTitle;
  final WatchShoppingListItemAdditionFlowState _watchShoppingListItemAdditionFlowState;
  final WatchUiLocale _watchUiLocale;

  late final StreamSubscription<NewShoppingListDraftItemSnapshot>
  _newShoppingListDraftItemSnapshotStreamSubscription;

  late final StreamSubscription<ShoppingListItemAdditionFlowStateRef>
  _shoppingListItemAdditionFlowStateStreamSubscription;

  late final StreamSubscription<UiLocale> _uiLocaleStreamSubscription;

  late bool _completed;

  bool _getSubmissionButtonEnablementStatus({
    required NewShoppingListDraftItemSnapshot newShoppingListDraftItemSnapshot,
  }) {
    return newShoppingListDraftItemSnapshot.titleValidationError == null;
  }

  void _onNewShoppingListDraftItemSnapshotChanged(NewShoppingListDraftItemSnapshot snapshot) {
    final updatedSubmissionButtonEnabled = _getSubmissionButtonEnablementStatus(
      newShoppingListDraftItemSnapshot: snapshot,
    );

    final updatedView = view.copyWith(
      shoppingListItemAdditionInputText: () => snapshot.title,
      submissionButtonEnabled: () => updatedSubmissionButtonEnabled,
    );

    emit(updatedView);
  }

  void _onShoppingListItemAdditionFlowStateChanged(ShoppingListItemAdditionFlowStateRef stateRef) {
    _completed = switch (stateRef) {
      IdleShoppingListItemAdditionFlowStateRef() => true,
      SuspendedShoppingListItemAdditionFlowStateRef() => true,
      OngoingShoppingListItemAdditionFlowStateRef() => false,
    };
  }

  void _onUiLocaleChanged(UiLocale uiLocale) {
    _translation.setUiLocale(uiLocale);

    final updatedView = view.copyWith(
      title: () => _translation.title,
      submissionButtonTitle: () => _translation.submissionButtonTitle,
    );

    emit(updatedView);
  }

  @override
  void onShoppingListItemSubmissionButtonPressed() {
    if (_completed) {
      return;
    }

    _submitNewShoppingListItemDraft();
  }

  @override
  void onShoppingListItemTitleInputTextSubmitted() {
    if (_completed) {
      return;
    }

    _submitNewShoppingListItemDraft();
  }

  @override
  void onShoppingListItemTitleInputTextChanged(String value) {
    if (_completed) {
      return;
    }

    _updateNewShoppingListDraftItemTitle(
      updatedTitle: value,
    );
  }

  @override
  void dispose() {
    _shoppingListItemAdditionFlowStateStreamSubscription.cancel();
    _newShoppingListDraftItemSnapshotStreamSubscription.cancel();
    _uiLocaleStreamSubscription.cancel();
    super.dispose();
  }
}
