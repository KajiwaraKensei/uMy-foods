import 'package:flutter/material.dart';

// パッケージ
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';    //パンくず

// 外部ファイル
import 'package:workspace/HexColor.dart';   //16進数カラーコード
import 'package:workspace/SpaceBox.dart';   //空間
import 'package:workspace/details/product.dart';  //商品情報
import 'package:workspace/details/review.dart'; //レビュー

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
      home: DetailsPage(),
    );
  }
}

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
            child: ListView(
              children: [
                //パンくずリスト
                BreadCrumb( //パンくずリスト
                  items: <BreadCrumbItem>[
                    BreadCrumbItem(
                      content: GestureDetector(
                        child: Text('パン'),
                        onTap: (){
                          setState(() {});
                        },
                      )
                    ),
                    BreadCrumbItem(
                      content: GestureDetector(
                        child: Text('くず'),
                        onTap: (){
                          setState(() {});
                        },
                      )
                    ),
                  ],
                  divider: Icon(Icons.chevron_right),
                ),
                SpaceBox.height(20),
                //商品詳細
                ProductPage(),  
                 //仕切り線
                const Divider(
                  height: 20,
                  thickness: 5,
                  indent: 0,
                  endIndent: 0,
                ),
                //レビュー
                ReviewPage(),
              ],
            ),
          ),
          //フッター固定ボタン
          Align(
            alignment: Alignment.bottomCenter,
            child: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
              child: 
              Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 17),
                width: 300,
                decoration: BoxDecoration(
                  color: HexColor('EC9361'),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  child: Row(
                    children: [
                      ElevatedButton( //レビューボタン
                        child: const Text('この商品をレビューする'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 25),
                          primary: Colors.white,
                          onPrimary: HexColor('EC9361'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                      ),
                      SpaceBox.width(20),
                      ElevatedButton( //クリップボタン
                        child: Icon(Icons.assignment_turned_in,),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(15),
                          primary: Colors.white,
                          onPrimary: HexColor('EC9361'),
                          shape: CircleBorder(
                            side: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              )
            )
          ),
      ],),
    );
  }
}