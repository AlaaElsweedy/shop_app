import 'package:shop_app/models/get_favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/post_favorites_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppBottomNavBarState extends AppStates {}

class AppGetHomeDataLoadingState extends AppStates {}

class AppGetHomeDataSuccessState extends AppStates {}

class AppGetHomeDataErrorState extends AppStates {}

class AppGetCategoriesDataSuccessState extends AppStates {}

class AppGetCategoriesDataErrorState extends AppStates {}

class AppChangeFavoritesDataSuccessState extends AppStates {
  final FavoritesModel model;

  AppChangeFavoritesDataSuccessState(this.model);
}

class AppChangeFavoriteDataErrorState extends AppStates {}

class AppFavoriteState extends AppStates {}

class AppGetFavoriteDataLoadingState extends AppStates {
  final HomeModel model;

  AppGetFavoriteDataLoadingState({this.model});
}

class AppGetFavoritesDataSuccessState extends AppStates {
  final GetFavoritesModel model;

  AppGetFavoritesDataSuccessState(this.model);
}

class AppGetFavoriteDataErrorState extends AppStates {}

class AppGetProfileUserDataSuccessState extends AppStates {}

class AppGetProfileUserDataErrorState extends AppStates {}

class AppGetProfileUserDataLoadingState extends AppStates {}
