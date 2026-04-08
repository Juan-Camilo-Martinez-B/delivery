import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../domain/entities/product.dart';
import '../providers/food_provider.dart';
import 'payment_page.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset('assets/icons/arrow_left.png', width: 20),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset('assets/icons/search.png', width: 20),
                ),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.only(top: 80, bottom: 20),
                color: AppColors.lightGray.withOpacity(0.5),
                child: Hero(
                  tag: product.id,
                  child: Image.asset(product.imagePath, fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: AppTextStyles.title,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => foodProvider.toggleFavorite(product.id),
                        child: Image.asset(
                          foodProvider.isFavorite(product.id)
                              ? 'assets/icons/heart_filled.png'
                              : 'assets/icons/heart.png',
                          width: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: AppColors.accent),
                      const SizedBox(width: 5),
                      Text(
                        product.rating.toString(),
                        style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 20),
                      const Icon(Icons.timer_outlined, size: 16, color: AppColors.textSecondary),
                      const SizedBox(width: 5),
                      Text(
                        product.preparationTime,
                        style: AppTextStyles.body,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    product.description,
                    style: AppTextStyles.body.copyWith(height: 1.5),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    "Ingredients",
                    style: AppTextStyles.subtitle,
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: product.ingredients.map((ingredient) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.lightGray),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(ingredient, style: AppTextStyles.body),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 100), // Space for bottom button
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Price", style: AppTextStyles.caption),
                Text(
                  "\$${product.price.toStringAsFixed(2)}",
                  style: AppTextStyles.title.copyWith(color: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(width: 30),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  foodProvider.addToCart(product);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text("Order Now", style: AppTextStyles.button),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
