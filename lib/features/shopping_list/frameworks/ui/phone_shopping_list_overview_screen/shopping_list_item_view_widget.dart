import 'package:flutter/material.dart' hide ViewBuilder;

import '../../../../../core/frameworks/ui/utils/view_stream_builder.dart';
import '../../../interface_adapters/presentation/phone_shopping_list_overview_screen/interfaces/shopping_list_item_presenter.dart';
import '../../../interface_adapters/presentation/phone_shopping_list_overview_screen/views/shopping_list_item_view.dart';

class ShoppingListItemViewWidget extends StatelessWidget {
  const ShoppingListItemViewWidget({
    required ShoppingListItemPresenter presenter,
    super.key,
  }) : _presenter = presenter;

  final ShoppingListItemPresenter _presenter;

  @override
  Widget build(BuildContext context) {
    return ViewStreamBuilder<ShoppingListItemView>(
      viewStreamable: _presenter,
      builder: (context, view) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Colors.white,
            constraints: const BoxConstraints(
              minHeight: 43.5,
            ),
            child: Row(
              children: [
                Checkbox(
                  value: view.checked,
                  onChanged: (_) {
                    _presenter.onCheckboxPressed();
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  splashRadius: 0,
                  activeColor: Colors.pink,
                  checkColor: Colors.white,
                  autofocus: false,
                  side: const BorderSide(
                    width: 1,
                    color: Color(0xff8a8a8e),
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 3,
                      color: Color(0xff8a8a8e),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Text(
                          view.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            height: 1.2,
                            color: Colors.black,
                            fontSize: 17.5,
                            letterSpacing: 0.2,
                          ),
                          textWidthBasis: TextWidthBasis.longestLine,
                          textHeightBehavior: const TextHeightBehavior(
                            applyHeightToFirstAscent: false,
                            applyHeightToLastDescent: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
