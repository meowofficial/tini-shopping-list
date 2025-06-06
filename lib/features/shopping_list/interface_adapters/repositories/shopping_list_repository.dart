import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../application/repositories/shopping_list_repository.dart';
import '../../domain/entities/shopping_list_item.dart';

@LazySingleton(as: ShoppingListRepository)
class ShoppingListRepositoryImpl implements ShoppingListRepository {
  const ShoppingListRepositoryImpl();

  @override
  Future<IList<ShoppingListItem>> getShoppingListItems() async {
    await Future.delayed(const Duration(seconds: 1));
    return const IListConst<ShoppingListItem>([]);
  }
}
