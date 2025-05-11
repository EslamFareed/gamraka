import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka/core/app_functions.dart';
import 'package:gamraka/screens/navbar/navbar_screen.dart';

import '../../../core/app_colors.dart';
import 'cubit/sign_up_cubit.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final idController = TextEditingController();
  final mobileNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: context.screenHeight * .05),
                Image.asset("assets/icons/icon.png", height: 300, width: 300),

                //! ------------------- Full Name ------------------!
                Row(children: [Text("Full Name")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: nameController,
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
                      return "Full Name is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                //! ------------------- Phone Number ------------------!
                Row(children: [Text("Phone Number")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: mobileNumberController,
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
                      return "Phone Number is required";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 15),

                //! ------------------- National ID ------------------!
                Row(children: [Text("National ID")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: idController,
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
                      return "National ID is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                //! ------------------- Password ------------------!
                Row(children: [Text("Password")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
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
                      return "Password is required";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.screenHeight * .05),

                //! ------------------- Sign Up Button ------------------!
                BlocConsumer<SignUpCubit, SignUpState>(
                  listener: (context, state) {
                    if (state is SignUpSuccessState) {
                      context.showSuccessSnack("Account created successfully");
                      context.goOffAll(NavbarScreen());
                    } else if (state is SignUpErrorState) {
                      context.showErrorSnack(
                        "Create Account Error, Please try again",
                      );
                    }
                  },
                  builder: (context, state) {
                    return state is SignUpLoadingState
                        ? Center(child: CircularProgressIndicator())
                        : MaterialButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              SignUpCubit.get(context).signUp(
                                name: nameController.text.trim(),
                                phone: mobileNumberController.text.trim(),
                                idNumber: idController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                            }
                          },
                          minWidth: context.screenWidth,
                          height: 50,
                          color: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "Create Account",
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
