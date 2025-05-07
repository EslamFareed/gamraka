import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka/core/cache_helper.dart';
import 'package:gamraka/screens/orders/models/order_model.dart';
import 'package:meta/meta.dart';

part 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  MyOrdersCubit() : super(MyOrdersInitial());

  static MyOrdersCubit get(context) => BlocProvider.of(context);

  final firestore = FirebaseFirestore.instance;

  List<OrderModel> orders = [];
  List<OrderModel> allOrders = [];

  void getOrders() async {
    emit(LoadingGetOrdersState());

    try {
      var data =
          await firestore
              .collection("orders")
              .where("user.uid", isEqualTo: CacheHelper.getId())
              .get();

      allOrders = data.docs.map((e) => OrderModel.fromJson(e)).toList();
      orders = allOrders;

      emit(SuccessGetOrdersState());
    } catch (e) {
      print(e.toString());
      emit(ErrorGetOrdersState());
    }
  }

  void search(String q) {
    emit(StartSearchOrdersState());
    orders =
        allOrders
            .where((e) => e.id.toLowerCase().contains(q.toLowerCase()))
            .toList();
    emit(EndSearchOrdersState());
  }
}
