import 'package:flutter/cupertino.dart';
import 'package:interface_adapters/presentation/desktop_shopping_list_item_addition_screen/screen/presenters/shopping_list_item_addition_screen_presenter/shopping_list_item_addition_screen_presenter.dart';

import '../../core/size_configs/navigation_bar_size_config.dart';
import '../../core/ui_kit/back_button.dart';
import '../../core/ui_kit/navigation_bar_title_widget.dart';
import '../../core/ui_kit/scaffold.dart';
import '../../core/utils/view_stream_builder.dart';
import 'widgets/shopping_list_item_title_text_field.dart';

class DesktopShoppingListItemAdditionScreenViewWidget extends StatelessWidget {
  const DesktopShoppingListItemAdditionScreenViewWidget({
    required this.presenter,
    super.key,
  });

  final ShoppingListItemAdditionScreenPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return DesktopShoppingListItemAdditionScreenViewInternalWidget(
      presenter: presenter,
      navigationBarSizeConfig: const NavigationBarSizeConfig(),
    );
  }
}

@visibleForTesting
class DesktopShoppingListItemAdditionScreenViewInternalWidget extends StatelessWidget {
  const DesktopShoppingListItemAdditionScreenViewInternalWidget({
    required this.presenter,
    required this.navigationBarSizeConfig,
    super.key,
  });

  final ShoppingListItemAdditionScreenPresenter presenter;
  final NavigationBarSizeConfig navigationBarSizeConfig;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      navigationBarMiddle: _buildTitle(),
      navigationBarLeading: AppBackButton(
        onPressed: presenter.onBackButtonPressed,
      ),
      child: _buildScreenBody(),
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

  Widget _buildScreenBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
