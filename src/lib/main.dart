import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: Text('title'),
            centerTitle: true,
            leading: Icon(Icons.menu),
            actions: [
              Icon(Icons.add),
              Icon(Icons.clear)
            ],
        ),
      ),
    );
  }
}