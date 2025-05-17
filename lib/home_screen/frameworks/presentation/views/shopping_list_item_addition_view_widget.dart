import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/home_screen/application/interfaces/shopping_list_item_addition_presenter.dart';

import '../../../application/interfaces/shopping_list_item_addition_view.dart';

class ShoppingListItemAdditionViewWidget extends StatefulWidget {
  const ShoppingListItemAdditionViewWidget({
    required this.presenter,
    required this.onSubmitted,
    super.key,
  });

  final ShoppingListItemAdditionPresenter presenter;
  final VoidCallback onSubmitted;

  @override
  State<ShoppingListItemAdditionViewWidget> createState() =>
      _ShoppingListItemAdditionViewWidgetState();
}

class _ShoppingListItemAdditionViewWidgetState
    extends State<ShoppingListItemAdditionViewWidget>
    implements ShoppingListItemAdditionView {
  late final TextEditingController _textEditingController;
  late final StreamSubscription<void> _presenterUpdateStreamSubscription;

  void _onPresenterUpdated() {
    if (_textEditingController.text != title) {
      _textEditingController.value = TextEditingValue(
        text: title,
        selection: TextSelection.collapsed(
          offset: title.length,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController();

    _textEditingController.addListener(() {
      _presenter.changeTitle(_textEditingController.text);
    });

    _presenterUpdateStreamSubscription = _presenter.updateStream.listen((_) {
      _onPresenterUpdated();
    });
  }

  @override
  void dispose() {
    _presenterUpdateStreamSubscription.cancel();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 1.0,
          width: double.infinity,
          color: Theme.of(context).primaryColor,
        ),
        CupertinoTextField(
          controller: _textEditingController,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            letterSpacing: 0.2,
            height: 1.0,
            color: Colors.black,
            fontSize: 20,
          ),
          autofocus: true,
          autocorrect: true,
          enableSuggestions: true,
          enableInteractiveSelection: true,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          keyboardAppearance: Brightness.light,
          cursorColor: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          onSubmitted: (_) {
            widget.onSubmitted();
          },
          autofillHints: null,
          maxLines: 1,
        ),
      ],
    );
  }

  ShoppingListItemAdditionPresenter get _presenter => widget.presenter;

  @override
  String get title => _presenter.title;
}
