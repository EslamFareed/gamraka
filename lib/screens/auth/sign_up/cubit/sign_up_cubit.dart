import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gamraka/core/cache_helper.dart';
import 'package:image_picker/image_picker.dart';
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
  FirebaseStorage storage = FirebaseStorage.instance;

  void signUp({
    required String name,
    required String phone,
    required String idNumber,
    required String password,
  }) async {
    emit(SignUpLoadingState());
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        File file = File(image.path);

        final storageRef = storage.ref();
        final imagesRef = storageRef.child("images/${image.name}");
        await imagesRef.putFile(file);
        String downloadURL = await imagesRef.getDownloadURL();
        var dataAuth = await auth.createUserWithEmailAndPassword(
          email: "$phone@gmail.com",
          password: password,
        );

        if (dataAuth.user != null) {
          await firestore.collection("users").doc(dataAuth.user?.uid).set({
            "name": name,
            "phone": phone,
            "idNumber": idNumber,
            "password": password,
            "image": downloadURL,
          });

          await CacheHelper.login(
            phone: phone,
            name: name,
            idNumber: idNumber,
            id: dataAuth.user!.uid,
            image: downloadURL,
          );
          emit(SignUpSuccessState());
        } else {
          emit(SignUpErrorState());
          return;
        }
      } else {
        emit(SignUpErrorState());
        return;
      }
    } catch (e) {
      emit(SignUpErrorState());
    }
  }
}
