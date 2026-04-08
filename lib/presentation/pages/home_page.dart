import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../providers/food_provider.dart';
import '../widgets/category_chip.dart';
import '../widgets/product_card.dart';
import 'customer_support_page.dart';
import 'product_customize_page.dart';
import 'user_profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = "All";
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Foodgo",
                      style: AppTextStyles.logo,
                    ),
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.lightGray,
                    child: const Icon(Icons.person, color: AppColors.textSecondary),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Order your favourite food!",
                style: AppTextStyles.title,
              ),
              const SizedBox(height: 20),
              // Search + Filter
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: AppColors.lightGray,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: AppTextStyles.body,
                          border: InputBorder.none,
                          icon: Image.asset('assets/icons/search.png', width: 20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 46,
                    height: 46,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Image.asset('assets/icons/settings_sliders.png', width: 22, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              // Categories
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryChip(
                      label: "All",
                      isSelected: _selectedCategory == "All",
                      onSelected: () => setState(() => _selectedCategory = "All"),
                    ),
                    CategoryChip(
                      label: "Combos",
                      isSelected: _selectedCategory == "Combos",
                      onSelected: () => setState(() => _selectedCategory = "Combos"),
                    ),
                    CategoryChip(
                      label: "Sliders",
                      isSelected: _selectedCategory == "Sliders",
                      onSelected: () => setState(() => _selectedCategory = "Sliders"),
                    ),
                    CategoryChip(
                      label: "Classic",
                      isSelected: _selectedCategory == "Classic",
                      onSelected: () => setState(() => _selectedCategory = "Classic"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              // Products Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: foodProvider.products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: foodProvider.products[index]);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductCustomizePage()));
        },
        backgroundColor: AppColors.primary,
        elevation: 8,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.primary,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        elevation: 10,
        child: SizedBox(
          height: 64,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => setState(() => _currentIndex = 0),
                      icon: Image.asset('assets/icons/home.png', width: 24, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: () {
                        setState(() => _currentIndex = 2);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerSupportPage()));
                      },
                      icon: Image.asset('assets/icons/comment.png', width: 24, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => setState(() => _currentIndex = 1),
                      icon: Image.asset('assets/icons/heart.png', width: 24, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: () {
                        setState(() => _currentIndex = 3);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const UserProfilePage()));
                      },
                      icon: Image.asset('assets/icons/user.png', width: 24, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
