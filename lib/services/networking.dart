import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    String data;
    http.Response response = await http.get(url);
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
//      return response.body;
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
    return data;
  }
}
