part of 'asks_cubit.dart';

@immutable
sealed class AsksState {}

final class AsksInitial extends AsksState {}

class LoadingGetAsksState extends AsksState {}

class SuccessGetAsksState extends AsksState {}

class ErrorGetAsksState extends AsksState {}

class LoadingAddAsksState extends AsksState {}

class SuccessAddAsksState extends AsksState {}

class ErrorAddAsksState extends AsksState {}
