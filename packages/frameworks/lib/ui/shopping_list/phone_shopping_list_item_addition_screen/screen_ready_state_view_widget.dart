import 'package:flutter/cupertino.dart';
import 'package:interface_adapters/presentation/phone_shopping_list_item_addition_screen/screen/presenters/shopping_list_item_addition_screen_state_presenter/shopping_list_item_addition_screen_state_presenter.dart';

import '../../core/size_configs/navigation_bar_size_config.dart';
import '../../core/ui_kit/navigation_bar_title_widget.dart';
import '../../core/ui_kit/scaffold.dart';
import '../../core/utils/view_stream_builder.dart';
import 'widgets/shopping_list_item_title_text_field.dart';

class ScreenReadyStateViewWidget extends StatelessWidget {
  const ScreenReadyStateViewWidget({
    required this.presenter,
    super.key,
  });

  final ShoppingListItemAdditionScreenReadyStatePresenter presenter;

  @override
  Widget build(BuildContext context) {
    return ScreenReadyStateViewInternalWidget(
      presenter: presenter,
      navigationBarSizeConfig: const NavigationBarSizeConfig(),
    );
  }
}

@visibleForTesting
class ScreenReadyStateViewInternalWidget extends StatelessWidget {
  const ScreenReadyStateViewInternalWidget({
    required this.presenter,
    required this.navigationBarSizeConfig,
    super.key,
  });

  final ShoppingListItemAdditionScreenReadyStatePresenter presenter;
  final NavigationBarSizeConfig navigationBarSizeConfig;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      navigationBarMiddle: _buildTitle(),
      child: Padding(
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
                  onTextSubmitted: presenter.onShoppingListItemTitleInputTextSubmitted,
                );
              },
            ),
            const SizedBox(height: 20),
            ConverterViewStreamBuilder(
              viewStreamable: presenter,
              converter: (view) {
                return (
                  submissionButtonEnabled: view.submissionButtonEnabled,
                  submissionButtonTitle: view.submissionButtonTitle,
                );
              },
              builder: (context, state) {
                final (
                  :submissionButtonEnabled,
                  :submissionButtonTitle,
                ) = state;

                return CupertinoButton.filled(
                  onPressed: submissionButtonEnabled
                      ? presenter.onShoppingListItemSubmissionButtonPressed
                      : null,
                  child: Text(submissionButtonTitle),
                );
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return ConverterViewStreamBuilder(
      viewStreamable: presenter,
      converter: (view) => view.title,
      builder: (context, title) {
        return NavigationBarTitleWidget(
          title: title,
          fontSize: navigationBarSizeConfig.getTitleFontSize(),
        );
      },
    );
  }
}
