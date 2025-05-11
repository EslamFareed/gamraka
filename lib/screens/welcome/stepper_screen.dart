import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gamraka/core/app_functions.dart';
import 'package:gamraka/screens/welcome/welcome_screen.dart';

import '../../core/app_colors.dart';

class StepperScreen extends StatefulWidget {
  const StepperScreen({super.key});

  @override
  State<StepperScreen> createState() => _StepperScreenState();
}

class _StepperScreenState extends State<StepperScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  final List<StepperModel> _steps = [
    StepperModel(
      name: 'Documents',
      body:
          'Leave paperwork behind and\neffortlessly upload your document\nthrough Gamraka!',
      icon: "assets/icons/doc_icon.png",
    ),
    StepperModel(
      name: 'Calculator',
      body: 'Get instant estimates of your\ncustoms fees using our calculator.',
      icon: "assets/icons/calc_icon.png",
    ),
    StepperModel(
      name: 'Delivery',
      body:
          'Stay updated on yyour shiment\'s\nprogress with our real-time delivery\nand tracking option.',
      icon: "assets/icons/van_icon.png",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentIndex < _steps.length - 1) {
        _currentIndex++;
        _pageController.animateToPage(
          _currentIndex,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_steps.length, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index ? AppColors.primary : Colors.white,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          // gradient: LinearGradient(
          //   colors: [
          //     // AppColors.primary.withValues(alpha: .2),
          //     // AppColors.primary,
          //     // const Color.fromARGB(255, 42, 59, 57),
          //   ],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _steps.length,
                  itemBuilder: (context, index) {
                    final step = _steps[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 50),
                          Text(
                            step.name,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 40),
                                Image.asset(step.icon, width: 200, height: 200),
                                SizedBox(height: 80),
                                Text(
                                  step.body,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              if (_currentIndex != _steps.length - 1) _buildDots(),
              SizedBox(height: 20),
              if (_currentIndex == _steps.length - 1)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 32.0,
                    right: 64,
                    left: 64,
                  ),
                  child: SizedBox(
                    width: context.width,
                    child: ElevatedButton(
                      onPressed: () {
                        context.offToPage(WelcomeScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 14,
                        ),
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('Continue'),
                    ),
                  ),
                )
              else
                SizedBox(height: 64), // Reserve space so layout doesn’t jump
            ],
          ),
        ),
      ),
    );
  }
}

class StepperModel {
  String name;
  String body;
  String icon;

  StepperModel({required this.name, required this.body, required this.icon});
}
