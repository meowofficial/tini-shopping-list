import 'package:flutter/material.dart';

import '../../../application/interfaces/shopping_list_item_presenter.dart';
import '../../../application/interfaces/shopping_list_item_view.dart';

class ShoppingListItemViewWidget extends StatelessWidget
    implements ShoppingListItemView {
  const ShoppingListItemViewWidget({
    required ShoppingListItemPresenter presenter,
    super.key,
  }) : _presenter = presenter;

  final ShoppingListItemPresenter _presenter;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<void>(
      stream: _presenter.updateStream,
      builder: (context, _) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Colors.white,
            constraints: BoxConstraints(
              minHeight: 43.5,
            ),
            child: Row(
              children: [
                Checkbox(
                  value: checked,
                  onChanged: (selected) {
                    _presenter.onCheckboxPressed();
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  splashRadius: 0,
                  activeColor: Colors.pink,
                  checkColor: Colors.white,
                  autofocus: false,
                  side: BorderSide(
                    width: 1,
                    color: Color(0xff8a8a8e),
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
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
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.2,
                            color: Colors.black,
                            fontSize: 17.5,
                            letterSpacing: 0.2,
                          ),
                          textWidthBasis: TextWidthBasis.longestLine,
                          textHeightBehavior: TextHeightBehavior(
                            applyHeightToFirstAscent: false,
                            applyHeightToLastDescent: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  bool get checked => _presenter.checked;

  @override
  String get title => _presenter.title;
}
