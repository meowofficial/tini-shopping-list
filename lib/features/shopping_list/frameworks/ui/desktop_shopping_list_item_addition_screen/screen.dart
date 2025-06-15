import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/frameworks/ui/ui_kit/back_button.dart';
import '../../../../../core/frameworks/ui/ui_kit/navigation_bar_title_widget.dart';
import '../../../../../core/frameworks/ui/utils/view_stream_builder.dart';
import '../../../../../injection_container.dart';
import '../../../interface_adapters/presentation/desktop_shopping_list_item_addition_screen/interfaces/shopping_list_item_addition_screen_presenter.dart';
import '../../../interface_adapters/presentation/desktop_shopping_list_item_addition_screen/presenters/shopping_list_item_addition_screen_presenter.dart';
import 'widgets/shopping_list_item_title_text_field.dart';

class DesktopShoppingListItemAdditionScreen extends StatefulWidget {
  const DesktopShoppingListItemAdditionScreen({
    super.key,
  });

  @override
  State<DesktopShoppingListItemAdditionScreen> createState() =>
      _DesktopShoppingListItemAdditionScreenState();
}

class _DesktopShoppingListItemAdditionScreenState
    extends State<DesktopShoppingListItemAdditionScreen> {
  late final ShoppingListItemAdditionScreenPresenter _presenter;

  @override
  void initState() {
    super.initState();

    _presenter = ShoppingListItemAdditionScreenPresenterImpl(
      cancelShoppingListItemAddition: di(),
      completeShoppingListItemAddition: di(),
      readShoppingListItemAdditionFlowState: di(),
      updateNewShoppingListDraftItemTitle: di(),
      watchShoppingListItemAdditionFlowState: di(),
    );
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff2f2f7),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
        automaticallyImplyMiddle: false,
        padding: EdgeInsetsDirectional.zero,
        middle: const NavigationBarTitleWidget(
          title: 'Добавление элемента',
        ),
        leading: AppBackButton(
          onPressed: _presenter.onBackButtonPressed,
        ),
      ),
      child: SizedBox.expand(
        child: _buildScreenBody(
          context: context,
        ),
      ),
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
                viewStreamable: _presenter,
                converter: (view) => view.shoppingListItemAdditionInputText,
                builder: (context, shoppingListItemAdditionInputText) {
                  return ShoppingListItemTitleTextField(
                    title: shoppingListItemAdditionInputText,
                    onTextChanged: _presenter.onShoppingListItemTitleInputTextChanged,
                  );
                },
              ),
              const SizedBox(height: 20),
              ConverterViewStreamBuilder(
                viewStreamable: _presenter,
                converter: (view) => view.submissionButtonEnabled,
                builder: (context, submissionButtonEnabled) {
                  return CupertinoButton.filled(
                    onPressed: submissionButtonEnabled
                        ? _presenter.onShoppingListItemSubmissionButtonPressed
                        : null,
                    child: const Text('Добавить'),
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
