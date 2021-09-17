import 'package:flutter/material.dart';

// パッケージ
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart'; //パンくず

// 外部ファイル
import 'package:umy_foods/HexColor.dart'; //16進数カラーコード
import 'package:umy_foods/SpaceBox.dart'; //空間
import 'package:umy_foods/details/product.dart'; //商品情報
import 'package:umy_foods/details/review.dart'; //レビュー
import 'package:umy_foods/footer.dart'; //フッター
import 'package:umy_foods/header.dart'; //ヘッダー
import 'package:umy_foods/main.dart';
import 'package:umy_foods/review_post/review_post.dart'; //レビュー投稿
import 'package:umy_foods/clipButton.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage(this.productID, this.where);
  final String productID;
  final String where;
  @override
  _DetailsPageState createState() => _DetailsPageState(productID, where);
}

class _DetailsPageState extends State<DetailsPage> {
  _DetailsPageState(this.productId, this.where);
  final String productId;
  final String where;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ListView(
              children: [
                BreadCrumb(
                  //パンくずリスト
                  items: <BreadCrumbItem>[
                    BreadCrumbItem(
                        content: GestureDetector(
                      child: Text(where),
                      onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyApp(),
                            ));
                        setState(() {});
                      },
                    )),
                    BreadCrumbItem(
                        content: GestureDetector(
                      child: Text('商品詳細'),
                      onTap: () {
                        setState(() {});
                      },
                    )),
                  ],
                  divider: Icon(Icons.chevron_right),
                ),
                SpaceBox.height(20),
                //商品詳細
                ProductPage(productId),
                //仕切り線
                const Divider(
                  height: 20,
                  thickness: 5,
                  indent: 0,
                  endIndent: 0,
                ),
                //レビュー
                ReviewPage(productId),
                FooterCreate(),
              ],
            ),
          ),

          //フッター固定ボタン
          Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                  data: Theme.of(context)
                      .copyWith(canvasColor: Colors.transparent),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 17),
                    width: 300,
                    decoration: BoxDecoration(
                      color: HexColor('EC9361'),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      child: Row(
                        children: [
                          ElevatedButton(
                            //レビューボタン
                            child: const Text('この商品をレビューする'),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 25),
                              primary: Colors.white,
                              onPrimary: HexColor('EC9361'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ReviewPostPage(productId, '商品詳細'),
                                  ));
                            },
                          ),
                          SpaceBox.width(5),
                          ElevatedButton(
                            //クリップボタン
                            child: Icon(
                              Icons.assignment_turned_in,
                            ),
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
                  ))),
        ],
      ),
      floatingActionButton: clipButton(),
    );
  }
}
