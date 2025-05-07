import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka/core/app_colors.dart';
import 'package:gamraka/core/app_functions.dart';
import 'package:gamraka/screens/orders/cubit/my_orders_cubit.dart';
import 'package:gamraka/screens/orders/track_order_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text("My Orders")),
      body: BlocBuilder<MyOrdersCubit, MyOrdersState>(
        builder: (context, state) {
          if (state is LoadingGetOrdersState) {
            return Center(child: CircularProgressIndicator());
          }
          var orders = MyOrdersCubit.get(context).orders;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SearchBar(
                  leading: Icon(Icons.search),
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                  hintText: "Search with id",
                  onChanged: (value) {
                    MyOrdersCubit.get(context).search(value);
                  },
                ),

                orders.isEmpty
                    ? Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Center(child: Text("No orders!!!")),
                    )
                    : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = orders[index];
                        return Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              spacing: 16,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item.status,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            item.status == "cancelled"
                                                ? Colors.red
                                                : Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "#${item.id.substring(0, 6)}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  spacing: 10,
                                  children: [
                                    Icon(
                                      Icons.pin_drop,
                                      color: AppColors.primary,
                                    ),
                                    Text(
                                      item.from,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Row(
                                  spacing: 10,
                                  children: [
                                    Icon(
                                      Icons.location_history,
                                      color: AppColors.primary,
                                    ),
                                    Text(
                                      item.to,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  spacing: 10,
                                  children: [
                                    Text(
                                      item.itemName,
                                      style: TextStyle(color: Colors.black),
                                    ),

                                    Text(
                                      "${item.itemPrice} EGP",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),

                                if (item.status == "pending")
                                  Text(
                                    "Your Order Now With Admin, you can't track your order",
                                    style: TextStyle(color: Colors.black),
                                  ),

                                if (item.status == "on way")
                                  MaterialButton(
                                    onPressed: () {
                                      context.goToPage(
                                        TrackOrderScreen(
                                          order: item,
                                          createdAt: item.createdAt,
                                          estimatedDeliveryDate: DateTime.parse(
                                            item.statusDesc,
                                          ),
                                        ),
                                      );
                                    },
                                    minWidth: context.screenWidth,
                                    height: 50,
                                    color: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      "Track Order",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),

                                if (item.status == "delivered")
                                  Row(
                                    spacing: 10,
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Your order delivered Successfully",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              "Head to : ${item.to} to receive your order.",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                if (item.status == "received")
                                  Text(
                                    "Your Order Receieved Successfully..",
                                    style: TextStyle(color: Colors.black),
                                  ),

                                if (item.status == "cancelled")
                                  Text(
                                    "Cancellation Reason : ${item.statusDesc}",
                                    style: TextStyle(color: Colors.red),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: orders.length,
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
