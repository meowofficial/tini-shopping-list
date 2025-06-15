import 'package:equatable/equatable.dart';

class ShoppingListItemAdditionScreenView extends Equatable {
  const ShoppingListItemAdditionScreenView({
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

  ShoppingListItemAdditionScreenView copyWith({
    String Function()? shoppingListItemAdditionInputText,
    bool Function()? submissionButtonEnabled,
  }) {
    return ShoppingListItemAdditionScreenView(
      shoppingListItemAdditionInputText: shoppingListItemAdditionInputText == null
          ? this.shoppingListItemAdditionInputText
          : shoppingListItemAdditionInputText(),
      submissionButtonEnabled: submissionButtonEnabled == null
          ? this.submissionButtonEnabled
          : submissionButtonEnabled(),
    );
  }
}
