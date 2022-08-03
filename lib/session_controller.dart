class SessionController {
  static final SessionController _session = SessionController._internal();

  factory SessionController() => _session;

  String? token;
  int? userId;

  SessionController._internal() {
    token;
    userId;
  }
}
