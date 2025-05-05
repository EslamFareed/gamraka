import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka/core/cache_helper.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void login({required String phone, required String password}) async {
    emit(LoginLoadingState());
    try {
      var dataAuth = await auth.signInWithEmailAndPassword(
        email: "$phone@gmail.com",
        password: password,
      );

      if (dataAuth.user != null) {
        var data =
            await firestore.collection("users").doc(dataAuth.user?.uid).get();
        if (data.data() != null) {
          CacheHelper.login(
            phone: phone,
            name: data.data()!["name"],
            idNumber: data.data()!["idNumber"],
            id: dataAuth.user!.uid,
            image: data.data()!["image"],
          );
          emit(LoginSuccessState());
        } else {
          emit(LoginErrorState());
        }
      } else {
        emit(LoginErrorState());
        return;
      }
    } catch (e) {
      emit(LoginErrorState());
    }
  }
}
