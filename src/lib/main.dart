import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workspace/comparison.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Comparison());
  }
}





// import 'package:flutter/material.dart';
// import 'train01.dart';
// import 'comparison.dart';

// void main() => runApp(MyApp());

// // カラーコードで色を指定するためのクラス
// class HexColor extends Color {
//   static int _getColorFromHex(String hexColor) {
//     hexColor = hexColor.toUpperCase().replaceAll('#', '');
//     if (hexColor.length == 6) {
//       hexColor = 'FF' + hexColor;
//     }
//     return int.parse(hexColor, radix: 16);
//   }

//   HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
// }
// // カラーコード ここまで

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Web Training',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   String _type = "偶数";

//   // 比較する商品数
//   int itemnum = 3;
//   // 比較するリスト　現在は仮でTextに表示する文字リスト
//   var textlist = ['カルビーポテトチップス', 'チップスター', '堅あげポテト'];

//   // 連主要
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//       if (_counter % 2 == 0) {
//         _type = "偶数";
//       } else {
//         _type = "奇数";
//       }
//     });
//   }

//   // リストの入れ替え(右移動)
//   void changeListR(int x) {
//     // x・・・対象の添え字
//     if (x != itemnum - 1) {
//       String temp = textlist[x];
//       setState(() {
//         textlist[x] = textlist[x + 1];
//         textlist[x + 1] = temp;
//       });
//     }
//   }

//   // リストの入れ替え(左移動)
//   void changeListL(int x) {
//     if (x != 0) {
//       String temp = textlist[x];
//       setState(() {
//         textlist[x] = textlist[x - 1];
//         textlist[x - 1] = temp;
//       });
//     }
//   }

//   void deleteList(int x) {
//     setState(() {
//       textlist.removeAt(x); // 添え字xの要素を削除
//       itemnum -= 1;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('DEEMO'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // < > x を表示
//             Row(
//               //mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 // 一列目
//                 if (itemnum >= 1) showGL(0),
//                 if (itemnum >= 1) showGR(0),
//                 if (itemnum >= 1) showGX(0),
//                 // 二列目
//                 if (itemnum >= 2) showGL(1),
//                 if (itemnum >= 2) showGR(1),
//                 if (itemnum >= 2) showGX(1),
//                 // 三列目
//                 if (itemnum >= 3) showGL(2),
//                 if (itemnum >= 3) showGR(2),
//                 if (itemnum >= 3) showGX(2),
//                 // 四列目
//                 if (itemnum >= 4) showGL(3),
//                 if (itemnum >= 4) showGR(3),
//                 if (itemnum >= 4) showGX(3),
//               ],
//             ),
//             // 比較リストを表示する場所
//             Row(
//               //mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 if (itemnum >= 1) Text(textlist[0]),
//                 if (itemnum >= 2) Text(textlist[1]),
//                 if (itemnum >= 3) Text(textlist[2]),
//                 if (itemnum >= 4) Text(textlist[3]),
//               ],
//             ),
//             // 比較リストここまで

//             // 以下練習用ウィジェット
//             RaisedButton(
//               child: Text('次へ'),
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => Comparison(),
//                     ));
//               },
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }

//   GestureDetector showGL(int i) {
//     return GestureDetector(
//         onTap: () => {changeListL(i)},
//         child: Icon(
//           Icons.chevron_left,
//           color: HexColor('696969'),
//         ));
//   }

//   GestureDetector showGR(int i) {
//     return GestureDetector(
//         onTap: () => {changeListR(i)},
//         child: Icon(
//           Icons.chevron_right,
//           color: HexColor('696969'),
//         ));
//   }

//   GestureDetector showGX(int i) {
//     return GestureDetector(
//         onTap: () => {deleteList(i)},
//         child: Icon(
//           Icons.close,
//           color: HexColor('696969'),
//         ));
//   }
//   //if (_counter % 2 == 0)
//   // IconButton(
//   // 	onPressed: () => {print('ヒ・ダリ')},
//   // 	icon: Icon(Icons.chevron_left),
//   // 	color: HexColor('696969'),
//   // 	iconSize: 24.0,
//   // 	hoverColor: Colors.white.withOpacity(0.1),
//   // 	highlightColor: Colors.white.withOpacity(0.1),
//   // 	splashColor: Colors.white.withOpacity(0.1),

//   // ),
// }
