import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:permission_handler/permission_handler.dart';

class NetworkHelper{
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print(response.statusCode);
      String data = response.body;

      return jsonDecode(data);
    }
    else {
      print(response.statusCode);
    }
  }
}
