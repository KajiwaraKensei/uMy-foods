import 'package:flutter/material.dart';
import 'train01.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Training',
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

class _MyHomePageState extends State<MyHomePage> {
  String title = "Click!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              child: Text('次へ'),
                onPressed: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NextPage(),
                  )
                );
                },
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 50.0
              ),
            ),
            Text(
              "↓",
              style: TextStyle(
                fontSize: 30.0
              ),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  title = "クリックされた！";
                });
              },
              child: Text(
                "Hello, Flutter!",
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.green
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


