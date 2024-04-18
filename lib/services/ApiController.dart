import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiController {
 
  static get(String url) async {
    var response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }

 
}
