import 'dart:convert';

import 'package:http/http.dart' as http;


Future<dynamic> fetch(String path) async {
  var res = await http.get(
      Uri.parse("http://62.84.122.44:8000/" + path),
      headers: {
        'Accept': 'application/json; charset=unicode'
        });
  var parsed_res;
  try {
    parsed_res = json.decode(utf8.decode(res.bodyBytes));
  // ignore: empty_catches
  } on FormatException {

  }
  
  return parsed_res;
}