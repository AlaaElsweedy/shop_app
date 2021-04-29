import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/register/cubit/register_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel loginModel;

  bool isPasswordShown = true;
  IconData suffixIcon = Icons.visibility_outlined;

  void passwordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffixIcon = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(RegisterPasswordVisibilityState());
  }

  void userRegister({
    @required String email,
    @required String password,
    @required String phone,
    @required String name,
  }) {
    emit(RegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
      },
    ).then((value) {
      loginModel = LoginModel.fromJason(value.data);
      emit(RegisterSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }
}
