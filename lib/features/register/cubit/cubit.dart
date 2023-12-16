import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/model/user_model.dart';
import 'package:social_app/features/register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  // ---------------------------------------- userRegister

  void userRegister({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) {
    emit(SocialRegisterLoadState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(( value) {
          print(value.user?.email);
      userCreate(
          uId: value.user!.uid,
          email: email,
          name: name,
          password: password,
          phone: phone);
    }).catchError((error) {
      print('Your Error${error.toString()}');
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  //
  void userCreate({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String uId,
  }) {
    emit(SocialCreateUserLoadState());
    UserModel model = UserModel(
        name: name,
        phone: phone,
        email: email,
        password: password,
        uId: uId,
        img: 'https://www.freepik.com/free-photos-vectors/calendar-2023',
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(uId)
        .set(model.toMap())
        .then((value) {

      emit(SocialCreateUserSuccessState(uId));
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }


  // ---------------------------------------- changepasswordvisibility

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changepasswordvisibility() {

    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SocialPasswordVisState());
  }
}
