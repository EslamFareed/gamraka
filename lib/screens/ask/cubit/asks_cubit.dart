import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka/core/cache_helper.dart';
import 'package:meta/meta.dart';

import '../models/ask_model.dart';

part 'asks_state.dart';

class AsksCubit extends Cubit<AsksState> {
  AsksCubit() : super(AsksInitial());

  static AsksCubit get(context) => BlocProvider.of(context);

  final firestore = FirebaseFirestore.instance;

  List<AskModel> asks = [];

  void getAsks(BuildContext context) async {
    emit(LoadingGetAsksState());
    try {
      firestore
          .collection("asks")
          .where("user.uid", isEqualTo: CacheHelper.getId())
          .snapshots()
          .listen((data) {
            asks =
                data.docs.map((e) {
                  return AskModel.fromJson(e.data());
                }).toList();
            emit(SuccessGetAsksState());
          });
    } catch (e) {
      emit(ErrorGetAsksState());
    }
  }

  void addQuestion(String question, BuildContext context) async {
    emit(LoadingAddAsksState());
    try {
      await firestore.collection("asks").add({
        "question": question,
        "createdAt": DateTime.now().toString(),
        "answer": "",
        "user": {
          "name": CacheHelper.getName(),
          "phone": CacheHelper.getPhone(),
          "idNumber": CacheHelper.getIdNumber(),
          "image": CacheHelper.getImage(),
          "uid": CacheHelper.getId(),
        },
      });
      emit(SuccessAddAsksState());
    } catch (e) {
      emit(ErrorAddAsksState());
    }
  }
}
