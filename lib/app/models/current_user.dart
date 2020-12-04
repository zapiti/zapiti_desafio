class CurrentUser {
  String id;
  String name;

  CurrentUser({this.id, this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
    };
  }

  factory CurrentUser.fromMap(Map<String, dynamic> map) {
    return new CurrentUser(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }
}
