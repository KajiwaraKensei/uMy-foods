import 'package:flutter/material.dart';
import 'package:workspace/review_post/review_post.dart';   
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

  @override
class _MyHomePageState extends State<MyHomePage> {
  Widget build(BuildContext context) {
    return ReviewPostPage();
  }
}

