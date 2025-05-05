import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../models/category_model.dart';
import '../models/slider_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  final firestore = FirebaseFirestore.instance;

  List<SliderModel> sliders = [];
  List<CategoryModel> categories = [];

  void getSliders() async {
    emit(LoadingHomeState());

    try {
      var data = await firestore.collection("slider").get();
      sliders = data.docs.map((e) => SliderModel.fromFirebase(e)).toList();

      var categoriesData = await firestore.collection("categories").get();

      categories =
          categoriesData.docs
              .map((e) => CategoryModel.fromFirebase(e))
              .toList();

      emit(SuccessHomeState());
    } catch (e) {
      emit(ErrorHomeState());
    }
  }
}
