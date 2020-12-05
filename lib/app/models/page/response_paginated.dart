class ResponsePaginated<T> {
  T content;
  String error;

  ResponsePaginated({this.content, this.error});

  factory ResponsePaginated.fromMap(
      dynamic map) {
    if (null == map) return null;
    var temp;
    return ResponsePaginated(
      content: map,
      error: null,
    );
  }
}
