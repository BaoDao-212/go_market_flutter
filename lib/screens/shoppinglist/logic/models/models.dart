import 'package:equatable/equatable.dart';
import 'package:shop_app/screens/shoppinglist/logic/models/member.dart';

class ShoppingModel extends Equatable {
  final List<Shopping> shopping;

  ShoppingModel({
    required this.shopping,
  });

  ShoppingModel copyWith({
    List<Shopping>? shopping,
  }) {
    return ShoppingModel(
      shopping: shopping ?? this.shopping,
    );
  }

  @override
  List<Object?> get props => [shopping];
}
