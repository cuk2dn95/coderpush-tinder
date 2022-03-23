

import '../repository/user_repository.dart';

class UserPageUseCase {
  UserPageUseCase(this.userRepository);

  final UserRepository userRepository;

  int getCurrentUserPage() => userRepository.getCurrentUserPage() ?? 0;

  void saveCurrentUserPage(int page) => userRepository.saveCurrentUserPage(page);
}