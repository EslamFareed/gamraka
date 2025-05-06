import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka/screens/calculator/models/route_model.dart';
import 'package:meta/meta.dart';

import '../../home/models/category_model.dart';
import '../models/country_model.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  static OrderCubit get(context) => BlocProvider.of(context);
  final firestore = FirebaseFirestore.instance;
  List<CountryModel> countries = [];

  void getCountries() async {
    emit(LoadingCountriesState());

    try {
      var data = await firestore.collection("countries").get();

      countries = data.docs.map((e) => CountryModel.fromFirebase(e)).toList();
      emit(SuccessCountriesState());
    } catch (e) {
      emit(ErrorCountriesState());
    }
  }

  CountryModel? from;
  CountryModel? to;

  void selectFrom(CountryModel? country) {
    emit(StartChooseCountryState());
    from = country;
    emit(EndChooseCountryState());
  }

  void selectTo(CountryModel? country) {
    emit(StartChooseCountryState());
    to = country;
    emit(EndChooseCountryState());
  }

  void calculate({
    required String itemName,
    required num itemPrice,
    required String itemDesc,
    required num weight,
    required CategoryModel category,
  }) async {
    emit(LoadingCalculateState());
    try {
      var routeData =
          await firestore
              .collection("routes")
              .doc("${from!.name!.toLowerCase()}_${to!.name!.toLowerCase()}")
              .get();
      var route = RouteModel.fromDocument(routeData);
      total =
          (route.cost!) +
          (weight * 5) +
          (itemPrice * .14) +
          ((category.fees! / 100) * itemPrice);      

      emit(SuccessCalculateState());
    } catch (e) {
      emit(ErrorCalculateState());
    }
  }

  double total = 0;
}
