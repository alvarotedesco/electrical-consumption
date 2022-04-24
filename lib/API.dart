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
