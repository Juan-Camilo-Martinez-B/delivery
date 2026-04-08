import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../providers/food_provider.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment", style: AppTextStyles.subtitle),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/icons/arrow_left.png', width: 24),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Shipping to", style: AppTextStyles.subtitle),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined, color: AppColors.primary),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Home", style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
                        Text("123 Street, New York, NY", style: AppTextStyles.caption),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("Change", style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text("Payment Method", style: AppTextStyles.subtitle),
            const SizedBox(height: 15),
            _buildPaymentMethod(
              icon: Icons.credit_card,
              label: "Credit Card",
              isSelected: true,
            ),
            const SizedBox(height: 10),
            _buildPaymentMethod(
              icon: Icons.paypal,
              label: "PayPal",
              isSelected: false,
            ),
            const SizedBox(height: 10),
            _buildPaymentMethod(
              icon: Icons.wallet,
              label: "Apple Pay",
              isSelected: false,
            ),
            const SizedBox(height: 30),
            Text("Order Summary", style: AppTextStyles.subtitle),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Subtotal", style: AppTextStyles.body),
                Text("\$${foodProvider.cartTotal.toStringAsFixed(2)}", style: AppTextStyles.body),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Delivery Fee", style: AppTextStyles.body),
                Text("\$2.00", style: AppTextStyles.body),
              ],
            ),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total", style: AppTextStyles.subtitle),
                Text(
                  "\$${(foodProvider.cartTotal + 2.00).toStringAsFixed(2)}",
                  style: AppTextStyles.title.copyWith(color: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showSuccessDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text("Pay Now", style: AppTextStyles.button),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod({required IconData icon, required String label, required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? AppColors.primary : AppColors.lightGray),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: isSelected ? AppColors.primary : AppColors.textSecondary),
          const SizedBox(width: 15),
          Text(label, style: AppTextStyles.body.copyWith(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
          const Spacer(),
          if (isSelected) const Icon(Icons.check_circle, color: AppColors.primary),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Image.asset('assets/icons/check.png', width: 40, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text("Success!", style: AppTextStyles.title),
            const SizedBox(height: 10),
            Text(
              "Your order has been placed successfully. We'll deliver it soon!",
              textAlign: TextAlign.center,
              style: AppTextStyles.body,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text("Back to Home", style: AppTextStyles.button),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
