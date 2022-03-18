import '../user.dart';

class UserResponse {
  const UserResponse(
      {required this.data,
      required this.total,
      required this.page,
      required this.limit});

  final List<User> data;
  final int total;
  final int page;
  final int limit;

  factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
        data: List<User>.from(json["data"].map((x) => User.fromMap(x))),
        total: json["total"],
        page: json["page"],
        limit: json["limit"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "total": total,
        "page": page,
        "limit": limit,
      };
}