import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/home/home_screen.dart';
import 'package:shop_app/modules/settings/settings.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> pages = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppBottomNavBarState());
  }

  HomeModel homeModel;

  void getHomeData() {
    emit(AppGetHomeDataLoadingState());

    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      emit(AppGetHomeDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetHomeDataErrorState());
    });
  }

  CategoryModel categoryModel;

  void getCategoryData() {
    DioHelper.getData(
      url: CATEGORIES,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(AppGetCategoriesDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetCategoriesDataErrorState());
    });
  }

  FavoritesModel favoritesModel;

  void changeFavoritesData({
    @required int productId,
  }) {
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(value.data);
      emit(AppChangeFavoritesDataSuccessState());
    }).catchError((error) {
      emit(AppChangeFavoriteDataErrorState());
    });
  }
}
