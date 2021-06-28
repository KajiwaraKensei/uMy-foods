import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

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
final List<Map<String, dynamic>> listItems = [
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
  {
    'Text': 'カントリーマアム6',
    'image': 'https://www.toysrus.co.jp/i/5/0/8/508961100AML.jpg',
  },
  {
    'Text': 'カントリーマアム7',
    'image': 'https://www.toysrus.co.jp/i/5/0/8/508961100AML.jpg',
  },
  {
    'Text': 'カントリーマアム8',
    'image': 'https://www.toysrus.co.jp/i/5/0/8/508961100AML.jpg',
  },
];

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

  Widget ListItemWidget = Text(""); //表示用ウィジェット
  String _textex = "";

  //比較リストを返す
  SingleChildScrollView showListItems() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // 3行
          for (int x = 0; x < 3; x++)
            Row(
              children: [
                // 横に4個並べる  4を変えれば変わる
                // i = 0 +(x * 4) ・・・2列目なら4から、3列目なら8から
                // i < 4 * (x + 1) ・・・2列目なら8まで、3列目なら12まで
                for (int i = 0 + (x * 4); i < 4 * (x + 1); i++)
                  if (listItems.length > i)
                    Card(
                      //margin: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 180.0,
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
                                        _deleteItem(i);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Image.network(
                              listItems[i]['image'],
                              height: 120.0,
                              width: 120.0,
                            ),
                            Text(
                              listItems[i]['Text'],
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
              ],
            ),
        ],
      ),
    );
  }

  void _deleteItem(i) {
    setState(() {
      listItems.removeAt(i); // 削除
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
      // Center から変更 スクロールできるようにする
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // 3行
            for (int x = 0; x < 3; x++)
              Row(
                children: [
                  // 横に4個並べる  4を変えれば変わる
                  // i = 0 +(x * 4) ・・・2列目なら4から、3列目なら8から
                  // i < 4 * (x + 1) ・・・2列目なら8まで、3列目なら12まで
                  for (int i = 0 + (x * 4); i < 4 * (x + 1); i++)
                    if (listItems.length > i)
                      Card(
                        //margin: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 180.0,
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
                                          _deleteItem(i);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Image.network(
                                listItems[i]['image'],
                                height: 120.0,
                                width: 120.0,
                              ),
                              Text(
                                listItems[i]['Text'],
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                ],
              ),
          ],
        ),
      ),
      // 比較リスト
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor('ec9463'),
        tooltip: 'Increment',
        child: Icon(Icons.assignment, color: Colors.white),
        onPressed: () async {
          // MyHomePageと同期をとるだけのsetState
          setState(() {});
          return showDialog<void>(
            context: context,
            barrierDismissible: true, // user must tap button!
            builder: (BuildContext context) {
              //Statefulなダイアログのクラスを作成したので呼び出し
              return MyDialog();

              // return AlertDialog(
              //   backgroundColor: HexColor('f5f3ef'),
              //   title: const Text('Food List'),
              //   content: Container(
              //     width: MediaQuery.of(context).size.width * .8,
              //     child: ListItemWidget = showListItems(), // 比較リストを返す関数
              //   ),
              //   actions: <Widget>[
              //     Center(
              //       child: Row(
              //         // 均等配置
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Opacity(
              //             opacity: 0.0,
              //           ),
              //           Opacity(
              //             opacity: 0.0,
              //           ),
              //           Opacity(
              //             opacity: 0.0,
              //           ),
              //           OutlinedButton(
              //             child: const Text('比較'),
              //             style: TextButton.styleFrom(primary: Colors.black),
              //             onPressed: () {
              //               Navigator.of(context).pop();
              //             },
              //           ),
              //           Opacity(
              //             opacity: 0.0,
              //           ),
              //           TextButton.icon(
              //             onPressed: () {
              //               Navigator.of(context).pop();
              //             },
              //             icon: Icon(
              //               Icons.delete_outlined,
              //             ),
              //             label: Text('全体削除'),
              //             style: TextButton.styleFrom(
              //               primary: HexColor('8c6e63'),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // );
            },
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

//Statefulなダイアログクラス
class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  Widget ListItemWidget = Text("");

  SingleChildScrollView showListItems() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // 3行
          for (int x = 0; x < 3; x++)
            Row(
              children: [
                // 横に4個並べる  4を変えれば変わる
                // i = 0 +(x * 4) ・・・2列目なら4から、3列目なら8から
                // i < 4 * (x + 1) ・・・2列目なら8まで、3列目なら12まで
                for (int i = 0 + (x * 4); i < 4 * (x + 1); i++)
                  if (listItems.length > i)
                    Card(
                      //margin: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 180.0,
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
                                        _deleteItem(i);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Image.network(
                              listItems[i]['image'],
                              height: 120.0,
                              width: 120.0,
                            ),
                            Text(
                              listItems[i]['Text'],
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
              ],
            ),
        ],
      ),
    );
  }

  void _deleteItem(i) {
    setState(() {
      listItems.removeAt(i); // 削除
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: HexColor('f5f3ef'),
      title: const Text('Food List'),
      content: Container(
        width: MediaQuery.of(context).size.width * .6,
        child: ListItemWidget = showListItems(), // 比較リストを返す関数
      ),
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
                  setState(() {
                    listItems.removeRange(0, listItems.length);
                  });
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
  }
}
