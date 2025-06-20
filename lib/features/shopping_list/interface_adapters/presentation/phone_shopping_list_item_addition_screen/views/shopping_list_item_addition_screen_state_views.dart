import 'package:equatable/equatable.dart';

sealed class ShoppingListItemAdditionScreenStateView {}

class ShoppingListItemAdditionScreenIdleStateView extends Equatable
    implements ShoppingListItemAdditionScreenStateView {
  const ShoppingListItemAdditionScreenIdleStateView();

  @override
  List<Object?> get props => [];
}

class ShoppingListItemAdditionScreenReadyStateView extends Equatable
    implements ShoppingListItemAdditionScreenStateView {
  const ShoppingListItemAdditionScreenReadyStateView({
    required this.shoppingListItemAdditionInputText,
    required this.submissionButtonEnabled,
  });

  final String shoppingListItemAdditionInputText;
  final bool submissionButtonEnabled;

  @override
  List<Object?> get props {
    return [
      shoppingListItemAdditionInputText,
      submissionButtonEnabled,
    ];
  }

  ShoppingListItemAdditionScreenReadyStateView copyWith({
    String Function()? shoppingListItemAdditionInputText,
    bool Function()? submissionButtonEnabled,
  }) {
    return ShoppingListItemAdditionScreenReadyStateView(
      shoppingListItemAdditionInputText: shoppingListItemAdditionInputText == null
          ? this.shoppingListItemAdditionInputText
          : shoppingListItemAdditionInputText(),
      submissionButtonEnabled: submissionButtonEnabled == null
          ? this.submissionButtonEnabled
          : submissionButtonEnabled(),
    );
  }
}
