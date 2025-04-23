class Recipe {
  final String id;
  final String name;
  final Duration preparationTime;
  final bool isFavorite;
  final String imagePath;

  Recipe({
    required this.id,
    required this.name,
    required this.preparationTime,
    this.isFavorite = false,
    this.imagePath = "assets/food1.jpg",
  });
}
