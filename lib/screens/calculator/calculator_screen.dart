import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka/core/app_functions.dart';
import 'package:gamraka/screens/calculator/calculator_form_screen.dart';

import '../home/cubit/home_cubit.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is LoadingHomeState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Center(child: CircularProgressIndicator())],
                ),
              );
            }
            return Column(
              children: [
                SizedBox(height: context.height * .05),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SearchBar(
                    onChanged: (value) {
                      HomeCubit.get(context).searchCategory(value);
                    },
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    hintText: "Search for Category",
                    leading: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
                SizedBox(height: context.height * .05),

                //! Categories
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Text(
                        "Choose Category",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                HomeCubit.get(context).categories.isEmpty
                    ? Center(child: Text("No Categories Found"))
                    : GridView.builder(
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
                                cateogry:
                                    HomeCubit.get(context).categories[index],
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
                                      ).categories[index].icon ??
                                      "",
                                  width: 50,
                                  height: 50,
                                ),
                                Text(
                                  HomeCubit.get(
                                        context,
                                      ).categories[index].name ??
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
                      itemCount: HomeCubit.get(context).categories.length,
                    ),
              ],
            );
          },
        ),
      ),
    );
  }
}
