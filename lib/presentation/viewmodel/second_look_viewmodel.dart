
import 'package:flutter/material.dart';
import '../../domain/usecase/save_user_usecase.dart';

class SecondLookViewModel extends ChangeNotifier {
  SecondLookViewModel(this._saveUsersUseCase) {
    _saveUsersUseCase.getPassedUsers().then((value) {
      secondLookUsers = value;
      notifyListeners();
    });
  }

  final SaveUsersUseCase _saveUsersUseCase;

  var secondLookUsers = List.empty();
}
