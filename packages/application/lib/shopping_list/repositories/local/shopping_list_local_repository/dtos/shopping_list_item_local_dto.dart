import 'package:equatable/equatable.dart';

class ShoppingListItemLocalDto extends Equatable {
  const ShoppingListItemLocalDto({
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
}
