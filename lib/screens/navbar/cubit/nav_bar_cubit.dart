import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavBarCubit extends Cubit<int> {
  NavBarCubit() : super(0);

  static NavBarCubit get(context) => BlocProvider.of(context);

  void changeScreen(int index) {
    emit(index);
  }
}
