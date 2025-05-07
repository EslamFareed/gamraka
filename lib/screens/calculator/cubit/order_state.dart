part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

class LoadingCalculateState extends OrderState{}
class SuccessCalculateState extends OrderState{}
class ErrorCalculateState extends OrderState{}


class LoadingCountriesState extends OrderState{}
class SuccessCountriesState extends OrderState{}
class ErrorCountriesState extends OrderState{}


class StartChooseCountryState extends OrderState {}
class EndChooseCountryState extends OrderState {}




class LoadingMakeOrderState extends OrderState{}
class SuccessMakeOrderState extends OrderState{}
class ErrorMakeOrderState extends OrderState{}
