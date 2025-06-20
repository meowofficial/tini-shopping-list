import 'package:flutter/cupertino.dart';

import '../../../../../core/frameworks/ui/utils/view_stream_builder.dart';
import '../../../interface_adapters/presentation/phone_shopping_list_item_addition_screen/interfaces/shopping_list_item_addition_screen_state_presenters.dart';
import 'widgets/shopping_list_item_title_text_field.dart';

class ScreenBodyReadyStateViewWidget extends StatelessWidget {
  const ScreenBodyReadyStateViewWidget({
    required this.presenter,
    super.key,
  });

  final ShoppingListItemAdditionScreenReadyStatePresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          ConverterViewStreamBuilder(
            viewStreamable: presenter,
            converter: (view) => view.shoppingListItemAdditionInputText,
            builder: (context, shoppingListItemAdditionInputText) {
              return ShoppingListItemTitleTextField(
                title: shoppingListItemAdditionInputText,
                onTextChanged: presenter.onShoppingListItemTitleInputTextChanged,
              );
            },
          ),
          const SizedBox(height: 20),
          ConverterViewStreamBuilder(
            viewStreamable: presenter,
            converter: (view) => view.submissionButtonEnabled,
            builder: (context, submissionButtonEnabled) {
              return CupertinoButton.filled(
                onPressed: submissionButtonEnabled
                    ? presenter.onShoppingListItemSubmissionButtonPressed
                    : null,
                child: const Text('Добавить'),
              );
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
