import 'dart:async';
import '../../domain/entity/response/error_response.dart';
import '../../domain/entity/response/user_detail_response.dart';
import '../../domain/entity/response/user_response.dart';
import 'package:dartz/dartz.dart';

import '../../domain/usecase/save_user_usecase.dart';
import '../../domain/usecase/user_page_usecase.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/entity/user.dart';
import '../../domain/usecase/get_user_detail_usecase.dart';
import '../../domain/usecase/get_user_usecase.dart';
import '../widget/tinder_card.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._getUsersUseCase, this._getUserDetailUseCase,
      this._userPageUseCase, this._saveUsersUseCase) {
    _currentPage = _userPageUseCase.getCurrentUserPage();
    loadUser();
  }

  final GetUsersUseCase _getUsersUseCase;
  final GetUserDetailUseCase _getUserDetailUseCase;
  final UserPageUseCase _userPageUseCase;
  final SaveUsersUseCase _saveUsersUseCase;

  final List<User> users = List.empty(growable: true);

  final int limit = 5;

  bool isUserEmpty = false;
  bool isFetchingUsers = false;
  bool isInitFetch = true;

  late int _currentPage;

  final StreamController<bool> _onDeclineButtonFocus = StreamController<bool>();

  get declineButtonFocusStream => _onDeclineButtonFocus.stream;

  final StreamController<bool> _onSuperLikeButtonFocus = StreamController<bool>();

  get superLikeButtonFocusStream => _onSuperLikeButtonFocus.stream;

  final StreamController<bool> _onLikeButtonFocus = StreamController<bool>();

  get likeButtonFocusStream => _onLikeButtonFocus.stream;

  void onDeclineButtonFocus({bool focus = false}) {
    _onDeclineButtonFocus.add(focus);
  }

  void onSuperLikeButtonFocus({bool focus = false}) {
    _onSuperLikeButtonFocus.add(focus);
  }

  void onLikeButtonFocus({bool focus = false}) {
    _onLikeButtonFocus.add(focus);
  }

  final CardController cardController = CardController();

  void onDecline(User user) {
    cardController.triggerLeft();
    onDeclineUser(user);
  }

  void onSuperLike(User user) {
    cardController.triggerUp();
    onSuperLikeUser(user);
  }

  void onLike(User user) {
    cardController.triggerRight();
    onLikeUser(user);
  }

  void onDeclineUser(User user) {
    _saveUsersUseCase.savePassedUsers(user);
  }

  void onSuperLikeUser(User user) {
    _saveUsersUseCase.saveLikedUsers(user);
  }

  void onLikeUser(User user) {
    _saveUsersUseCase.saveLikedUsers(user);
  }

  final StreamController<double> _onDeclineOpacity = StreamController<double>.broadcast();

  get onDeclineOpacity => _onDeclineOpacity.stream;

  final StreamController<double> _onSuperLikeOpacity = StreamController<double>.broadcast();

  get onSuperLikeOpacity => _onSuperLikeOpacity.stream;

  final StreamController<double> _onLikeOpacity = StreamController<double>.broadcast();

  get onLikeOpacity => _onLikeOpacity.stream;

  final double _thresholdOpacity = 5;

  void onAttemptLike(double dx) {
    double opacity = 0;
    if (dx > 0) {
      opacity = (dx / _thresholdOpacity).clamp(0, 1);
    }

    _onLikeOpacity.add(opacity);
  }

  void onAttemptDecline(double dx) {
    double opacity = 0;
    if (dx < 0) {
      opacity = (dx.abs() / _thresholdOpacity).clamp(0, 1);
    }

    _onDeclineOpacity.add(opacity);
  }

  void onAttemptSuperLike(double dy) {
    double opacity = 0;
    if (dy < 0) {
      opacity = (dy.abs() / _thresholdOpacity).clamp(0, 1);
    }
    _onSuperLikeOpacity.add(opacity);
  }

  int _currentCardIndex = 0;
  final int thresholdIndexLoading = 5;

  get currentCardIndex => _currentCardIndex;

  void onCurrentIndexCardChanged(int index) {
    _currentCardIndex = index;
    if (users.length - index <= thresholdIndexLoading) {
      loadMoreUser();
    }
  }

  void saveCurrentUserPage() {
    _userPageUseCase.saveCurrentUserPage(_currentPage);
  }

  void loadUser() {
    isFetchingUsers = true;
    if (isInitFetch) {
      notifyListeners();
    }
    onLoaded() {
      isFetchingUsers = false;
      if (isInitFetch) {
        notifyListeners();
        isInitFetch = false;
      }
    }

    _getUsersUseCase(_currentPage, limit).then((Either<UserResponse, ErrorResponse> value) {
      value.fold((UserResponse data) {
        if (data.data.isNotEmpty) {
          users.addAll(data.data);
        } else {
          isUserEmpty = true;
        }
        saveCurrentUserPage();
        onLoaded();
      }, (ErrorResponse error) {
        isUserEmpty = true;
        onLoaded();
      });
    });
  }

  void loadMoreUser() {
    if (isFetchingUsers || isUserEmpty) {
      return;
    }
    _currentPage++;
    loadUser();
  }

  void onUserChosen(User user) {
    users.remove(user);
    notifyListeners();
  }

  Future<String> getUserAge(String id) async => (await _getUserDetailUseCase(id)).fold(
        (UserDetailResponse detail) =>
            (DateTime.now().difference(detail.dateOfBirth).inDays ~/ 365)
                .toString(),
        (ErrorResponse r) => '');
}
