
import 'package:flutter/material.dart';

import '../../domain/entity/user.dart';
import '../../domain/usecase/save_user_usecase.dart';

class LikedListViewModel extends ChangeNotifier {
  LikedListViewModel(this._saveUsersUseCase) {
     _saveUsersUseCase.getLikedUsers().then((value) {
       likedListUsers = value;
       notifyListeners();
     });
  }

  final SaveUsersUseCase _saveUsersUseCase;

  List<User> likedListUsers = List.empty();
}
