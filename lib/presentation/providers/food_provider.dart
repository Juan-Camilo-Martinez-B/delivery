import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class FoodProvider with ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: '1',
      name: "Cheeseburger Wendy's Burger",
      description: "The Cheeseburger Wendy's Burger is a classic fast food burger that packs a punch of flavor in every bite. Made with a juicy beef patty cooked to perfection, it's topped with melted American cheese, crispy lettuce, ripe tomato, and crunchy pickles.",
      price: 8.24,
      rating: 4.9,
      preparationTime: "26 mins",
      imagePath: "assets/images/product_1.png",
      ingredients: ["Beef Patty", "American Cheese", "Lettuce", "Tomato", "Pickles"],
    ),
    Product(
      id: '2',
      name: "Hamburger Veggie Burger",
      description: "A delicious plant-based alternative with all the flavor of a classic burger.",
      price: 7.50,
      rating: 4.8,
      preparationTime: "20 mins",
      imagePath: "assets/images/product_2.png",
      ingredients: ["Veggie Patty", "Vegan Cheese", "Lettuce", "Onion"],
    ),
    Product(
      id: '3',
      name: "Hamburger Chicken Burger",
      description: "Crispy chicken breast with fresh toppings and special sauce.",
      price: 9.00,
      rating: 4.6,
      preparationTime: "25 mins",
      imagePath: "assets/images/product_3.png",
      ingredients: ["Chicken Breast", "Mayo", "Lettuce", "Tomato"],
    ),
    Product(
      id: '4',
      name: "Hamburger Fried Chicken Burger",
      description: "Extra crispy fried chicken for those who love a good crunch.",
      price: 9.50,
      rating: 4.5,
      preparationTime: "30 mins",
      imagePath: "assets/images/product_4.png",
      ingredients: ["Fried Chicken", "Spicy Mayo", "Coleslaw"],
    ),
  ];

  final List<Product> _cart = [];
  final List<String> _favorites = [];

  List<Product> get products => _products;
  List<Product> get cart => _cart;
  List<String> get favorites => _favorites;

  void addToCart(Product product) {
    _cart.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cart.remove(product);
    notifyListeners();
  }

  void toggleFavorite(String productId) {
    if (_favorites.contains(productId)) {
      _favorites.remove(productId);
    } else {
      _favorites.add(productId);
    }
    notifyListeners();
  }

  bool isFavorite(String productId) => _favorites.contains(productId);

  double get cartTotal => _cart.fold(0, (total, product) => total + product.price);
}
