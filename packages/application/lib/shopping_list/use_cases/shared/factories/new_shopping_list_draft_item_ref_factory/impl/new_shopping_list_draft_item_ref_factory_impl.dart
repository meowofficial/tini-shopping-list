import 'package:domain/shopping_list/entities/new_shopping_list_draft_item.dart';
import 'package:injectable/injectable.dart';

import '../../../refs/new_shopping_list_draft_item_ref/impl/new_shopping_list_draft_item_ref_impl.dart';
import '../../../refs/new_shopping_list_draft_item_ref/new_shopping_list_draft_item_ref.dart';
import '../../shopping_list_item_title_validation_error_output_dto_factory/shopping_list_item_title_validation_error_output_dto_factory.dart';
import '../new_shopping_list_draft_item_ref_factory.dart';

@LazySingleton(as: NewShoppingListDraftItemRefFactory)
class NewShoppingListDraftItemRefFactoryImpl implements NewShoppingListDraftItemRefFactory {
  const NewShoppingListDraftItemRefFactoryImpl({
    required ShoppingListItemTitleValidationErrorOutputDtoFactory
    shoppingListItemTitleValidationErrorOutputDtoFactory,
  }) : _shoppingListItemTitleValidationErrorOutputDtoFactory =
           shoppingListItemTitleValidationErrorOutputDtoFactory;

  final ShoppingListItemTitleValidationErrorOutputDtoFactory
  _shoppingListItemTitleValidationErrorOutputDtoFactory;

  @override
  NewShoppingListDraftItemRef createRef({
    required NewShoppingListDraftItem newShoppingListDraftItem,
  }) {
    return NewShoppingListDraftItemRefImpl(
      entity: newShoppingListDraftItem,
      shoppingListItemTitleValidationErrorOutputDtoFactory:
          _shoppingListItemTitleValidationErrorOutputDtoFactory,
    );
  }
}
