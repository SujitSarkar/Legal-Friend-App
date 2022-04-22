import 'dart:convert';

UserLoginModel userLoginModelFromJson(String str) => UserLoginModel.fromJson(json.decode(str));

class UserLoginModel {
  UserLoginModel({
    this.status,
    this.user,
    this.error,
    this.message,
  });

  String status;
  User user;
  String error;
  String message;

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
    status: json["status"],
    user: User.fromJson(json["user"]),
    error: json["error"],
    message: json["message"],
  );
}

class User {
  User({
    this.id,
    this.name,
    this.photo,
    this.email,
    this.phone,
    this.password,
    this.profession,
    this.company,
    this.address,
    this.gender,
    this.dob,
    this.religion,
    this.materialStatus,
    this.status,
    this.expireDate,
    this.aboutMe,
    this.uploadedAt,
    this.updatedAt,
  });

  String id;
  String name;
  String photo;
  String email;
  String phone;
  String password;
  String profession;
  String company;
  String address;
  String gender;
  DateTime dob;
  String religion;
  String materialStatus;
  String status;
  DateTime expireDate;
  String aboutMe;
  DateTime uploadedAt;
  String updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    photo: json["photo"],
    email: json["email"],
    phone: json["phone"],
    password: json["password"],
    profession: json["profession"],
    company: json["company"],
    address: json["address"],
    gender: json["gender"],
    dob: DateTime.parse(json["dob"]),
    religion: json["religion"],
    materialStatus: json["material_status"],
    status: json["status"],
    expireDate: DateTime.parse(json["expire_date"]),
    aboutMe: json["about_me"],
    uploadedAt: DateTime.parse(json["uploaded_at"]),
    updatedAt: json["updated_at"],
  );
}
