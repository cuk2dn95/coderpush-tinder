class User {
  User({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.picture,
    this.age
  });

  final String id;
  final String title;
  final String firstName;
  final String lastName;
  final String picture;
  String? age;

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

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    title: json["title"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    picture: json["picture"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "firstName": firstName,
    "lastName": lastName,
    "picture": picture,
  };

  String name() => firstName + ' ' + lastName;
}
