import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          bottomNavigationBar: ConvexAppBar(
            items: [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.widgets, title: 'Categories'),
              TabItem(icon: Icons.favorite, title: 'Favorites'),
              TabItem(icon: Icons.settings, title: 'Settings'),
            ],
            height: 55,
            elevation: 4,
            initialActiveIndex: cubit.currentIndex,
            onTap: (index) => cubit.changeIndex(index),
          ),
          body: cubit.pages[cubit.currentIndex],
        );
      },
    );
  }
}
