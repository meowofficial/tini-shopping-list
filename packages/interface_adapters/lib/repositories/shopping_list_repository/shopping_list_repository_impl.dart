import 'package:application/shopping_list/repositories/local/shopping_list_local_repository/dtos/shopping_list_item_local_dto.dart';
import 'package:application/shopping_list/repositories/local/shopping_list_local_repository/shopping_list_local_repository.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ShoppingListLocalRepository)
class ShoppingListLocalRepositoryImpl implements ShoppingListLocalRepository {
  const ShoppingListLocalRepositoryImpl();

  @override
  Future<IList<ShoppingListItemLocalDto>> getShoppingListItemDtos() async {
    await Future.delayed(const Duration(seconds: 1));
    return const IListConst<ShoppingListItemLocalDto>([]);
  }
}
