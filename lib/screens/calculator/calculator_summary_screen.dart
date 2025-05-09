import 'package:flutter/material.dart';
import 'package:gamraka/core/app_colors.dart';
import 'package:gamraka/core/app_functions.dart';
import 'package:gamraka/screens/calculator/choose_payment_method_screen.dart';
import 'package:gamraka/screens/calculator/cubit/order_cubit.dart';
import 'package:gamraka/screens/navbar/navbar_screen.dart';

class CalculatorSummaryScreen extends StatelessWidget {
  const CalculatorSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Summary")),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: context.width,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: .3),
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.all(24),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shipping Information",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  Text(
                    "From ${OrderCubit.get(context).from?.name} - ${OrderCubit.get(context).from?.address}",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),

                  Text(
                    "To ${OrderCubit.get(context).to?.name} - ${OrderCubit.get(context).to?.address}",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            ),

            Container(
              width: context.width,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Item Description",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  Text(
                    "${OrderCubit.get(context).itemName}",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),

                  Text(
                    "Price : ${OrderCubit.get(context).itemPrice}",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),

                  Text(
                    "Category : ${OrderCubit.get(context).category!.name}",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Summary",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Customs", style: TextStyle(color: Colors.grey)),
                      Text(
                        "${((OrderCubit.get(context).category!.fees! / 100) * OrderCubit.get(context).itemPrice!)} LE",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Taxes", style: TextStyle(color: Colors.grey)),
                      Text(
                        "${(OrderCubit.get(context).itemPrice! * .14).toStringAsFixed(2)} LE",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Shipping Cost",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        "${((OrderCubit.get(context).route!.cost!) + (OrderCubit.get(context).weight! * 5)).toStringAsFixed(2)} LE",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total", style: TextStyle(color: Colors.black)),
                      Text(
                        "${OrderCubit.get(context).total} LE",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Row(
              spacing: 10,
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      context.goOffAll(NavbarScreen());
                    },
                    height: 50,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: AppColors.primary),
                    ),
                    child: Text(
                      "Back To Home",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    onPressed: () async {
                      var pickUpDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 60)),
                        helpText: "Choose Pickup Date",
                        initialDate: DateTime.now(),
                      );
                      if (pickUpDate != null) {
                        context.goToPage(
                          ChoosePaymentMethodScreen(pickUpDate: pickUpDate),
                        );
                      } else {
                        context.showErrorSnack("Please Select Pickup Date");
                      }
                    },
                    height: 50,
                    color: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Make Order",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
