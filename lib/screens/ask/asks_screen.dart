import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka/core/app_functions.dart';

import '../../core/app_colors.dart';
import 'add_ask_screen.dart';
import 'cubit/asks_cubit.dart';

class AsksScreen extends StatelessWidget {
  const AsksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AsksCubit.get(context).getAsks(context);
    return Scaffold(
      appBar: AppBar(title: Text("Asks")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goToPage(AddAskScreen());
        },
        backgroundColor: AppColors.primary,
        child: Text(
          "Add",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<AsksCubit, AsksState>(
        builder: (context, state) {
          if (state is LoadingGetAsksState) {
            return Center(child: CircularProgressIndicator());
          }

          final asks = AsksCubit.get(context).asks;
          return ListView.builder(
            padding: EdgeInsets.all(24),
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Text("${index + 1}"),
                  title: Text(asks[index].question),
                  subtitle: Text(
                    asks[index].answer.isEmpty
                        ? "No answer yet"
                        : asks[index].answer,
                  ),
                ),
              );
            },
            itemCount: asks.length,
          );
        },
      ),
    );
  }
}
