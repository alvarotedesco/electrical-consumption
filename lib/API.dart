import 'dart:io';

import 'package:electrical_comsuption/themes/luvas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String? token = "1";

Future<dynamic> getData(url) async {
  var response = await http.get(
    Uri.parse('${Underwear.baseURL}$url'),
    headers: {
      "Accept": "application/json",
      "Autorization": "bearer $token",
    },
  );

  if (response.statusCode == 200) {
    var resposta = json.decode(response.body);

    return resposta[0];
  } else {
    return '{"error": "erro", "data": $response}';
  }
  // decode retorna uma lista, onde eu pego o primeiro (0)
  // e o title é uma propriedade json.
}

Future<Map<String, dynamic>> postData(String url, data,
    [bool auth = false]) async {
  data = json.encode(data);
  Map<String, String> headers = {"Content-Type": "application/json"};

  if (auth) {
    headers = {
      "Accept": "*/*",
      "Content-Type": "application/json",
      "Autorization": "bearer $token",
    };
  }

  var response = await http.post(Uri.parse('${Underwear.baseURL}$url'),
      headers: headers, body: data);

  if (response.statusCode >= 200 && response.statusCode < 300) {
    Map<String, dynamic> resposta = json.decode(response.body);

    sleep(Duration(milliseconds: 2000));
    return resposta;
  } else {
    print(response.statusCode);

    return {"error": "erro", "data": response.toString()};
  }
  // decode retorna uma lista, onde eu pego o primeiro (0)
  // e o title é uma propriedade json.
}
