import 'dart:async';

import '../../../../../../core/interface_adapters/presentation/base_view_presenter.dart';
import '../../../../application/refs/flow_state_refs/shopping_list_item_addition_flow_state_ref.dart';
import '../../../../application/use_cases/cancel_shopping_list_item_addition.dart';
import '../../../../application/use_cases/complete_shopping_list_item_addition.dart';
import '../../../../application/use_cases/read_shopping_list_item_addition_flow_state.dart';
import '../../../../application/use_cases/update_new_shopping_list_draft_item_title.dart';
import '../../../../application/use_cases/watch_shopping_list_item_addition_flow_state.dart';
import '../../../../domain/entities/new_shopping_list_draft_item.dart';
import '../interfaces/shopping_list_item_addition_screen_presenter.dart';
import '../views/shopping_list_item_addition_screen_view.dart';

class ShoppingListItemAdditionScreenPresenterImpl
    extends BaseViewPresenter<ShoppingListItemAdditionScreenView>
    implements ShoppingListItemAdditionScreenPresenter {
  ShoppingListItemAdditionScreenPresenterImpl({
    required CancelShoppingListItemAddition cancelShoppingListItemAddition,
    required CompleteShoppingListItemAddition completeShoppingListItemAddition,
    required ReadShoppingListItemAdditionFlowState readShoppingListItemAdditionFlowState,
    required UpdateNewShoppingListDraftItemTitle updateNewShoppingListDraftItemTitle,
    required WatchShoppingListItemAdditionFlowState watchShoppingListItemAdditionFlowState,
  }) : _cancelShoppingListItemAddition = cancelShoppingListItemAddition,
       _completeShoppingListItemAddition = completeShoppingListItemAddition,
       _readShoppingListItemAdditionFlowState = readShoppingListItemAdditionFlowState,
       _updateNewShoppingListDraftItemTitle = updateNewShoppingListDraftItemTitle,
       _watchShoppingListItemAdditionFlowState = watchShoppingListItemAdditionFlowState {
    _completed = false;

    final shoppingListItemAdditionFlowStateRef =
        _readShoppingListItemAdditionFlowState() as OngoingShoppingListItemAdditionFlowStateRef;

    final newShoppingListDraftItemRef =
        shoppingListItemAdditionFlowStateRef.newShoppingListDraftItemRef;

    final updatedSubmissionButtonEnabled = _getSubmissionButtonEnablementStatus(
      newShoppingListDraftItemSnapshot: newShoppingListDraftItemRef.snapshot,
    );

    final view = ShoppingListItemAdditionScreenView(
      shoppingListItemAdditionInputText: newShoppingListDraftItemRef.snapshot.title,
      submissionButtonEnabled: updatedSubmissionButtonEnabled,
    );

    initializeView(view);

    _newShoppingListDraftItemSnapshotStreamSubscription = newShoppingListDraftItemRef.snapshotStream
        .listen(_onNewShoppingListDraftItemSnapshotChanged);

    _shoppingListItemAdditionFlowStateStreamSubscription = _watchShoppingListItemAdditionFlowState(
      sync: true,
    ).listen(_onShoppingListItemAdditionFlowStateChanged);
  }

  final CancelShoppingListItemAddition _cancelShoppingListItemAddition;
  final CompleteShoppingListItemAddition _completeShoppingListItemAddition;
  final ReadShoppingListItemAdditionFlowState _readShoppingListItemAdditionFlowState;
  final UpdateNewShoppingListDraftItemTitle _updateNewShoppingListDraftItemTitle;
  final WatchShoppingListItemAdditionFlowState _watchShoppingListItemAdditionFlowState;

  late final StreamSubscription<NewShoppingListDraftItemSnapshot>
  _newShoppingListDraftItemSnapshotStreamSubscription;

  late final StreamSubscription<ShoppingListItemAdditionFlowStateRef>
  _shoppingListItemAdditionFlowStateStreamSubscription;

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
    if (!_completed && stateRef is! OngoingShoppingListItemAdditionFlowStateRef) {
      _completed = true;
    }
  }

  @override
  void onShoppingListItemSubmissionButtonPressed() {
    if (_completed) {
      return;
    }

    _completeShoppingListItemAddition();
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
  void onBackButtonPressed() {
    if (_completed) {
      return;
    }

    _cancelShoppingListItemAddition();
  }

  @override
  void dispose() {
    _shoppingListItemAdditionFlowStateStreamSubscription.cancel();
    _newShoppingListDraftItemSnapshotStreamSubscription.cancel();
    super.dispose();
  }
}
