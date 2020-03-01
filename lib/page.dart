import 'package:flutter/material.dart';

class Page extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gifs"),
        backgroundColor: Colors.blue.shade700,
      ),
      body: ListView.builder(
          itemCount: 5,
          itemExtent: 200,
          itemBuilder: (BuildContext context, int index){
          return Container(
            padding: EdgeInsets.fromLTRB(8, 18, 8, 18),
            child: Text("Altos textos"),
          );
      }),
    );
  }

}