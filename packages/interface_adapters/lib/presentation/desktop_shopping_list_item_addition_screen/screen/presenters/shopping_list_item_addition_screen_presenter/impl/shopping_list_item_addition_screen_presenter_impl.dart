import 'dart:async';

import 'package:application/core/use_cases/read_ui_locale/read_ui_locale.dart';
import 'package:application/core/use_cases/shared/output_dtos/ui_locale_output_dto.dart';
import 'package:application/core/use_cases/watch_ui_locale/watch_ui_locale.dart';
import 'package:application/shopping_list/use_cases/read_shopping_list_item_addition_flow_state/read_shopping_list_item_addition_flow_state.dart';
import 'package:application/shopping_list/use_cases/shared/refs/new_shopping_list_draft_item_ref/new_shopping_list_draft_item_ref.dart';
import 'package:application/shopping_list/use_cases/shared/refs/shopping_list_item_addition_flow_state_ref.dart';
import 'package:application/shopping_list/use_cases/stop_shopping_list_item_addition/stop_shopping_list_item_addition.dart';
import 'package:application/shopping_list/use_cases/submit_new_shopping_list_item_draft/submit_new_shopping_list_item_draft.dart';
import 'package:application/shopping_list/use_cases/update_new_shopping_list_draft_item_title/update_new_shopping_list_draft_item_title.dart';
import 'package:application/shopping_list/use_cases/watch_shopping_list_item_addition_flow_state/watch_shopping_list_item_addition_flow_state.dart';

import '../../../../../core/base_view_streamable_presenter.dart';
import '../../../l10n/shopping_list_item_addition_screen_view_translation/shopping_list_item_addition_screen_view_translation.dart';
import '../../../views/shopping_list_item_addition_screen_view.dart';
import '../../shopping_list_item_addition_screen_presenter/shopping_list_item_addition_screen_presenter.dart';

class ShoppingListItemAdditionScreenPresenterImpl
    extends BaseViewStreamablePresenter<ShoppingListItemAdditionScreenView>
    implements ShoppingListItemAdditionScreenPresenter {
  ShoppingListItemAdditionScreenPresenterImpl({
    required ShoppingListItemAdditionScreenViewTranslation translation,
    required SubmitNewShoppingListItemDraft submitNewShoppingListItemDraft,
    required StopShoppingListItemAddition stopShoppingListItemAddition,
    required ReadShoppingListItemAdditionFlowState readShoppingListItemAdditionFlowState,
    required ReadUiLocale readUiLocale,
    required UpdateNewShoppingListDraftItemTitle updateNewShoppingListDraftItemTitle,
    required WatchShoppingListItemAdditionFlowState watchShoppingListItemAdditionFlowState,
    required WatchUiLocale watchUiLocale,
  }) : _translation = translation,
       _submitNewShoppingListItemDraft = submitNewShoppingListItemDraft,
       _stopShoppingListItemAddition = stopShoppingListItemAddition,
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
      newShoppingListDraftItemRefSnapshot: newShoppingListDraftItemRef.snapshot,
    );

    final view = ShoppingListItemAdditionScreenView(
      title: _translation.title,
      submissionButtonTitle: _translation.submissionButtonTitle,
      shoppingListItemAdditionInputText: newShoppingListDraftItemRef.snapshot.title,
      submissionButtonEnabled: updatedSubmissionButtonEnabled,
    );

    initializeView(view);

    _newShoppingListDraftItemRefSnapshotStreamSubscription = newShoppingListDraftItemRef
        .snapshotStream
        .listen(_onNewShoppingListDraftItemSnapshotChanged);

    _shoppingListItemAdditionFlowStateStreamSubscription = _watchShoppingListItemAdditionFlowState(
      sync: true,
    ).listen(_onShoppingListItemAdditionFlowStateChanged);

    _uiLocaleStreamSubscription = _watchUiLocale(
      sync: true,
    ).listen(_onUiLocaleChanged);
  }

  final ShoppingListItemAdditionScreenViewTranslation _translation;

  final SubmitNewShoppingListItemDraft _submitNewShoppingListItemDraft;
  final StopShoppingListItemAddition _stopShoppingListItemAddition;
  final ReadShoppingListItemAdditionFlowState _readShoppingListItemAdditionFlowState;
  final ReadUiLocale _readUiLocale;
  final UpdateNewShoppingListDraftItemTitle _updateNewShoppingListDraftItemTitle;
  final WatchShoppingListItemAdditionFlowState _watchShoppingListItemAdditionFlowState;
  final WatchUiLocale _watchUiLocale;

  late final StreamSubscription<NewShoppingListDraftItemRefSnapshot>
  _newShoppingListDraftItemRefSnapshotStreamSubscription;

  late final StreamSubscription<ShoppingListItemAdditionFlowStateRef>
  _shoppingListItemAdditionFlowStateStreamSubscription;

  late final StreamSubscription<UiLocaleOutputDto> _uiLocaleStreamSubscription;

  late bool _completed;

  bool _getSubmissionButtonEnablementStatus({
    required NewShoppingListDraftItemRefSnapshot newShoppingListDraftItemRefSnapshot,
  }) {
    return newShoppingListDraftItemRefSnapshot.titleValidationError == null;
  }

  void _onNewShoppingListDraftItemSnapshotChanged(
    NewShoppingListDraftItemRefSnapshot newShoppingListDraftItemRefSnapshot,
  ) {
    final updatedSubmissionButtonEnabled = _getSubmissionButtonEnablementStatus(
      newShoppingListDraftItemRefSnapshot: newShoppingListDraftItemRefSnapshot,
    );

    final updatedView = view.copyWith(
      shoppingListItemAdditionInputText: () => newShoppingListDraftItemRefSnapshot.title,
      submissionButtonEnabled: () => updatedSubmissionButtonEnabled,
    );

    emit(updatedView);
  }

  void _onShoppingListItemAdditionFlowStateChanged(ShoppingListItemAdditionFlowStateRef stateRef) {
    if (!_completed && stateRef is! OngoingShoppingListItemAdditionFlowStateRef) {
      _completed = true;
    }
  }

  void _onUiLocaleChanged(UiLocaleOutputDto uiLocale) {
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
    _stopShoppingListItemAddition();
  }

  @override
  void onShoppingListItemTitleInputTextSubmitted() {
    if (_completed) {
      return;
    }

    _submitNewShoppingListItemDraft();
    _stopShoppingListItemAddition();
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

    _stopShoppingListItemAddition();
  }

  @override
  void dispose() {
    _shoppingListItemAdditionFlowStateStreamSubscription.cancel();
    _newShoppingListDraftItemRefSnapshotStreamSubscription.cancel();
    _uiLocaleStreamSubscription.cancel();
    super.dispose();
  }
}
