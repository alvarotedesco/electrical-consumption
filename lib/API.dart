import 'dart:io';

import 'package:electrical_comsuption/themes/luvas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> getData(url) async {
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

    return resposta;
  } else {
    return [response];
  }
  // decode retorna uma lista, onde eu pego o primeiro (0)
  // e o title é uma propriedade json.
}

Future<Map<String, dynamic>> postData(String url, data) async {
  var prefs = await SharedPreferences.getInstance();
  var token = (prefs.getString("tokenjwt") ?? "");
  data = json.encode(data);

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $token",
  };

  var response = await http.post(Uri.parse('${Underwear.baseURL}$url'),
      headers: headers, body: data);

  if (response.statusCode >= 200 && response.statusCode < 300) {
    Map<String, dynamic> resposta = json.decode(response.body);

    return resposta;
  } else {
    return {"error": "erro", "data": response.statusCode};
  }
}

Future<Map<String, dynamic>> doLogin(String url, data) async {
  Map<String, String> headers = {"Content-Type": "application/json"};
  data = json.encode(data);

  var prefs = await SharedPreferences.getInstance();

  var response = await http.post(Uri.parse('${Underwear.baseURL}$url'),
      headers: headers, body: data);

  if (response.statusCode >= 200 && response.statusCode < 300) {
    Map<String, dynamic> resposta = json.decode(response.body);

    prefs.setString("tokenjwt", resposta["token"]);

    return resposta;
  } else {
    return {"error": "erro", "data": response.toString()};
  }
}

Future<double> getTotal() async {
  var prefs = await SharedPreferences.getInstance();
  var ind = prefs.getInt('qtdIndex') ?? 0;

  for (var i = 0; i < ind; i++) {
    var hour = int.parse(prefs.getString('hoursControls$i'));
    var day = int.parse(prefs.getString('daysControls$i'));
    var qtd = int.parse(prefs.getString('qtdControls$i'));
    var pwr = prefs.getDouble('pwrDevices$i');

    return hour * day * qtd * pwr / 1000;
  }
  return 0.0;
}
