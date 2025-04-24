import 'dart:math';

import 'package:uuid/uuid.dart';

class Recipe {
  final String id;
  final String name;
  final Duration preparationTime;
  final bool isFavorite;
  final String imagePath;
  final List<String> ingredients;
  final List<String> instructions;

  const Recipe({
    required this.id,
    required this.name,
    required this.preparationTime,
    this.ingredients = const [],
    this.instructions = const [],
    this.isFavorite = false,
    this.imagePath = "assets/food1.jpg",
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json["id"] ?? Uuid().v1(),
      name: json["name"] ?? "Unknown",
      preparationTime: Duration(minutes: json["preparationTime"] ?? 0),
      imagePath: "assets/food${Random().nextInt(6)}.jpg",
      ingredients: List<String>.from(json["ingredients"] ?? []),
      instructions: List<String>.from(json["instructions"] ?? []),
    );
  }

  static List<Recipe> listFromJson(list) =>
      List<Recipe>.from(list.map((x) => Recipe.fromJson(x)));

  @override
  String toString() {
    return "Recipe(id: $id, name: $name, preparationTime: $preparationTime,"
        " isFavorite: $isFavorite, imagePath: $imagePath, "
        "ingredients: $ingredients, instructions: $instructions,)";
  }

  Recipe copyWith({
    String? id,
    String? name,
    Duration? preparationTime,
    bool? isFavorite,
    String? imagePath,
    List<String>? ingredients,
    List<String>? instructions,
  }) => Recipe(
    id: id ?? this.id,
    name: name ?? this.name,
    preparationTime: preparationTime ?? this.preparationTime,
    isFavorite: isFavorite ?? this.isFavorite,
    imagePath: imagePath ?? this.imagePath,
    ingredients: ingredients ?? this.ingredients,
    instructions: instructions ?? this.instructions,
  );
}
