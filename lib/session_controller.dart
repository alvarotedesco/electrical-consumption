import 'package:electrical_comsuption/models/container.dart';

class SessionController {
  static final SessionController _session = SessionController._internal();

  factory SessionController() => _session;

  ContainerModel? container;
  String? token;
  int? userId;

  SessionController._internal() {
    container;
    userId;
    token;
  }
}
