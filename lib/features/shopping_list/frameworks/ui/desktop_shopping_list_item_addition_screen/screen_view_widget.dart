import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/frameworks/ui/ui_kit/back_button.dart';
import '../../../../../core/frameworks/ui/ui_kit/navigation_bar_title_widget.dart';
import '../../../../../core/frameworks/ui/utils/view_stream_builder.dart';
import '../../../interface_adapters/presentation/desktop_shopping_list_item_addition_screen/screen/interfaces/shopping_list_item_addition_screen_presenter.dart';
import 'widgets/shopping_list_item_title_text_field.dart';

class DesktopShoppingListItemAdditionScreenViewWidget extends StatelessWidget {
  const DesktopShoppingListItemAdditionScreenViewWidget({
    required this.presenter,
    super.key,
  });

  final ShoppingListItemAdditionScreenPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff2f2f7),
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
        automaticallyImplyMiddle: false,
        automaticBackgroundVisibility: false,
        padding: EdgeInsetsDirectional.zero,
        middle: _buildTitle(),
        leading: AppBackButton(
          onPressed: presenter.onBackButtonPressed,
        ),
      ),
      child: SizedBox.expand(
        child: _buildScreenBody(
          context: context,
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
        );
      },
    );
  }

  Widget _buildScreenBody({
    required BuildContext context,
  }) {
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
