import 'dart:async';
import '../../domain/entity/user.dart';
import '../../domain/usecase/get_user_detail_usecase.dart';
import '../../domain/usecase/get_user_usecase.dart';
import '../widget/tinder_card.dart';

class HomeViewModel {
  HomeViewModel(this.getUsersUseCase, this.getUserDetailUseCase) {

  }

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

  final CardController cardController = CardController();

  void onDecline(User? user) {
    cardController.triggerLeft();
  }

  void onSuperLike(User? user) {
    cardController.triggerUp();
  }

  void onLike(User? user) {
    cardController.triggerRight();
  }

  final _onDeclineOpacity = StreamController<double>.broadcast();

  get onDeclineOpacity => _onDeclineOpacity.stream;

  final _onSuperLikeOpacity = StreamController<double>.broadcast();

  get onSuperLikeOpacity => _onSuperLikeOpacity.stream;

  final _onLikeOpacity = StreamController<double>.broadcast();

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

  final _currentCardIndex = StreamController<int>.broadcast();
  get currentCardIndex => _currentCardIndex.stream;

  void onCurrentIndexCardChanged(int index) {
    _currentCardIndex.add(index);
  }
}
