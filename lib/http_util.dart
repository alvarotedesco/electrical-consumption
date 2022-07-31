import 'package:http/http.dart' as http;

import 'session_controller.dart';
import 'themes/constants.dart';

class HttpUtil {
  final _session = SessionController();

  Future<http.Response> post({
    String? url,
    Map<String, String>? headers,
    data,
  }) async {
    if (_session.token == null) {
      // TODO: enviar para tela de Login
    }

    headers ??= {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${_session.token}",
    };

    return await http.post(
      Uri.parse('${Underwear.baseURL}$url'),
      headers: headers,
      body: data,
    );
  }

  Future<http.Response> get({String? url, headers}) async {
    if (_session.token == null) {
      // TODO: enviar para tela de Login
    }

    headers ??= {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${_session.token}",
    };

    return await http.get(
      Uri.parse('${Underwear.baseURL}$url'),
      headers: headers,
    );
  }

  Future<http.Response> delete({String? url, headers, data}) async {
    if (_session.token == null) {
      // TODO: enviar para tela de Login
    }

    headers ??= {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${_session.token}",
    };

    return await http.delete(
      Uri.parse('${Underwear.baseURL}$url'),
      headers: headers,
      body: data,
    );
  }
}
