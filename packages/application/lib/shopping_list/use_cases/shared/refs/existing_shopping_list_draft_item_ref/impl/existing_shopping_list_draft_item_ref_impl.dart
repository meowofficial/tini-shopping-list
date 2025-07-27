import 'package:domain/shopping_list/entities/existing_shopping_list_draft_item.dart';

import '../../../../../../core/use_cases/shared/refs/base_entity_ref.dart';
import '../../../factories/shopping_list_item_title_validation_error_output_dto_factory/shopping_list_item_title_validation_error_output_dto_factory.dart';
import '../existing_shopping_list_draft_item_ref.dart';

class ExistingShoppingListDraftItemRefImpl
    extends
        BaseEntityRef<
          ExistingShoppingListDraftItemSnapshot,
          ExistingShoppingListDraftItemRefSnapshot
        >
    implements ExistingShoppingListDraftItemRef {
  ExistingShoppingListDraftItemRefImpl({
    required super.entity,
    required ShoppingListItemTitleValidationErrorOutputDtoFactory
    shoppingListItemTitleValidationErrorOutputDtoFactory,
  }) : _shoppingListItemTitleValidationErrorOutputDtoFactory =
           shoppingListItemTitleValidationErrorOutputDtoFactory;

  final ShoppingListItemTitleValidationErrorOutputDtoFactory
  _shoppingListItemTitleValidationErrorOutputDtoFactory;

  @override
  ExistingShoppingListDraftItemRefSnapshot createSnapshot(
    ExistingShoppingListDraftItemSnapshot entitySnapshot,
  ) {
    final titleValidationErrorOutputDto = _shoppingListItemTitleValidationErrorOutputDtoFactory
        .createNullableDto(
          shoppingListItemTitleValidationError: entitySnapshot.titleValidationError,
        );

    return ExistingShoppingListDraftItemRefSnapshot(
      id: entitySnapshot.id,
      title: entitySnapshot.title,
      titleValidationError: titleValidationErrorOutputDto,
    );
  }
}
