import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka/core/cache_helper.dart';
import 'package:gamraka/screens/calculator/models/route_model.dart';
import 'package:gamraka/screens/payment_methods/models/payment_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../home/models/category_model.dart';
import '../models/country_model.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  static OrderCubit get(context) => BlocProvider.of(context);
  final firestore = FirebaseFirestore.instance;
  List<CountryModel> countries = [];
  CountryModel? egypt;

  void getCountries() async {
    emit(LoadingCountriesState());

    try {
      var data =
          await firestore
              .collection("countries")
              .where("name", isNotEqualTo: "Egypt")
              .get();

      countries = data.docs.map((e) => CountryModel.fromFirebase(e)).toList();

      var egyptData =
          await firestore.collection("countries").doc("egypt").get();

      egypt = CountryModel.fromDocFirebase(egyptData);
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

  num? itemPrice;
  String? itemName;
  String? itemDesc;
  num? weight;
  CategoryModel? category;
  RouteModel? route;

  void calculate({
    required String n,
    required num p,
    required String d,
    required num w,
    required CategoryModel c,
  }) async {
    emit(LoadingCalculateState());
    try {
      var routeData =
          await firestore
              .collection("routes")
              .doc("${from!.name!.toLowerCase()}_${to!.name!.toLowerCase()}")
              .get();
      var r = RouteModel.fromDocument(routeData);
      route = r;
      itemPrice = p;
      itemName = n;
      itemDesc = d;
      weight = w;
      category = c;

      total =
          (route!.cost!) +
          (weight! * 5) +
          (itemPrice! * .14) +
          ((category!.fees! / 100) * itemPrice!);

      emit(SuccessCalculateState());
    } catch (e) {
      emit(ErrorCalculateState());
    }
  }

  double total = 0;

  PaymentModel? method;

  void selectPaymenthMethod(PaymentModel? m) {
    emit(StartChooseCountryState());
    method = m;
    emit(EndChooseCountryState());
  }

  FirebaseStorage storage = FirebaseStorage.instance;

  void makeOrder(DateTime date) async {
    emit(LoadingMakeOrderState());
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        File file = File(image.path);

        final storageRef = storage.ref();
        final imagesRef = storageRef.child("images/${image.name}");
        await imagesRef.putFile(file);
        String downloadURL = await imagesRef.getDownloadURL();

        await firestore.collection("orders").add({
          "user": {
            "uid": CacheHelper.getId(),
            "idNumber": CacheHelper.getIdNumber(),
            "image": CacheHelper.getImage(),
            "name": CacheHelper.getName(),
            "phone": CacheHelper.getPhone(),
          },
          "from": "${from!.name} - ${from!.address}",
          "to": "${to!.name} - ${to!.address}",
          "itemName": itemName,
          "itemDesc": itemDesc,
          "itemPrice": itemPrice,
          "weight": weight,
          "category": {
            "name": category!.name,
            "fees": category!.fees,
            "icon": category!.icon,
          },
          "createdAt": DateTime.now().toString(),
          "pickupDate": date.toString(),
          "taxes": (itemPrice! * .14) + ((category!.fees! / 100) * itemPrice!),
          "shippingCost": (route!.cost!) + (weight! * 5),
          "total": total,
          "status": "pending",
          "statusDesc": "",
          "methodType": method == null ? "cash" : method!.cardNumber,
          "verificationImage": downloadURL,
        });

        emit(SuccessMakeOrderState());
      } else {
        emit(ErrorMakeOrderState());
      }
    } catch (e) {
      emit(ErrorMakeOrderState());
    }
  }
}
