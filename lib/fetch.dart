import 'dart:convert';

import 'package:http/http.dart' as http;


Future<dynamic> fetch(String path) async {
  var res = await http.get(
      Uri.parse("http://62.84.122.44:8000/" + path),
      headers: {
        'Accept': 'application/json; charset=unicode'
        });

  var parsed_res = json.decode(utf8.decode(res.bodyBytes));
  return parsed_res;
}