
import 'dart:async';
import '../../domain/usecase/get_user_detail_usecase.dart';
import '../../domain/usecase/get_user_usecase.dart';



class HomeViewModel {
  HomeViewModel(this.getUsersUseCase, this.getUserDetailUseCase);

  final GetUsersUseCase getUsersUseCase;
  final GetUserDetailUseCase getUserDetailUseCase;

  final _onDeclineButtonFocus = StreamController<bool>();
  get declineButtonFocusStream => _onDeclineButtonFocus.stream;

  final _onSuperLikeButtonFocus = StreamController<bool>();
  get superLikeButtonFocusStream => _onSuperLikeButtonFocus.stream;

  final _onLikeButtonFocus = StreamController<bool>();
  get likeButtonFocusStream => _onLikeButtonFocus.stream;

  void onDeclineButtonFocus(bool focus) {
    _onDeclineButtonFocus.add(focus);
  }

  void onSuperLikeButtonFocus(bool focus) {
    _onSuperLikeButtonFocus.add(focus);
  }

  void onLikeButtonFocus(bool focus) {
    _onLikeButtonFocus.add(focus);
  }
}