import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('SignOut'),
          onPressed: () {
            CacheHelper.removeData('token').then((value) {
              navigateAndFinish(context, LoginScreen());
            });
          },
        ),
      ),
    );
  }
}
