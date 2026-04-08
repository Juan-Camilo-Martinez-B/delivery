class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final String preparationTime;
  final String imagePath;
  final List<String> ingredients;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.preparationTime,
    required this.imagePath,
    this.ingredients = const [],
  });
}
