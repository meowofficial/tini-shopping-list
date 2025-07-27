import 'package:flutter/widgets.dart';

mixin TextEditingControllerSyncMixin {
  @protected
  void ensureTextEditingControllerTextMatches({
    required TextEditingController textEditingController,
    required String text,
  }) {
    if (textEditingController.text != text) {
      textEditingController.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(
          offset: text.length,
        ),
      );
    }
  }
}
