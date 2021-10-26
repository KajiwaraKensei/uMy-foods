import 'package:flutter/material.dart';
import 'dart:html';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:math';
// パッケージ
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart'; //パンくず
import 'package:umy_foods/SpaceBox.dart'; //空間
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// 外部ファイル
import 'package:umy_foods/HexColor.dart'; //16進数カラーコード
import 'package:umy_foods/header.dart';
import 'package:umy_foods/footer.dart';
import 'package:umy_foods/main.dart';

class BrandListPage extends StatefulWidget {
  // const MyHomePage({Key key, String this.title}) : super(key: key);
  // final String title;
  @override
  State<BrandListPage> createState() => _BrandListState();
}

class _BrandListState extends State<BrandListPage> {
  List docList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: ListView(
              children: [
                BreadCrumb(
                  //パンくずリスト
                  items: <BreadCrumbItem>[
                    BreadCrumbItem(
                      content: GestureDetector(child: Text('TOP')),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyApp(),
                            ));
                        setState(() {});
                      },
                    ),
                    BreadCrumbItem(
                      content: TextButton(
                        onPressed: () {},
                        child: SelectableText(
                          'ブランド一覧',
                          style: TextStyle(color: Colors.black),
                          scrollPhysics: NeverScrollableScrollPhysics(),
                        ),
                      ),
                    ),
                  ],
                  divider: Icon(Icons.chevron_right),
                ),
                SpaceBox.height(30),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(
                    color: HexColor('EC9361'),
                    width: 4,
                  ))),
                  child: SelectableText(' ブランド一覧', style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 23, fontWeight: FontWeight.bold), scrollPhysics: NeverScrollableScrollPhysics()),
                ),
                // for文でメーカー名から繰り返し表示
                for (var i = 0; i < 3; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SpaceBox.height(30),
                      // メーカー名
                      Container(
                        child: SelectableText(
                          '明治',
                          style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 23, fontWeight: FontWeight.bold),
                          scrollPhysics: NeverScrollableScrollPhysics(),
                        ),
                      ),
                      // メーカー毎のブランド一覧
                      Container(
                        child: buildTaskList('/maker/02zzgbAq1OxeXVMxoEhq/brand/'), // 明治を指定中
                      ),
                    ],
                  ),
                FooterCreate(),
              ],
            )));
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
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              final data = document.data() as Map<String, dynamic>;
              return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Card(
                      child: InkWell(
                          onTap: () {
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
                                child: SelectableText(' ${data['brand_name']}', scrollPhysics: NeverScrollableScrollPhysics()),
                              ),
                              Icon(
                                Icons.chevron_right_outlined,
                                color: Colors.grey,
                              ),
                            ],
                          ))));
            }).toList());
      },
    );
  }
}
