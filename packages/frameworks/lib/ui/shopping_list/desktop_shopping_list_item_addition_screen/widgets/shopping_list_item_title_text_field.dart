import 'package:flutter/cupertino.dart';

import '../../../core/utils/text_editing_controller_sync_mixin.dart';

class ShoppingListItemTitleTextField extends StatefulWidget {
  const ShoppingListItemTitleTextField({
    required this.title,
    required this.onTextChanged,
    required this.onTextSubmitted,
    super.key,
  });

  final String title;
  final ValueChanged<String> onTextChanged;
  final VoidCallback onTextSubmitted;

  @override
  State<ShoppingListItemTitleTextField> createState() => _ShoppingListItemTitleTextFieldState();
}

class _ShoppingListItemTitleTextFieldState extends State<ShoppingListItemTitleTextField>
    with TextEditingControllerSyncMixin {
  late final TextEditingController _textEditingController;

  void _onTextChanged() {
    widget.onTextChanged(_textEditingController.text);
  }

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController(
      text: widget.title,
    );

    _textEditingController.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(covariant ShoppingListItemTitleTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    ensureTextEditingControllerTextMatches(
      textEditingController: _textEditingController,
      text: widget.title,
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: _textEditingController,
      onSubmitted: (_) {
        widget.onTextSubmitted();
      },
    );
  }
}
