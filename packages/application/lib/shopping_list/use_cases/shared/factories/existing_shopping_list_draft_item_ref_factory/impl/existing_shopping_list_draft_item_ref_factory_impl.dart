import 'package:domain/shopping_list/entities/existing_shopping_list_draft_item.dart';
import 'package:injectable/injectable.dart';

import '../../../refs/existing_shopping_list_draft_item_ref/existing_shopping_list_draft_item_ref.dart';
import '../../../refs/existing_shopping_list_draft_item_ref/impl/existing_shopping_list_draft_item_ref_impl.dart';
import '../../shopping_list_item_title_validation_error_output_dto_factory/shopping_list_item_title_validation_error_output_dto_factory.dart';
import '../existing_shopping_list_draft_item_ref_factory.dart';

@LazySingleton(as: ExistingShoppingListDraftItemRefFactory)
class ExistingShoppingListDraftItemRefFactoryImpl
    implements ExistingShoppingListDraftItemRefFactory {
  const ExistingShoppingListDraftItemRefFactoryImpl({
    required ShoppingListItemTitleValidationErrorOutputDtoFactory
    shoppingListItemTitleValidationErrorOutputDtoFactory,
  }) : _shoppingListItemTitleValidationErrorOutputDtoFactory =
           shoppingListItemTitleValidationErrorOutputDtoFactory;

  final ShoppingListItemTitleValidationErrorOutputDtoFactory
  _shoppingListItemTitleValidationErrorOutputDtoFactory;

  @override
  ExistingShoppingListDraftItemRef createRef({
    required ExistingShoppingListDraftItem existingShoppingListDraftItem,
  }) {
    return ExistingShoppingListDraftItemRefImpl(
      entity: existingShoppingListDraftItem,
      shoppingListItemTitleValidationErrorOutputDtoFactory:
          _shoppingListItemTitleValidationErrorOutputDtoFactory,
    );
  }
}
