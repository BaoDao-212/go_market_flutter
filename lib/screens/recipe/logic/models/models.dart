import 'package:equatable/equatable.dart';
import 'package:shop_app/screens/recipe/logic/models/member.dart';

class RecipeModel extends Equatable {
  final List<Recipe> recipe;

  RecipeModel({
    required this.recipe,
  });

  RecipeModel copyWith({
    List<Recipe>? recipe,
  }) {
    return RecipeModel(
      recipe: recipe ?? this.recipe,
    );
  }

  @override
  List<Object?> get props => [recipe];
}
