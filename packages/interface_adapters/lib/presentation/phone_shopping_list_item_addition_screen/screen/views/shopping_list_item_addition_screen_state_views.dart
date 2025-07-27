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

  ShoppingListItemAdditionScreenReadyStateView copyWith({
    String Function()? title,
    String Function()? shoppingListItemAdditionInputText,
    String Function()? submissionButtonTitle,
    bool Function()? submissionButtonEnabled,
  }) {
    return ShoppingListItemAdditionScreenReadyStateView(
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

class ShoppingListItemAdditionScreenSuspendedStateView extends Equatable
    implements ShoppingListItemAdditionScreenStateView {
  const ShoppingListItemAdditionScreenSuspendedStateView();

  @override
  List<Object?> get props => [];
}
