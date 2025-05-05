import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  static SignUpCubit get(context) => BlocProvider.of(context);

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void signUp({
    required String name,
    required String email,
    required String dateOfBirth,
    required String phone,
    required String nationality,
    required String gender,
    required String password,
  }) async {
    emit(SignUpLoadingState());
    try {
      var dataAuth = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (dataAuth.user != null) {
        await firestore.collection("users").doc(dataAuth.user?.uid).set({
          "email": email,
          "name": name,
          "dateOfBirth": dateOfBirth,
          "phone": phone,
          "nationality": nationality,
          "gender": gender,
          "password": password,
        });
        emit(SignUpSuccessState());
      } else {
        emit(SignUpErrorState());
        return;
      }
    } catch (e) {
      emit(SignUpErrorState());
    }
  }
}
