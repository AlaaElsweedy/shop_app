import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/cubit/register_cubit.dart';
import 'package:shop_app/modules/register/cubit/register_states.dart';
import 'package:shop_app/shared/components/colors.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.registerModel.status) {
              CacheHelper.saveData(
                key: 'token',
                value: state.registerModel.data.token,
              ).then((value) {
                if (value) {
                  token = state.registerModel.data.token;

                  navigateAndFinish(context, LoginScreen());
                }
              });
            } else {
              flutterToast(
                message: state.registerModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        SizedBox(height: 30.0),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your name';
                            }
                          },
                          label: 'Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(height: 15.0),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(height: 15.0),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: cubit.suffixIcon,
                          suffixPressed: () {
                            cubit.passwordVisibility();
                          },
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          label: 'Password',
                          isPassword: cubit.isPasswordShown,
                          prefix: Icons.lock_outline,
                          onSubmit: (value) {
                            if (formKey.currentState.validate()) {
                              cubit.userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                                name: nameController.text,
                              );
                            }
                          },
                        ),
                        SizedBox(height: 15.0),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your phone';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(height: 30.0),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defaultButton(
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                cubit.userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  name: nameController.text,
                                );
                              }
                            },
                            child: Text('register'.toUpperCase()),
                            color: defaultColor,
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(height: 15.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
