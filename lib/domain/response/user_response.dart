import '../entity/user.dart';

class UserResponse {
  const UserResponse(this.data, this.total, this.page, this.limit);

  final List<User> data;
  final int total;
  final int page;
  final int limit;
}