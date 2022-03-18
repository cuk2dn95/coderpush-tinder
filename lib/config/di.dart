import 'package:coderpush_tinder/data/source/local/database.dart';

import '../data/source/remote/api.dart';
import '../data/source/user_source.dart';
import '../domain/repository/user_repository.dart';
import '../domain/usecase/get_user_usecase.dart';

abstract class Injector {
  Injector._();

  //network
  static final HttpClient _httpClient = HttpClient();
  //database
  static final Database _database = Database();

  //register repository
  static UserRepository userRepository() => UserSource(_httpClient);


  //register UseCase
  static GetUsersUseCase usersUseCase() => GetUsersUseCase(userRepository());

}