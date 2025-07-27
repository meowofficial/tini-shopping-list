import 'package:equatable/equatable.dart';

class ShoppingListItemAdditionScreenView extends Equatable {
  const ShoppingListItemAdditionScreenView({
    required this.title,
    required this.shoppingListItemAdditionInputText,
    required this.submissionButtonTitle,
    required this.submissionButtonEnabled,
  });

  final String title;
  final String shoppingListItemAdditionInputText;
  final String submissionButtonTitle;
  final bool submissionButtonEnabled;

  @override
  List<Object?> get props {
    return [
      title,
      shoppingListItemAdditionInputText,
      submissionButtonTitle,
      submissionButtonEnabled,
    ];
  }

  ShoppingListItemAdditionScreenView copyWith({
    String Function()? title,
    String Function()? shoppingListItemAdditionInputText,
    String Function()? submissionButtonTitle,
    bool Function()? submissionButtonEnabled,
  }) {
    return ShoppingListItemAdditionScreenView(
      title: title == null ? this.title : title(),
      shoppingListItemAdditionInputText: shoppingListItemAdditionInputText == null
          ? this.shoppingListItemAdditionInputText
          : shoppingListItemAdditionInputText(),
      submissionButtonTitle: submissionButtonTitle == null
          ? this.submissionButtonTitle
          : submissionButtonTitle(),
      submissionButtonEnabled: submissionButtonEnabled == null
          ? this.submissionButtonEnabled
          : submissionButtonEnabled(),
    );
  }
}
