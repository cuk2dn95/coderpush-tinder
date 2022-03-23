import '../../common/database_key.dart';
import '../entity/user.dart';
import '../repository/user_repository.dart';

class SaveUsersUseCase {
  SaveUsersUseCase(this.userRepository);

  final UserRepository userRepository;

  Future<void> saveLikedUsers(User user) async {
    final List<User> users =
        await userRepository.getUsersByType(DatabaseKey.likedUsers);
    if (users.contains(user)) {
      return;
    }
    users.add(user);
    await userRepository.saveUsersByType(DatabaseKey.likedUsers, users);
  }

  Future<void> savePassedUsers(User user) async {
    final List<User> users =
        await userRepository.getUsersByType(DatabaseKey.passedUsers);
    if (users.contains(user)) {
      return;
    }
    users.add(user);
    await userRepository.saveUsersByType(DatabaseKey.passedUsers, users);
  }

  Future<List<User>> getLikedUsers() =>
      userRepository.getUsersByType(DatabaseKey.likedUsers);

  Future<List<User>> getPassedUsers() =>
      userRepository.getUsersByType(DatabaseKey.passedUsers);
}
