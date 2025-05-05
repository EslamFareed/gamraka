import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Map<String, dynamic> userData = {};

  void login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      var dataAuth = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (dataAuth.user != null) {
        var data =
            await firestore.collection("users").doc(dataAuth.user?.uid).get();
        if (data.data() != null) {
          userData = data.data() ?? {};
          userData['uid'] = dataAuth.user?.uid;
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
