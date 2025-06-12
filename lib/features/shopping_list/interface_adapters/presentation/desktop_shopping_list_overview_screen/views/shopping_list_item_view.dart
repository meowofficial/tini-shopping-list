import 'package:equatable/equatable.dart';

class ShoppingListItemView extends Equatable {
  const ShoppingListItemView({
    required this.id,
    required this.title,
    required this.checked,
  });

  final String id;
  final String title;
  final bool checked;

  @override
  List<Object?> get props {
    return [
      id,
      title,
      checked,
    ];
  }

  ShoppingListItemView copyWith({
    String Function()? id,
    String Function()? title,
    bool Function()? checked,
  }) {
    return ShoppingListItemView(
      id: id == null ? this.id : id(),
      title: title == null ? this.title : title(),
      checked: checked == null ? this.checked : checked(),
    );
  }
}
