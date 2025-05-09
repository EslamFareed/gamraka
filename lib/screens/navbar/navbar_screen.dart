import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka/screens/calculator/calculator_screen.dart';
import 'package:gamraka/screens/home/home_screen.dart';
import 'package:gamraka/screens/navbar/cubit/nav_bar_cubit.dart';
import 'package:gamraka/screens/orders/orders_screen.dart';
import 'package:gamraka/screens/profile/profile_screen.dart';

import '../../core/app_colors.dart';

class NavbarScreen extends StatelessWidget {
  NavbarScreen({super.key});

  List<Widget> screens = [
    HomeScreen(),
    CalculatorScreen(),
    OrdersScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: BlocBuilder<NavBarCubit, int>(
        builder: (context, state) {
          return Scaffold(
            body: screens[state],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: state,
              onTap: (value) {
                NavBarCubit.get(context).changeScreen(value);
              },
              unselectedItemColor: Colors.grey.shade400,
              selectedItemColor: AppColors.primary,
              backgroundColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/home_nav.png",
                    color: Colors.grey.shade400,
                  ),
                  activeIcon: Image.asset(
                    "assets/icons/home_nav.png",
                    color: AppColors.primary,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/calculator_nav.png",
                    color: Colors.grey.shade400,
                  ),
                  activeIcon: Image.asset(
                    "assets/icons/calculator_nav.png",
                    color: AppColors.primary,
                  ),
                  label: "Calculator",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/orrders_nav.png",
                    color: Colors.grey.shade400,
                  ),
                  activeIcon: Image.asset(
                    "assets/icons/orrders_nav.png",
                    color: AppColors.primary,
                  ),
                  label: "Orders",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/profile_nav.png",
                    color: Colors.grey.shade400,
                  ),
                  activeIcon: Image.asset(
                    "assets/icons/profile_nav.png",
                    color: AppColors.primary,
                  ),
                  label: "Profile",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
