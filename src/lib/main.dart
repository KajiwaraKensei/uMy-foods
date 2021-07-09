import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

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
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'uMy Foods',
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
  const MyHomePage({Key key, String this.title}) : super(key: key);

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

Widget buildTaskList(String path) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection(path).snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) {
        return const Center(
          child: const CircularProgressIndicator(),
        );
      }
      if (snapshot.hasError) {
        return const Text('Something went wrong');
      }
      return ListView(
        children: snapshot.data.docs.map((DocumentSnapshot document) {
          final data = document.data() as Map<String, dynamic>;
          return Card(
            child: ListTile(
              title: Text(' ${data['category_name']}'),
            ),
          );
        }).toList(),
      );
    },
  );
}

String randomString(int length) {
  const _randomChars =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  const _charsLength = _randomChars.length;

  final rand = new Random();
  final codeUnits = new List.generate(
    length,
    (index) {
      final n = rand.nextInt(_charsLength);
      return _randomChars.codeUnitAt(n);
    },
  );
  return new String.fromCharCodes(codeUnits);
}

class _MyHomePageState extends State<MyHomePage> {
  // 作成したドキュメント一覧
  List<DocumentSnapshot> documentList = [];

  // 指定したドキュメントの情報
  String orderDocumentInfo = '';

  String messageText = '';

  List addcategory = [];

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
        body: Center(
          child: Column(
            children: <Widget>[
              /*ElevatedButton(
                child: Text('ドキュメント一覧取得'),
                onPressed: () async {
                  final snapshot = await FirebaseFirestore.instance
                      .collection('major_category')
                      .snapshots();
                  setState(() {
                    documentList = snapshot.docs;
                  });
                },
              ),*/
              Flexible(
                child: buildTaskList(
                    'major_category/002/category/001/sub_category/'),
                /*child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black38),
                          ),
                        ),
                        child: ListTile(
                          title: Text('$index'),
                          subtitle: Text(documentList
                              .data.documents[index].data['category_name']),
                          onTap: () {/* react to the tile being tapped */},
                        ));
                  },
                  itemCount: documentList.length,
                ),*/
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '追加カテゴリー'),
                onChanged: (String value) {
                  setState(() {
                    messageText = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              Container(
                child: ElevatedButton(
                  child: Text('追加'),
                  onPressed: () async {
                    String id = randomString(10);
                    // 投稿メッセージ用ドキュメント作成
                    await FirebaseFirestore.instance
                        .collection(
                            'major_category/002/category/001/sub_category/') // コレクションID指定
                        .doc(id) // ドキュメントID自動生成
                        .set({
                      'category_name': messageText,
                    });
                    addcategory.add(id);
                  },
                ),
              ),
              const SizedBox(height: 8),
              Container(
                child: ElevatedButton(
                  child: Text('データ削除'),
                  onPressed: () {
                    addcategory.forEach((docID) async {
                      await FirebaseFirestore.instance
                          .collection(
                              'major_category/002/category/001/sub_category/') // コレクションID指定
                          .doc(docID)
                          .delete();
                    });
                    addcategory = [];
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
