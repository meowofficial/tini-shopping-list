import 'package:flutter/material.dart';
import 'package:interface_adapters/presentation/phone_shopping_list_overview_screen/screen/presenters/shopping_list_item_presenter/shopping_list_item_presenter.dart';
import 'package:interface_adapters/presentation/phone_shopping_list_overview_screen/screen/views/shopping_list_item_view.dart';

import '../../../core/theme/app_styles.dart';
import '../../../core/theme/core_theme.dart';
import '../../../core/ui_kit/checkbox.dart';
import '../../../core/utils/view_stream_builder.dart';

class ShoppingListItemViewWidget extends StatelessWidget {
  const ShoppingListItemViewWidget({
    required this.presenter,
    super.key,
  });

  final ShoppingListItemPresenter presenter;

  @override
  Widget build(BuildContext context) {
    final brightness = CoreTheme.brightnessOf(context);

    return ViewStreamBuilder<ShoppingListItemView>(
      viewStreamable: presenter,
      builder: (context, view) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: switch (brightness) {
              Brightness.dark => AppStyles.darkGrey3,
              Brightness.light => AppStyles.white,
            },
            constraints: const BoxConstraints(
              minHeight: 43.5,
            ),
            child: Row(
              children: [
                AppCheckbox(
                  value: view.checked,
                  onChanged: (_) {
                    presenter.onCheckboxPressed();
                  },
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
                          style: AppStyles.baseTextStyle.copyWith(
                            fontVariations: const [
                              FontVariation.weight(400),
                            ],
                            height: 1.2,
                            color: switch (brightness) {
                              Brightness.dark => AppStyles.white,
                              Brightness.light => AppStyles.black,
                            },
                            fontSize: 17.5,
                            letterSpacing: 0.2,
                          ),
                          textWidthBasis: TextWidthBasis.longestLine,
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
