import 'package:http/http.dart' as http;
import 'dart:convert';

// Future<http.Response> GetData(url) async {
//   http.Response response = await http.get(Uri.parse(url));
//   print(response);
//   print(url);
//   print(response.body);
//   return json.decode(response.body);
// }

Future<String> getData(url) async {
  var response =
      await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

  print(response);
  // decode retorna uma lista, onde eu pego o primeiro (0)
  // e o title é uma propriedade json.
  var title = json.decode(response.body)[0]['title'];

  return "title";
}

