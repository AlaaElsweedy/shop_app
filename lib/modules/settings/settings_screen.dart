import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/colors.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context).userModel;

        nameController.text = cubit.data.name;
        phoneController.text = cubit.data.phone;
        emailController.text = cubit.data.email;

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
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
                label: 'Email',
                prefix: Icons.email,
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
              SizedBox(height: 15.0),
              defaultButton(
                  color: defaultColor,
                  child: Text('sign out'.toUpperCase()),
                  onPressed: () {
                    CacheHelper.removeData('token').then((value) {
                      navigateAndFinish(context, LoginScreen());
                    });
                  }),
            ],
          ),
        );
      },
    );
  }
}
