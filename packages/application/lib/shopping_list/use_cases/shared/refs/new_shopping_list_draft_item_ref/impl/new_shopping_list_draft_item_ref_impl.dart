import 'package:domain/shopping_list/entities/new_shopping_list_draft_item.dart';

import '../../../../../../core/use_cases/shared/refs/base_entity_ref.dart';
import '../../../factories/shopping_list_item_title_validation_error_output_dto_factory/shopping_list_item_title_validation_error_output_dto_factory.dart';
import '../new_shopping_list_draft_item_ref.dart';

class NewShoppingListDraftItemRefImpl
    extends BaseEntityRef<NewShoppingListDraftItemSnapshot, NewShoppingListDraftItemRefSnapshot>
    implements NewShoppingListDraftItemRef {
  NewShoppingListDraftItemRefImpl({
    required super.entity,
    required ShoppingListItemTitleValidationErrorOutputDtoFactory
    shoppingListItemTitleValidationErrorOutputDtoFactory,
  }) : _shoppingListItemTitleValidationErrorOutputDtoFactory =
           shoppingListItemTitleValidationErrorOutputDtoFactory;

  final ShoppingListItemTitleValidationErrorOutputDtoFactory
  _shoppingListItemTitleValidationErrorOutputDtoFactory;

  @override
  NewShoppingListDraftItemRefSnapshot createSnapshot(
    NewShoppingListDraftItemSnapshot entitySnapshot,
  ) {
    final titleValidationErrorOutputDto = _shoppingListItemTitleValidationErrorOutputDtoFactory
        .createNullableDto(
          shoppingListItemTitleValidationError: entitySnapshot.titleValidationError,
        );

    return NewShoppingListDraftItemRefSnapshot(
      title: entitySnapshot.title,
      titleValidationError: titleValidationErrorOutputDto,
    );
  }
}
