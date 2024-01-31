class UserModel {
  String name;
  String email;
  String profilePic;
  String phoneNumber;

  UserModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profilePic,
  });

  // from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      profilePic: map['profilePic'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "profilePic": profilePic,
    };
  }
}
