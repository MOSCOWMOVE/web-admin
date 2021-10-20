import 'dart:convert';

import 'package:http/http.dart' as http;


Future<dynamic> fetch(String path, {bool is_absolute=false} ) async {
  var res = await http.get(
      Uri.parse((is_absolute ? "" : "http://62.84.122.44:8000/") + path),
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


Future<dynamic> fetch_pagination(String url, {bool is_absolute = false}) async {
  List<dynamic> res = [];

  dynamic fetch_res = await fetch(
    url, is_absolute: is_absolute
  );
  res.addAll(fetch_res["results"]);
  if (fetch_res["next"] != null) {
    res.addAll(await fetch_pagination(fetch_res["next"], is_absolute: true));
  }

  return res;
}