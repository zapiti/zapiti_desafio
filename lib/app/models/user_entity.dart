class UserEntity {

  static final KID = "KID";

  String username;
  String password;

  UserEntity({this.username, this.password});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory UserEntity.fromMap(dynamic map) {
    if (null == map) return null;
    var temp;
    return UserEntity(
      username: map['username']?.toString(),
      password: map['password']?.toString(),
    );
  }
}
