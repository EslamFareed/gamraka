part of 'my_orders_cubit.dart';

@immutable
sealed class MyOrdersState {}

final class MyOrdersInitial extends MyOrdersState {}



 class LoadingGetOrdersState extends MyOrdersState {}
 class SuccessGetOrdersState extends MyOrdersState {}
 class ErrorGetOrdersState extends MyOrdersState {}
 


class StartSearchOrdersState extends MyOrdersState {}
class EndSearchOrdersState extends MyOrdersState {}