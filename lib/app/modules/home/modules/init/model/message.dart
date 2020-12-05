class Message {
  String content;

  String created_at;


  Message({this.content, this.created_at});

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'created_at': created_at,
    };
  }

  factory Message.fromMap(dynamic map) {
    if (null == map) return null;
    var temp;
    return Message(
      content: map['content']?.toString(),
      created_at: map['created_at']?.toString(),
    );
  }
}
