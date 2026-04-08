import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../domain/entities/product.dart';
import '../pages/product_detail_page.dart';
import '../providers/food_provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodProvider>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Expanded(
              child: Center(
                child: Image.asset(product.imagePath, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.star, size: 14, color: AppColors.accent),
                const SizedBox(width: 4),
                Text(
                  product.rating.toString(),
                  style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => foodProvider.toggleFavorite(product.id),
                  child: Image.asset(
                    foodProvider.isFavorite(product.id)
                        ? 'assets/icons/heart_filled.png'
                        : 'assets/icons/heart.png',
                    width: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
