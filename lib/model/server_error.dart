class ServerError {
  final String message;

  const ServerError({this.message});

  static ServerError fromJson(dynamic json) {
    return ServerError(
      message: json['message'] as String,
    );
  }

  @override
  String toString() {
    return message;
  }
}
