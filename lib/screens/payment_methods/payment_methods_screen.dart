import 'package:flutter/material.dart';
import 'package:gamraka/core/app_colors.dart';
import 'package:gamraka/core/app_functions.dart';
import 'package:gamraka/core/cache_helper.dart';
import 'package:gamraka/screens/payment_methods/add_payment_method_screen.dart';
import 'package:gamraka/screens/payment_methods/models/payment_model.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  List<PaymentModel> methods = [];
  @override
  Widget build(BuildContext context) {
    methods = CacheHelper.getPaymentMethods();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Payment Methods"),
        backgroundColor: Colors.grey.shade100,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  width: context.width,
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    spacing: 10,
                    children: [
                      Icon(Icons.payment, color: AppColors.primary, size: 25),
                      SizedBox(width: 5),
                      Text(
                        "xxxx xxxx xxxx ${methods[index].cardNumber!.substring(12)}",
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.cancel, color: AppColors.primary),
                      ),
                    ],
                  ),
                );
              },
              itemCount: methods.length,
            ),

            InkWell(
              onTap: () async {
                await context.goToPage(AddPaymentMethodScreen());
                methods = CacheHelper.getPaymentMethods();
                setState(() {});
              },
              child: Container(
                width: context.width,
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  spacing: 10,
                  children: [
                    Icon(Icons.add, color: AppColors.primary),
                    Text("Add New Card"),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 15),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
