import 'package:flutter/material.dart';
import 'package:umy_foods/comparison.dart';
import 'package:umy_foods/header.dart';
import 'package:umy_foods/footer.dart';
import 'package:umy_foods/details/details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'uMyFoods',
        theme: ThemeData(primarySwatch: Colors.blue),
        debugShowCheckedModeBanner: false,
        home: Home());
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 1000,
                child: Column(children: [
                  Text('トップページ',
                      style:
                          TextStyle(fontSize: 25, color: HexColor('8C6E63'))),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(),
                            ));
                      },
                      child: Text('詳細画面')),
                ])),
            FooterCreate(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor('ec9463'),
        tooltip: 'Increment',
        child: Icon(Icons.assignment, color: Colors.white),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Comparison(),
              ));
        },
      ),
    );
  }
}

//16進数カラーコード
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
