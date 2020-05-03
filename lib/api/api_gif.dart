import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiGif {
  ApiGif._instantiate();

  static final ApiGif instance = ApiGif._instantiate();

  final String _GifUrl = "api.giphy.com/v1/gifs/trending?";
  static const String API_KEY = "7R231W6HL4kRiLfiTKn0JwERHbU6YAxn";

  Future<Map> _recuperaGifs() async {
    http.Response response;
    response = await http.get("${_GifUrl}api_key=${API_KEY}&limit=20&rating=G");
    return json.decode(response.body);
  }

}