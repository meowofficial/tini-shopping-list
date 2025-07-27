import 'package:common/stream/snapshot_streamable.dart';
import 'package:equatable/equatable.dart';

abstract interface class ShoppingListItemRef
    implements SnapshotStreamable<ShoppingListItemRefSnapshot> {}

class ShoppingListItemRefSnapshot extends Equatable {
  const ShoppingListItemRefSnapshot({
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
