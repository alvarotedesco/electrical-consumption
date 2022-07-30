class SessionController {
  static final SessionController _session = SessionController._internal();

  factory SessionController() => _session;

  String? token;

  SessionController._internal() {
    token;
  }
}
