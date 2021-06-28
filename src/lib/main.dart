import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const MaterialColor customSwatch = const MaterialColor(
  0xFFf5f3ef,
  const <int, Color>{
    50: const Color(0xFFFEFEFD),
    100: const Color(0xFFFCFBFA),
    200: const Color(0xFFFAF9F7),
    300: const Color(0xFFF8F7F4),
    400: const Color(0xFFF7F5F1),
    500: const Color(0xFFF5F3EF),
    600: const Color(0xFFF4F1ED),
    700: const Color(0xFFF2EFEB),
    800: const Color(0xFFF0EDE8),
    900: const Color(0xFFEEEAE4),
  },
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: customSwatch,
      ),
      home: const MyHomePage(title: 'Flutter デモページ'),
    );
  }
}

//カラーコードで色指定できるクラス
//使う時は、HexColor('ec9463')
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final List<Map<String, dynamic>> _listItems = [
    {
      'Text': 'カントリーマアム1',
      'image': 'https://www.toysrus.co.jp/i/5/0/8/508961100AML.jpg',
    },
    {
      'Text': 'カントリーマアム2',
      'image': 'https://www.toysrus.co.jp/i/5/0/8/508961100AML.jpg',
    },
    {
      'Text': 'カントリーマアム3',
      'image': 'https://www.toysrus.co.jp/i/5/0/8/508961100AML.jpg',
    },
    {
      'Text': 'パイの実',
      'image':
          'https://www.tanomail.com/imgcv/product/26/2621344_01.jpg?sr.dw=230&sr.dh=230',
    },
    {
      'Text': 'カントリーマアム4',
      'image': 'https://www.toysrus.co.jp/i/5/0/8/508961100AML.jpg',
    },
    {
      'Text': 'カントリーマアム5',
      'image': 'https://www.toysrus.co.jp/i/5/0/8/508961100AML.jpg',
    },
  ];

  String _textex = "";

  void _deleteItem(i) async {
    setState(() {
      _listItems.removeAt(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(children: [
        Image.asset(
          'images/icon.png',
          height: 80.0,
          width: 80.0,
        ),
      ])),
      drawer: Drawer(child: Center(child: Text("Drawer"))),
      body: Column(
        children: <Widget>[
          ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _listItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  child: RaisedButton(
                    child: Text(_listItems[index]["Text"]),
                    onPressed: () {
                      _deleteItem(index);
                    },
                  ),
                );
              }),
          TextButton(
              child: Text('Alert'),
              onPressed: () async {
                return showDialog<void>(
                  context: context,
                  barrierDismissible: true, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: HexColor('f5f3ef'),
                      title: const Text('Food List'),
                      content: StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return new Container(
                          child: RaisedButton(
                            child: Text(_textex),
                            onPressed: () {
                              _textex = "ほげほげ";
                            },
                          ),
                        );
                      }),
                    );
                  },
                );
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor('ec9463'),
        tooltip: 'Increment',
        child: Icon(Icons.assignment, color: Colors.white),
        onPressed: () async {
          return showDialog<void>(
            context: context,
            barrierDismissible: true, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: HexColor('f5f3ef'),
                title: const Text('Food List'),
                content: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return new Container(
                    width: MediaQuery.of(context).size.width * .8,
                    child: new GridView.builder(
                        itemCount: _listItems.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            //margin: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ButtonTheme(
                                  child: ButtonBar(
                                    children: [
                                      Tooltip(
                                        message: 'クリップボードから削除します。',
                                        child: IconButton(
                                          icon: const Icon(Icons.close,
                                              color: Colors.black),
                                          onPressed: () {
                                            _deleteItem(index);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Image.network(
                                  _listItems[index]['image'],
                                  height: 120.0,
                                  width: 120.0,
                                ),
                                Text(
                                  _listItems[index]['Text'],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          );
                        }),
                  );
                }),
                actions: <Widget>[
                  Center(
                    child: Row(
                      // 均等配置
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Opacity(
                          opacity: 0.0,
                        ),
                        Opacity(
                          opacity: 0.0,
                        ),
                        Opacity(
                          opacity: 0.0,
                        ),
                        OutlinedButton(
                          child: const Text('比較'),
                          style: TextButton.styleFrom(primary: Colors.black),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Opacity(
                          opacity: 0.0,
                        ),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.delete_outlined,
                          ),
                          label: Text('全体削除'),
                          style: TextButton.styleFrom(
                            primary: HexColor('8c6e63'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
