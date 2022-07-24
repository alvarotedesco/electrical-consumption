import 'package:electrical_comsuption/themes/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> getData(url) async {
  var prefs = await SharedPreferences.getInstance();
  var token = (prefs.getString("tokenjwt") ?? "");

  var response = await http.get(
    Uri.parse('${Underwear.baseURL}$url'),
    headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    },
  ).catchError((e) {
    print('servidor desligado, Provavelmente');
  }).timeout(const Duration(seconds: 30));

  if (response.statusCode == 401) {}

  if (response.statusCode >= 200) {
    var resposta = json.decode(response.body);

    return {"status": "success", "data": resposta};
  } else {
    return {"status": "error", "data": response};
  }
}

Future<Map<String, dynamic>> postData(String url, data) async {
  var prefs = await SharedPreferences.getInstance();
  var token = (prefs.getString("tokenjwt") ?? "");
  if (token != '') {
    data = json.encode(data);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var response = await http.post(Uri.parse('${Underwear.baseURL}$url'),
        headers: headers, body: data);

    if (response.statusCode == 200) {
      Map<String, dynamic> resposta = jsonDecode(response.body);

      return {"status": "success", "data": resposta};
    } else {
      return {"status": "error", "data": response.statusCode};
    }
  } else {
    return {
      "status": "error",
      "data": "Token Expirado, faça o Login novamente!!"
    };
  }
}

Future<Map<String, dynamic>> doLogin(String url, data) async {
  Map<String, String> headers = {"Content-Type": "application/json"};
  data = json.encode(data);

  var response = await http.post(Uri.parse('${Underwear.baseURL}$url'),
      headers: headers, body: data);

  if (response.statusCode == 200) {
    Map<String, dynamic> resposta = jsonDecode(response.body);

    var prefs = await SharedPreferences.getInstance();
    prefs.setString("tokenjwt", resposta["token"]);

    return {"status": "success", "data": resposta};
  } else {
    return {"status": "error", "data": response.toString()};
  }
}

Future<Map<String, dynamic>> postDevice(String url, data) async {
  var prefs = await SharedPreferences.getInstance();
  var token = (prefs.getString("tokenjwt") ?? "");
  data = json.encode(data);

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $token",
  };

  var response = await http.post(Uri.parse('${Underwear.baseURL}$url'),
      headers: headers, body: data);

  if (response.statusCode == 200) {
    return {"status": "success", "Message": "deu certo"};
  } else {
    return {"status": "error", "data": response.statusCode};
  }
}
