class User {
  User({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.picture,
  });

  final String id;
  final String title;
  final String firstName;
  final String lastName;
  final String picture;

  User copyWith({
    String? id,
    String? title,
    String? firstName,
    String? lastName,
    String? picture,
  }) =>
      User(
        id: id ?? this.id,
        title: title ?? this.title,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        picture: picture ?? this.picture,
      );
}
