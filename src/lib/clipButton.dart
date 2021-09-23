import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:umy_foods/HexColor.dart';
import 'package:umy_foods/comparison.dart';
import 'package:umy_foods/main.dart';

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
    'Text': 'カントリーマアム',
    'image': 'https://www.toysrus.co.jp/i/5/0/8/508961100AML.jpg',
  },
  {
    'Text': 'エリーゼ',
    'image':
        'https://www.life-netsuper.jp/k-kinkicommon/parts/data/item/04901360273010.jpg',
  },
  {
    'Text': '苺トッポ',
    'image':
        'https://images-fe.ssl-images-amazon.com/images/I/71SBG7SSapL.__AC_SX300_SY300_QL70_ML2_.jpg',
  },
  {
    'Text': 'ポッキー',
    'image':
        'https://images-na.ssl-images-amazon.com/images/I/71mxyAVWynL._AC_SL1500_.jpg',
  },
  {
    'Text': 'パイの実',
    'image':
        'https://www.tanomail.com/imgcv/product/26/2621344_01.jpg?sr.dw=230&sr.dh=230',
  },
];

class clipButton extends StatefulWidget {
  /*clipButton(this.productID);
  final String productID;*/
  @override
  _clipButtonState createState() => _clipButtonState();
}

class _clipButtonState extends State<clipButton> {
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
                  if (clipList.length > i)
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
                              (clipList[i]['image'] == "")
                                  ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf'
                                  : clipList[i]['image'],
                              height: 120.0,
                              width: 120.0,
                            ),
                            Text(
                              clipList[i]['Text'],
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
      clipList.removeAt(i); // 削除
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0, //ここでクリップボタンのサイズ変更可能
      child: FloatingActionButton(
      backgroundColor: HexColor('ec9463'),
      tooltip: 'クリップボード',
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
          },
        );
      },
    ),
    ); //This trailing comma makes auto-formatting nicer for build methods.
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
                for (int i = 1 + (x * 4); i < 4 * (x + 1); i++)
                  if (clipList.length > i)
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
                              (clipList[i]['image'] == "")
                                  ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf'
                                  : clipList[i]['image'],
                              height: 120.0,
                              width: 120.0,
                            ),
                            Text(
                              clipList[i]['Text'],
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
      clipList.removeAt(i); // 削除
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Comparison(),
                      ));
                },
              ),
              Opacity(
                opacity: 0.0,
              ),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    clipList.removeRange(1, clipList.length);
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
