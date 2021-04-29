import 'package:shop_app/models/login_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final LoginModel registerModel;

  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class RegisterPasswordVisibilityState extends RegisterStates {}
