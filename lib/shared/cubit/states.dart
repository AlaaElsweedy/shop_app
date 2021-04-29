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

class AppGetFavoritesDataSuccessState extends AppStates {}

class AppGetFavoriteDataErrorState extends AppStates {}

class AppGetFavoriteDataLoadingState extends AppStates {}
