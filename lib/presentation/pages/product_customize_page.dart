import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../domain/entities/product.dart';
import '../providers/food_provider.dart';

class ProductCustomizePage extends StatefulWidget {
  const ProductCustomizePage({super.key});

  @override
  State<ProductCustomizePage> createState() => _ProductCustomizePageState();
}

class _ProductCustomizePageState extends State<ProductCustomizePage> {
  int _portion = 2;
  double _spicy = 0;

  final List<String> _toppings = ["Tomato", "Onions", "Pickles", "Bacons"];
  final List<String> _sides = ["Fries", "Coleslaw", "Salad", "Onion"];
  final Set<String> _selectedToppings = {};
  final Set<String> _selectedSides = {};

  double get _basePrice => 16.49;

  double get _total {
    final extras = _selectedToppings.length * 0.5 + _selectedSides.length * 0.75;
    return (_basePrice + extras) * _portion;
  }

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 160),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Customize",
                        style: AppTextStyles.subtitle.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Your Burger to Your Tastes. Ultimate Experience",
                        style: AppTextStyles.body,
                      ),
                      const SizedBox(height: 16),
                      Text("Spicy", style: AppTextStyles.subtitle),
                      SizedBox(
                        width: 180,
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
                      SizedBox(
                        width: 180,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Mild", style: AppTextStyles.caption),
                            Text("Hot", style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text("Portion", style: AppTextStyles.subtitle),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _circleIconButton(icon: Icons.remove, onTap: () => setState(() => _portion = (_portion - 1).clamp(1, 99))),
                          const SizedBox(width: 12),
                          Container(
                            width: 44,
                            height: 44,
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
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 150,
                  height: 180,
                  child: Image.asset('assets/images/product_detail_1.png', fit: BoxFit.contain),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text("Toppings", style: AppTextStyles.subtitle),
            const SizedBox(height: 12),
            SizedBox(
              height: 110,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _toppings.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final name = _toppings[index];
                  final selected = _selectedToppings.contains(name);
                  return _optionCard(
                    label: name,
                    selected: selected,
                    onTap: () {
                      setState(() {
                        if (selected) {
                          _selectedToppings.remove(name);
                        } else {
                          _selectedToppings.add(name);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text("Side options", style: AppTextStyles.subtitle),
            const SizedBox(height: 12),
            SizedBox(
              height: 110,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _sides.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final name = _sides[index];
                  final selected = _selectedSides.contains(name);
                  return _optionCard(
                    label: name,
                    selected: selected,
                    onTap: () {
                      setState(() {
                        if (selected) {
                          _selectedSides.remove(name);
                        } else {
                          _selectedSides.add(name);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
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
                child: Text("\$${_total.toStringAsFixed(2)}", style: AppTextStyles.button),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    final product = Product(
                      id: 'custom',
                      name: "Custom Burger",
                      description: "Customized burger",
                      price: _total,
                      rating: 5,
                      preparationTime: "20 mins",
                      imagePath: "assets/images/product_detail_1.png",
                      ingredients: [..._selectedToppings, ..._selectedSides],
                    );
                    foodProvider.addToCart(product);
                    Navigator.pop(context);
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
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _optionCard({required String label, required bool selected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(color: selected ? AppColors.primary : Colors.transparent, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 48,
                height: 48,
                child: Image.asset(
                  _assetForLabel(label),
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      color: AppColors.lightGray,
                      alignment: Alignment.center,
                      child: Text(label.characters.first, style: AppTextStyles.subtitle),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(label, style: AppTextStyles.caption),
            const SizedBox(height: 6),
            Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, size: 14, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  String _assetForLabel(String label) {
    final key = label.toLowerCase();
    if (['tomato', 'onions', 'pickles', 'bacons'].contains(key)) {
      return 'assets/images/toppings/$key.png';
    }
    if (['fries', 'coleslaw', 'salad', 'onion'].contains(key)) {
      return 'assets/images/sides/$key.png';
    }
    return 'assets/images/toppings/$key.png';
  }
}
