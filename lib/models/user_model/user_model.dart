import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.image,
    required this.id,
    required this.name,
    required this.email,
    required this.favouriteIds,
  });

  String? image;
  String name;
  String email;
  String? favouriteIds;

  String id;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"],
      image: json["image"],
      email: json["email"],
      name: json["name"],
      favouriteIds: json["favouriteIds"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "email": email,
        "favouriteIds": favouriteIds,
      };

  UserModel copyWith({
    String? name,
    image,
  }) =>
      UserModel(
        id: id,
        name: name ?? this.name,
        email: email,
        image: image ?? this.image,
        favouriteIds: favouriteIds,
      );
}
