import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka/core/app_colors.dart';
import 'package:gamraka/core/app_functions.dart';
import 'package:gamraka/core/cache_helper.dart';
import 'package:gamraka/screens/calculator/cubit/order_cubit.dart';
import 'package:gamraka/screens/calculator/order_success_screen.dart';
import 'package:gamraka/screens/payment_methods/models/payment_model.dart';

import '../payment_methods/add_payment_method_screen.dart';

class ChoosePaymentMethodScreen extends StatefulWidget {
  const ChoosePaymentMethodScreen({super.key, required this.pickUpDate});

  final DateTime pickUpDate;

  @override
  State<ChoosePaymentMethodScreen> createState() =>
      _ChoosePaymentMethodScreenState();
}

class _ChoosePaymentMethodScreenState extends State<ChoosePaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    var paymentMethods = CacheHelper.getPaymentMethods();

    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Payment Method and\nVerification Image"),
      ),
      body: BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) {
          if (state is SuccessMakeOrderState) {
            context.showSuccessSnack("Order Made Successfully");
            context.goToPage(OrderSuccessScreen());
          } else if (state is ErrorMakeOrderState) {
            context.showErrorSnack(
              "Error, please make sure you choose image and payment method",
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        child: RadioListTile<PaymentModel>(
                          controlAffinity: ListTileControlAffinity.trailing,
                          activeColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          selected:
                              paymentMethods[index] ==
                              OrderCubit.get(context).method,
                          selectedTileColor: AppColors.primary,
                          title: Row(
                            spacing: 10,
                            children: [
                              Icon(
                                Icons.wallet,
                                color:
                                    paymentMethods[index] ==
                                            OrderCubit.get(context).method
                                        ? Colors.white
                                        : AppColors.primary,
                              ),
                              Text(
                                "xxxx xxxx xxxx ${paymentMethods[index].cardNumber!.substring(12)}",
                              ),
                            ],
                          ),

                          value: paymentMethods[index],
                          groupValue: OrderCubit.get(context).method,
                          onChanged: (value) {
                            OrderCubit.get(context).selectPaymenthMethod(value);
                          },
                        ),
                      );
                    },
                    itemCount: paymentMethods.length,
                  ),

                  InkWell(
                    onTap: () async {
                      await context.goToPage(AddPaymentMethodScreen());
                      paymentMethods = CacheHelper.getPaymentMethods();
                      setState(() {});
                    },
                    child: Container(
                      width: context.width,
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
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
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Card(
                    child: RadioListTile<PaymentModel?>(
                      controlAffinity: ListTileControlAffinity.trailing,
                      activeColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      selected: OrderCubit.get(context).method == null,
                      selectedTileColor: AppColors.primary,
                      title: Row(
                        spacing: 10,
                        children: [
                          Icon(
                            Icons.monetization_on,
                            color:
                                OrderCubit.get(context).method == null
                                    ? Colors.white
                                    : AppColors.primary,
                          ),
                          Text("Cash"),
                        ],
                      ),
                      value: null,
                      groupValue: OrderCubit.get(context).method,
                      onChanged: (value) {
                        OrderCubit.get(context).selectPaymenthMethod(null);
                      },
                    ),
                  ),

                  SizedBox(height: 50),
                  state is LoadingMakeOrderState
                      ? Center(child: CircularProgressIndicator())
                      : MaterialButton(
                        onPressed: () {
                          OrderCubit.get(context).makeOrder(widget.pickUpDate);
                        },
                        minWidth: context.screenWidth,
                        height: 50,
                        color: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Checkout",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
