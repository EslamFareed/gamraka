import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka/core/app_functions.dart';

import '../../core/app_colors.dart';
import 'cubit/asks_cubit.dart';

class AddAskScreen extends StatelessWidget {
  AddAskScreen({super.key});

  final questionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ask For something")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                //! ------------------- Question ------------------!
                Row(children: [Text("What is your question?")]),
                SizedBox(height: 5),
                TextFormField(
                  minLines: 5,
                  maxLines: 10,
                  controller: questionController,
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
                      return "Question is required";
                    }

                    return null;
                  },
                ),
                SizedBox(height: context.screenHeight * .05),
                BlocConsumer<AsksCubit, AsksState>(
                  listener: (context, state) {
                    if (state is ErrorAddAsksState) {
                      context.showErrorSnack("error, please try again later");
                    }
                    if (state is SuccessAddAsksState) {
                      context.showSuccessSnack("Added successfully");
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadingAddAsksState) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AsksCubit.get(
                            context,
                          ).addQuestion(questionController.text, context);
                        }
                      },
                      minWidth: context.screenWidth,
                      height: 50,
                      color: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "Send Question",
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
