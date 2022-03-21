import 'dart:convert';

class UserDetailResponse {
  UserDetailResponse(
      {required this.id,
      required this.title,
      required this.firstName,
      required this.lastName,
      required this.picture,
      required this.gender,
      required this.email,
      required this.dateOfBirth,
      required this.phone,
      required this.location,
      required this.registerDate,
      required this.updatedDate});

  final String id;
  final String title;
  final String firstName;
  final String lastName;
  final String picture;
  final String gender;
  final String email;
  final DateTime dateOfBirth;
  final String phone;
  final Location location;
  final DateTime registerDate;
  final DateTime updatedDate;

  factory UserDetailResponse.fromJson(String str) =>
      UserDetailResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserDetailResponse.fromMap(Map<String, dynamic> json) =>
      UserDetailResponse(
        id: json["id"],
        title: json["title"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        picture: json["picture"],
        gender: json["gender"],
        email: json["email"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        phone: json["phone"],
        location: Location.fromMap(json["location"]),
        registerDate: DateTime.parse(json["registerDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "firstName": firstName,
        "lastName": lastName,
        "picture": picture,
        "gender": gender,
        "email": email,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "phone": phone,
        "location": location.toMap(),
        "registerDate": registerDate.toIso8601String(),
        "updatedDate": updatedDate.toIso8601String(),
      };
}

class Location {
  Location({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.timezone,
  });

  final String street;
  final String city;
  final String state;
  final String country;
  final String timezone;

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        street: json["street"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toMap() => {
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "timezone": timezone,
      };
}
