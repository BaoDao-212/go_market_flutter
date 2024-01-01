import 'package:equatable/equatable.dart';
import 'package:shop_app/screens/fridge/logic/models/member.dart';

class FridgeModel extends Equatable {
  final List<Fridge> fridge;

  FridgeModel({
    required this.fridge,
  });

  FridgeModel copyWith({
    List<Fridge>? fridge,
  }) {
    return FridgeModel(
      fridge: fridge ?? this.fridge,
    );
  }

  @override
  List<Object?> get props => [fridge];
}
