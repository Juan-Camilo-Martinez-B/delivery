import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../domain/entities/product.dart';
import '../providers/food_provider.dart';
import 'payment_page.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _portion = 2;
  double _spicy = 0;

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
                  tag: widget.product.id,
                  child: Image.asset(widget.product.imagePath, fit: BoxFit.contain),
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
                          widget.product.name,
                          style: AppTextStyles.title,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => foodProvider.toggleFavorite(widget.product.id),
                        child: Image.asset(
                          foodProvider.isFavorite(widget.product.id)
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
                        widget.product.rating.toString(),
                        style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 20),
                      const Icon(Icons.timer_outlined, size: 16, color: AppColors.textSecondary),
                      const SizedBox(width: 5),
                      Text(
                        widget.product.preparationTime,
                        style: AppTextStyles.body,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.product.description,
                    style: AppTextStyles.body.copyWith(height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Spicy", style: AppTextStyles.subtitle),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 160,
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: AppColors.primary,
                                inactiveTrackColor: AppColors.lightGray,
                                thumbColor: AppColors.primary,
                                trackHeight: 4,
                              ),
                              child: Slider(
                                value: _spicy,
                                min: 0,
                                max: 2,
                                divisions: 2,
                                onChanged: (v) => setState(() => _spicy = v),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 160,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Mild", style: AppTextStyles.caption),
                                    Text("Hot", style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Portion", style: AppTextStyles.subtitle),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _circleIconButton(icon: Icons.remove, onTap: () => setState(() => _portion = (_portion - 1).clamp(1, 99))),
                              const SizedBox(width: 12),
                              Container(
                                width: 38,
                                height: 38,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.lightGray,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text("$_portion", style: AppTextStyles.subtitle),
                              ),
                              const SizedBox(width: 12),
                              _circleIconButton(icon: Icons.add, onTap: () => setState(() => _portion = (_portion + 1).clamp(1, 99))),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 110),
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
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  "\$${widget.product.price.toStringAsFixed(2)}",
                  style: AppTextStyles.button,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    foodProvider.addToCart(widget.product);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text("ORDER NOW", style: AppTextStyles.button),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleIconButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
