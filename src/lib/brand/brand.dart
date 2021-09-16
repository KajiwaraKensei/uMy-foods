import 'package:flutter/material.dart';
import 'dart:html';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:math';
// パッケージ
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';    //パンくず
import 'package:workspace/SpaceBox.dart';   //空間
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// 外部ファイル
// import 'package:workspace/HexColor.dart';   //16進数カラーコード
import 'package:workspace/footer.dart'; //ヘッダー
import 'package:workspace/header.dart'; //フッター

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // const MyApp({Key key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'uMy Foods',
      home: BrandListPage(),
    );
  }
}
class BrandListPage extends StatefulWidget {
  // const MyHomePage({Key key, String this.title}) : super(key: key);
  // final String title;
  @override
  State<BrandListPage> createState() => _BrandListState();
}

class _BrandListState extends State<BrandListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: Container(
        padding:  EdgeInsets.only(top: 10),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BreadCrumb( //パンくずリスト
                    items: <BreadCrumbItem>[
                      BreadCrumbItem(
                        content: TextButton(
                          onPressed: (){}, 
                          child: SelectableText('パン',style: TextStyle(color: Colors.black),scrollPhysics: NeverScrollableScrollPhysics(),),
                        ),
                      ),
                      BreadCrumbItem(
                        content: TextButton(
                          onPressed: (){}, 
                          child: SelectableText('くず',style: TextStyle(color: Colors.black),scrollPhysics: NeverScrollableScrollPhysics(),),
                        ),
                      ),
                    ],
                    divider: Icon(Icons.chevron_right),
                  ),
                  SpaceBox.height(30),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: HexColor('EC9361'),width: 4,)
                      )
                    ),
                    child: SelectableText(' ブランド一覧',style: TextStyle(color:Colors.black.withOpacity(0.6),fontSize: 23,fontWeight: FontWeight.bold),scrollPhysics: NeverScrollableScrollPhysics()),
                  ),
                ],
              )
            ),
            SpaceBox.height(30),
            Container(
              child: buildTaskList('brand/'),
            ),
            FooterCreate(),
          ],
        )
      )
    );
  }
  Widget buildTaskList(String path) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(path)
          .orderBy('brand_id', descending: true) //降順(brand_id)
          .limit(20) //取得件数
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: const CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        return GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          childAspectRatio: 5,
          children: snapshot.data!.docs.map((DocumentSnapshot document){
            final data = document.data() as Map<String, dynamic>;
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Card(
              child: InkWell(
                onTap: (){
                  setState(() {
                    //メーカーページへ
                  });
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 20,
                      child:SelectableText(' ${data['brand_name']}',scrollPhysics: NeverScrollableScrollPhysics()),
                    ),
                    Icon(
                      Icons.chevron_right_outlined,
                      color: Colors.grey,
                    ),
                  ],
                )
              )
            )
            );
          }).toList()
        );
      },
    );
  }
}
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