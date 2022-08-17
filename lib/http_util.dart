import 'dart:convert';

import 'package:electrical_comsuption/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'session_controller.dart';
import 'themes/constants.dart';

class HttpUtil {
  final _session = SessionController();

  Future<http.Response> post({
    String? url,
    Map<String, String>? headers,
    data,
  }) async {
    final pref = await SharedPreferences.getInstance();
    final token = _session.token ?? pref.getString('token');
    headers ??= {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var resp = await http.post(
      Uri.parse('${Underwear.baseURL}$url'),
      headers: headers,
      body: data,
    );

    var respp = jsonDecode(resp.body);
    if (respp is Map &&
        respp.containsKey('status') &&
        (respp['status'] == "Token is Expired" ||
            respp['status'] == "Authorization Token not found")) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('/login', (route) => false);
      return resp;
    } else {
      return resp;
    }
  }

  Future<http.Response> get({String? url, headers}) async {
    final pref = await SharedPreferences.getInstance();
    final token = _session.token ?? pref.getString('token');
    headers ??= {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var resp = await http.get(
      Uri.parse('${Underwear.baseURL}$url'),
      headers: headers,
    );

    var respp = jsonDecode(resp.body);
    if (respp is Map &&
        respp.containsKey('status') &&
        (respp['status'] == "Token is Expired" ||
            respp['status'] == "Authorization Token not found")) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('/login', (route) => false);
      return resp;
    } else {
      return resp;
    }
  }

  Future<http.Response> delete({String? url, headers, data}) async {
    final pref = await SharedPreferences.getInstance();
    final token = _session.token ?? pref.getString('token');
    headers ??= {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var resp = await http.delete(
      Uri.parse('${Underwear.baseURL}$url'),
      headers: headers,
      body: data,
    );

    var respp = jsonDecode(resp.body);
    if (respp is Map &&
        respp.containsKey('status') &&
        (respp['status'] == "Token is Expired" ||
            respp['status'] == "Authorization Token not found")) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('/login', (route) => false);
      return resp;
    } else {
      return resp;
    }
  }

  Future<http.Response> put({String? url, headers, data}) async {
    final pref = await SharedPreferences.getInstance();
    final token = _session.token ?? pref.getString('token');
    headers ??= {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var resp = await http.put(
      Uri.parse('${Underwear.baseURL}$url'),
      headers: headers,
      body: data,
    );

    var respp = jsonDecode(resp.body);
    if (respp is Map &&
        respp.containsKey('status') &&
        (respp['status'] == "Token is Expired" ||
            respp['status'] == "Authorization Token not found")) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('/login', (route) => false);
      return resp;
    } else {
      return resp;
    }
  }
}
