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

class _Page extends State<Page> {
  final String _GifUrl = "http://api.giphy.com/v1/gifs/trending?";
  static const String API_KEY = "7R231W6HL4kRiLfiTKn0JwERHbU6YAxn";

  Future<Map> _recuperaGifs() async {
    http.Response response;
    response = await http.get("${_GifUrl}api_key=${API_KEY}&limit=20&rating=G");
    print(response.body);
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    _recuperaGifs().then((map) {
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Gifs"),
          backgroundColor: Colors.blue.shade700,
        ),
        body: Column(
          children: <Widget>[
            FutureBuilder(
              future: _recuperaGifs(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    return ListView.builder(
                          itemCount: snapshot.data.lenght,
                          itemBuilder: (context, index) {
                            return snapshot.data[index]["title"];
                          }
                    );
                  case ConnectionState.waiting:
                    print("ll");
                    break;
                  case ConnectionState.none:
                  default:
                }
              },
            )
          ],
        ));
  }
}
