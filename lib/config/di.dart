import 'package:coderpush_tinder/data/source/local/database.dart';
import 'package:coderpush_tinder/domain/usecase/get_user_detail_usecase.dart';
import 'package:coderpush_tinder/presentation/viewmodel/home_viewmodel.dart';
import 'package:coderpush_tinder/presentation/viewmodel/liked_list_viewmodel.dart';
import 'package:coderpush_tinder/presentation/viewmodel/second_look_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/source/remote/api.dart';
import '../data/source/user_source.dart';
import '../domain/repository/user_repository.dart';
import '../domain/usecase/get_user_usecase.dart';
import '../domain/usecase/save_user_usecase.dart';
import '../domain/usecase/user_page_usecase.dart';

abstract class Injector {
  Injector._();

  static init(SharedPreferences sharedPreferences) {
    _database = Database(sharedPreferences);
  }

  //network
  static final HttpClient _httpClient = HttpClient();
  //database
  static late Database _database;

  //register repository
  static UserRepository userRepository() => UserSource(_httpClient, _database);


  //register UseCase
  static GetUsersUseCase getUsersUseCase() => GetUsersUseCase(userRepository());
  static GetUserDetailUseCase getUserDetailUseCase() => GetUserDetailUseCase(userRepository());
  static UserPageUseCase userPageUseCase() => UserPageUseCase(userRepository());
  static SaveUsersUseCase saveUserUseCase() => SaveUsersUseCase(userRepository());

  //register viewModel
  static HomeViewModel homeViewModel() => HomeViewModel(getUsersUseCase(), getUserDetailUseCase(), userPageUseCase(), saveUserUseCase());
  static LikedListViewModel likedListViewModel() => LikedListViewModel(saveUserUseCase());
  static SecondLookViewModel secondLookViewModel() => SecondLookViewModel(saveUserUseCase());
}