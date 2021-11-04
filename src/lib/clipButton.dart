import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:umy_foods/HexColor.dart';
import 'package:umy_foods/alert.dart';
import 'package:umy_foods/comparison.dart';
import 'package:umy_foods/login/signup.dart';
import 'package:umy_foods/main.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; //DB

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

class clipButton extends StatefulWidget {
  clipButton(this.where);
  final String where;
  @override
  _clipButtonState createState() => _clipButtonState(where);
}

class _clipButtonState extends State<clipButton> {
  _clipButtonState(this.where);
  String where;
  int _counter = 0;

  Widget ListItemWidget = Text(""); //表示用ウィジェット
  String _textex = "";

  @override
  void initState() {
    super.initState();
    Future(() async {
      final user = await FirebaseAuth.instance.currentUser;
      setState(() {
        final data = user?.uid;
        if (data != null) {
          UID = data;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var media_width = MediaQuery.of(context).size.width;
    var media_height = MediaQuery.of(context).size.height;
    return Container(
      width: 200.0, //ここでクリップボタンのサイズ変更可能
      child: Stack(overflow: Overflow.visible, children: [
        //tooltip: 'クリップボード',
        Container(
          width: media_width * 0.15,
          height: media_height * 0.15,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              primary: HexColor('ec9463'),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Icons.assignment,
                color: Colors.white,
                size: 40,
              ),
              Text(
                '比較',
              ),
            ]),
            onPressed: () async {
              // MyHomePageと同期をとるだけのsetState
              final snapshot = FirebaseAuth.instance.currentUser;
              setState(() {});
              if (snapshot != null)
                return showDialog<void>(
                  context: context,
                  barrierDismissible: true, // user must tap button!
                  builder: (BuildContext context) {
                    //Statefulなダイアログのクラスを作成したので呼び出し
                    return MyDialog(where);
                  },
                );
              else
                return showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return LoginAlert();
                    });
            },
          ),
        ),
        Positioned(
            top: -13,
            left: 110,
            child: NotificationNumberBadge(HexColor('fea675'))) //通知
      ]),
    ); //This trailing comma makes auto-formatting nicer for build methods.
  }
  //右上の通知ボタン

  Widget NotificationNumberBadge(Color col) {
    Future<String> _uid() async {
      final snapshot = await FirebaseAuth.instance.currentUser?.uid.toString();
      //ログイン中のユーザーIDをDBから取得
      if (snapshot != null) {
        final String id = snapshot;
        setState(() {});
        return id;
      } else
        return 'null';
    }

    //String Uid = getUID().toString();
    //String Uid = getUID();
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          final user = FirebaseAuth.instance.currentUser;
          final data = user?.uid;
          if (data != null) {
            String id = data.toString();
            return StreamBuilder<QuerySnapshot>(

                //表示したいFiresotreの保存先を指定
                stream: FirebaseFirestore.instance
                    .collection('/account/' + id + '/clip_list')
                    .snapshots(),

                //streamが更新されるたびに呼ばれる
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  //データが取れていない時の処理
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());

                  final result = snapshot.data!.docs;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.brightness_1,
                        color: col,
                        size: 50,
                      ),
                      Text(
                        result.length.toString(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                });
            //Text(data.toString());
          } else
            return Text('pleaseWait');
        }
        return Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.brightness_1,
              color: col,
              size: 50,
            ),
            Text(
              '0',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}

//Statefulなダイアログクラス
class MyDialog extends StatefulWidget {
  MyDialog(this.where);
  String where;
  @override
  _MyDialogState createState() => _MyDialogState(where);
}

class _MyDialogState extends State<MyDialog> {
  _MyDialogState(this.where);
  String where;
  Widget ListItemWidget = Text("");

  void _deleteItem(product_id, uid) {
    //String Uid = getUID().toString(); //ログイン中のユーザーIDをDBから取得
    // 削除
    FirebaseFirestore.instance
        .collection('/account/' + uid + '/clip_list/')
        .doc(product_id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    List<String> clipList = [];
    //String Uid = getUID().toString(); //ログイン中のユーザーIDをDBから取得
    SingleChildScrollView showListItems(result, uid) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: <Widget>[
            Row(
              children: [
                // 横に4個並べる  4を変えれば変わる
                // i = 0 +(x * 4) ・・・2列目なら4から、3列目なら8から
                // i < 4 * (x + 1) ・・・2列目なら8まで、3列目なら12まで
                for (int i = 0; i < 5; i++)
                  if (result.length > i)
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
                                        showDialog<int>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('確認'),
                                              content: Text(
                                                  'クリップボードから削除します。よろしいですか。'),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text('削除'),
                                                  onPressed: () {
                                                    _deleteItem(
                                                        result[i]['product_id'],
                                                        uid);
                                                    //clipList.removeAt(i);
                                                    clipList = [];
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text('戻る'),
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Image.network(
                              (result[i]['image_url'] == "")
                                  ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf'
                                  : result[i]['image_url'],
                              height: 120.0,
                              width: 120.0,
                            ),
                            Container(
                              height: 50,
                              child: Text(
                                result[i]['product_name'],
                                style: TextStyle(fontSize: 16),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
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

    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final user = FirebaseAuth.instance.currentUser;
            final data = user?.uid;
            if (data != null) {
              String uid = data.toString();
              return StreamBuilder<QuerySnapshot>(

                  //表示したいFiresotreの保存先を指定
                  stream: FirebaseFirestore.instance
                      .collection('/account/' + uid + '/clip_list')
                      .snapshots(),

                  //streamが更新されるたびに呼ばれる
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    //データが取れていない時の処理
                    if (!snapshot.hasData) return const Text('Loading...');
                    clipList = [];
                    final result = snapshot.data!.docs;
                    for (int i = 0; i < result.length; i++) {
                      clipList.add(result[i]['product_id']);
                    }
                    return AlertDialog(
                      backgroundColor: HexColor('f5f3ef'),
                      title: const Text('Food List'),
                      content: Container(
                        width: MediaQuery.of(context).size.width * .6,
                        child: ListItemWidget =
                            showListItems(result, uid), // 比較リストを返す関数
                        height: 250,
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
                                style:
                                    TextButton.styleFrom(primary: Colors.black),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Comparison(
                                            productList: clipList,
                                            where: where),
                                      ));
                                },
                              ),
                              Opacity(
                                opacity: 0.0,
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  showDialog<int>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('確認'),
                                        content: Text(
                                            '全てのアイテムをクリップボードから削除します。よろしいですか。'),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('削除'),
                                            onPressed: () {
                                              for (int i = 0;
                                                  i < result.length;
                                                  i++) {
                                                FirebaseFirestore.instance
                                                    .collection('/account/' +
                                                        uid +
                                                        '/clip_list/')
                                                    .doc(
                                                        result[i]['product_id'])
                                                    .delete();
                                              }
                                              clipList = [];
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('戻る'),
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                          ),
                                        ],
                                      );
                                    },
                                  );
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
                  });
            }
          } else {
            Text('pleaseWait');
          }
          return Text('pleaseLogin.');
        });
  }
}
