import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka/core/app_functions.dart';
import 'package:gamraka/screens/calculator/calculator_summary_screen.dart';
import 'package:gamraka/screens/calculator/cubit/order_cubit.dart';
import 'package:gamraka/screens/home/models/category_model.dart';

import '../../core/app_colors.dart';
import 'models/country_model.dart';

class CalculatorFormScreen extends StatefulWidget {
  CalculatorFormScreen({super.key, required this.cateogry});
  final CategoryModel cateogry;

  @override
  State<CalculatorFormScreen> createState() => _CalculatorFormScreenState();
}

class _CalculatorFormScreenState extends State<CalculatorFormScreen> {
  final itemNameController = TextEditingController();

  final itemDescController = TextEditingController();

  final itemPriceController = TextEditingController();

  final weightController = TextEditingController();

  final globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    OrderCubit.get(context).getCountries();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculate Shipping")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                //! ------------------- From Country ------------------!
                Row(children: [Text("Shipment Origin")]),
                SizedBox(height: 5),
                BlocBuilder<OrderCubit, OrderState>(
                  builder: (context, state) {
                    return state is LoadingCountriesState
                        ? Center(child: CircularProgressIndicator())
                        : DropdownButtonFormField<CountryModel>(
                          onChanged: (value) {
                            OrderCubit.get(context).selectFrom(value);
                          },
                          items:
                              OrderCubit.get(context).countries.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text("${e.name} - ${e.address}"),
                                );
                              }).toList(),
                          decoration: InputDecoration(
                            hintText: "",
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return "From Country is required";
                            }

                            return null;
                          },
                        );
                  },
                ),
                SizedBox(height: context.screenHeight * .02),

                //! ------------------- To Country ------------------!
                Row(children: [Text("Shipment Destination")]),
                SizedBox(height: 5),
                BlocBuilder<OrderCubit, OrderState>(
                  builder: (context, state) {
                    return state is LoadingCountriesState
                        ? Center(child: CircularProgressIndicator())
                        : DropdownButtonFormField<CountryModel>(
                          onChanged: (value) {
                            OrderCubit.get(context).selectTo(value);
                          },
                          items: [
                            DropdownMenuItem(
                              value: OrderCubit.get(context).egypt,
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/egypt_flag.png",
                                    width: 75,
                                    height: 40,
                                  ),
                                  Text(
                                    "${OrderCubit.get(context).egypt!.name} - ${OrderCubit.get(context).egypt!.address}",
                                  ),
                                ],
                              ),
                            ),
                          ],
                          decoration: InputDecoration(
                            hintText: "",
                            enabled: false,
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return "To Country is required";
                            }
                            if (value == OrderCubit.get(context).from) {
                              return "From and To Country can't be same";
                            }

                            return null;
                          },
                        );
                  },
                ),
                SizedBox(height: context.screenHeight * .02),

                //! ------------------- Item Name ------------------!
                Row(children: [Text("Item Name")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: itemNameController,
                  decoration: InputDecoration(
                    hintText: "",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Item Name is required";
                    }

                    return null;
                  },
                ),
                SizedBox(height: context.screenHeight * .02),

                //! ------------------- Item Desc ------------------!
                Row(children: [Text("Item Description")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: itemDescController,
                  decoration: InputDecoration(
                    hintText: "",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Item Description is required";
                    }

                    return null;
                  },
                ),
                SizedBox(height: context.screenHeight * .02),

                //! ------------------- Item Price ------------------!
                Row(children: [Text("Item Price")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: itemPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffix: Text("EGP"),
                    hintText: "",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Item Price is required";
                    }

                    return null;
                  },
                ),
                SizedBox(height: context.screenHeight * .02),

                //! ------------------- Weight ------------------!
                Row(children: [Text("Weight in KGS")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "",
                    suffix: Text("KGS"),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Weight is required";
                    }

                    return null;
                  },
                ),
                SizedBox(height: context.screenHeight * .02),

                BlocConsumer<OrderCubit, OrderState>(
                  listener: (context, state) {
                    if (state is SuccessCalculateState) {
                      context.showSuccessSnack("Calculated Successfully");
                      context.goToPage(CalculatorSummaryScreen());
                    } else if (state is ErrorCalculateState) {
                      context.showErrorSnack("Error, Please try again");
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadingCalculateState) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return MaterialButton(
                      onPressed: () {
                        if (globalKey.currentState?.validate() ?? false) {
                          OrderCubit.get(context).calculate(
                            n: itemNameController.text,
                            p: num.parse(itemPriceController.text),
                            d: itemDescController.text,
                            w: num.parse(weightController.text),
                            c: widget.cateogry,
                          );
                        }
                      },
                      minWidth: context.screenWidth * .6,
                      height: 50,
                      color: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Continue",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
