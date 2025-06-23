import 'dart:async';

import '../../../../../../core/interface_adapters/presentation/base_view_streamable_presenter.dart';
import '../../../../application/refs/flow_state_refs/shopping_list_item_addition_flow_state_ref.dart';
import '../../../../application/use_cases/read_shopping_list_item_addition_flow_state.dart';
import '../../../../application/use_cases/submit_new_shopping_list_item_draft.dart';
import '../../../../application/use_cases/update_new_shopping_list_draft_item_title.dart';
import '../../../../application/use_cases/watch_shopping_list_item_addition_flow_state.dart';
import '../../../../domain/entities/new_shopping_list_draft_item.dart';
import '../interfaces/shopping_list_item_addition_screen_state_presenters.dart';
import '../views/shopping_list_item_addition_screen_state_views.dart';

class ShoppingListItemAdditionScreenReadyStatePresenterImpl
    extends BaseViewStreamablePresenter<ShoppingListItemAdditionScreenReadyStateView>
    implements ShoppingListItemAdditionScreenReadyStatePresenter {
  ShoppingListItemAdditionScreenReadyStatePresenterImpl({
    required SubmitNewShoppingListItemDraft submitNewShoppingListItemDraft,
    required ReadShoppingListItemAdditionFlowState readShoppingListItemAdditionFlowState,
    required UpdateNewShoppingListDraftItemTitle updateNewShoppingListDraftItemTitle,
    required WatchShoppingListItemAdditionFlowState watchShoppingListItemAdditionFlowState,
  }) : _submitNewShoppingListItemDraft = submitNewShoppingListItemDraft,
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

    final view = ShoppingListItemAdditionScreenReadyStateView(
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

  final SubmitNewShoppingListItemDraft _submitNewShoppingListItemDraft;
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
    _completed = switch (stateRef) {
      IdleShoppingListItemAdditionFlowStateRef() => true,
      SuspendedShoppingListItemAdditionFlowStateRef() => true,
      OngoingShoppingListItemAdditionFlowStateRef() => false,
    };
  }

  @override
  void onShoppingListItemSubmissionButtonPressed() {
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
    super.dispose();
  }
}
