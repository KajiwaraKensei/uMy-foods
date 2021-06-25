import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Horizontal List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 100.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                width: 300,
                color: Colors.red,
              ),
              Container(
                width: 300,
                color: Colors.blue,
              ),
              Container(
                width: 300,
                color: Colors.green,
              ),
              Container(
                width: 300,
                color: Colors.yellow,
              ),
              Container(
                width: 310,
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}