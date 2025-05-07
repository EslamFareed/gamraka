import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka/core/app_functions.dart';
import 'package:gamraka/core/cache_helper.dart';
import 'package:gamraka/screens/home/cubit/home_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gamraka/screens/orders/cubit/my_orders_cubit.dart';
import 'package:gamraka/screens/orders/track_order_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_colors.dart';
import '../calculator/calculator_form_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    HomeCubit.get(context).getSliders();
    MyOrdersCubit.get(context).getOrders();
    controller.clear();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is LoadingHomeState) {
          return Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                //! Welcome
                SizedBox(height: context.height * .05),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(24),
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        image: DecorationImage(
                          image: NetworkImage(CacheHelper.getImage()),
                        ),
                      ),
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.black12,
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, ${CacheHelper.getName()}!",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Good Morning!",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),

                //! Track search
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: SearchBar(
                          controller: controller,
                          backgroundColor: WidgetStatePropertyAll(Colors.white),
                          hintText: "Enter order number",
                          leading: Icon(Icons.search, color: Colors.grey),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          if (controller.text.isEmpty ||
                              controller.text.length < 5) {
                            context.showErrorSnack(
                              "Please Enter Order Id to Track, min length is 5 chars",
                            );
                          } else {
                            MyOrdersCubit.get(context).search(controller.text);
                            if (MyOrdersCubit.get(context).orders.isEmpty) {
                              context.showErrorSnack(
                                "This id is wrong, please check again",
                              );
                            } else {
                              if (MyOrdersCubit.get(context).orders[0].status ==
                                  "pending") {
                                context.showErrorSnack(
                                  "You can't track This order currently cause status is Pending",
                                );
                              } else {
                                context.goToPage(
                                  TrackOrderScreen(
                                    createdAt:
                                        MyOrdersCubit.get(
                                          context,
                                        ).orders[0].createdAt,
                                    estimatedDeliveryDate: DateTime.parse(
                                      MyOrdersCubit.get(
                                        context,
                                      ).orders[0].statusDesc,
                                    ),
                                    order: MyOrdersCubit.get(context).orders[0],
                                  ),
                                );
                              }
                            }
                          }
                        },
                        height: 50,
                        color: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Track it",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.height * .02),
                //! Ads
                CarouselSlider.builder(
                  itemCount: HomeCubit.get(context).sliders.length,
                  itemBuilder: (context, index, realIndex) {
                    return InkWell(
                      onTap: () async {
                        final Uri url = Uri.parse(
                          HomeCubit.get(context).sliders[index].link ?? "",
                        );

                        if (!await launchUrl(url)) {
                          throw Exception('Could not launch $url');
                        }
                      },
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            width: context.screenWidth,
                            height: 200, // You can adjust this height as needed
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  HomeCubit.get(context).sliders[index].value ??
                                      "",
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            width: context.screenWidth,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black.withValues(alpha: 0.2),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: .95,
                  ),
                ),

                SizedBox(height: context.height * .02),

                //! Categories
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Text(
                        "Product Category",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        context.goToPage(
                          CalculatorFormScreen(
                            cateogry: HomeCubit.get(context).categories[index],
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.grey.shade100,
                        child: Column(
                          spacing: 4,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              HomeCubit.get(
                                    context,
                                  ).allCategories[index].icon ??
                                  "",
                              width: 50,
                              height: 50,
                            ),
                            Text(
                              HomeCubit.get(
                                    context,
                                  ).allCategories[index].name ??
                                  "",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: HomeCubit.get(context).allCategories.length,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
