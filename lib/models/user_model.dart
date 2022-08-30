class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String permission;
  final String type;
  final DateTime? verifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? token;

  UserModel(
    this.id,
    this.name,
    this.email,
    this.phone,
    this.permission,
    this.type,
    this.verifiedAt,
    this.createdAt,
    this.updatedAt,
    this.token,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    var user = json["user"];
    if (json["user"] == null) user = json;

    return UserModel(
      user["id"],
      user["name"],
      user["email"],
      user["phone_number"],
      user["permission"],
      user["type"],
      user["verified_at"] != null ? DateTime.parse(user["verified_at"]) : null,
      user["created_at"] != null ? DateTime.parse(user["created_at"]) : null,
      user["updated_at"] != null ? DateTime.parse(user["updated_at"]) : null,
      json["token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user": {
        "id": id,
        "name": name,
        "email": email,
        "phone_number": phone,
        "type": type,
        "permission": permission,
      },
    };
  }
}
