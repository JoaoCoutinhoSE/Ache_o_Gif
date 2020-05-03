import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Page();
  }
}
const String API_KEY = "7R231W6HL4kRiLfiTKn0JwERHbU6YAxn";
final String _GifUrl = "http://api.giphy.com/v1/gifs/trending?";

Future<List<Gif>> _recuperaGifs() async {
  http.Response response;
  response = await http.get("${_GifUrl}api_key=${API_KEY}&limit=20&rating=G");
  return compute(parseGifs, response.body);
}

List<Gif> parseGifs(String responseBody) {
  var parsed = jsonDecode(responseBody);
  var gifs = parsed["data"] as List;
  return gifs.map<Gif>((json) => Gif.fromJson(json)).toList();
}

class Gif {
  final String title;
  final String url;

  Gif({this.title, this.url});

  factory Gif.fromJson(Map<String, dynamic> json) {
    return Gif(
      title: json['title'] as String,
      url: json['images']['fixed_height']['url'] as String
    );
  }
}

class _Page extends State<Page> {

  Future<List<Gif>> recuperaGifs;



  @override
  void initState() {
    super.initState();
    recuperaGifs = _recuperaGifs();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Gifs"),
          backgroundColor: Colors.blue.shade700,
        ),
        body: Center(
          child:
            FutureBuilder<List<Gif>>(
              future: recuperaGifs,
              builder: (context, snapshot) {
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index){
                      return Image.network(snapshot.data[index].url);
                    }
                );
              },
            )
          ,
        ));
  }
}
