import 'package:flutter/material.dart';
import 'dart:math';
// パッケージ
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart'; //パンくず
// 外部ファイル
import 'package:umy_foods/HexColor.dart'; //16進数カラーコード
import 'package:umy_foods/SpaceBox.dart'; //空間
import 'package:umy_foods/Filtering.dart'; //フィルタリングポップアップ
import 'package:umy_foods/footer.dart';
import 'package:umy_foods/header.dart';
import 'package:umy_foods/review_post/review_post.dart';
import 'package:umy_foods/sort.dart'; //ソートポップアップ
import 'package:umy_foods/star.dart'; //星評価

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ProductselectionPage(),
//     );
//   }
// }
class ProductselectionPage extends StatefulWidget {
  @override
  _ProductselectionPageState createState() => _ProductselectionPageState();
}

class _ProductselectionPageState extends State<ProductselectionPage> {
  bool switchBool = false;

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: Header(),
          body: Container(
              padding: EdgeInsets.only(top: 10),
              child: ListView(children: [
                BreadCrumb(
                  //パンくずリスト
                  items: <BreadCrumbItem>[
                    BreadCrumbItem(
                      content: TextButton(
                        onPressed: () {},
                        child: SelectableText(
                          'TOP',
                          style: TextStyle(color: Colors.black),
                          scrollPhysics: NeverScrollableScrollPhysics(),
                        ),
                      ),
                    ),
                    BreadCrumbItem(
                      content: TextButton(
                        onPressed: () {},
                        child: SelectableText(
                          'レビュー商品選択',
                          style: TextStyle(color: Colors.black),
                          scrollPhysics: NeverScrollableScrollPhysics(),
                        ),
                      ),
                    ),
                  ],
                  divider: Icon(Icons.chevron_right),
                ),
                SpaceBox.height(20),
                IntrinsicHeight(
                    child: Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: Padding(
                            padding:
                                EdgeInsets.only(left: 40, right: 5, bottom: 20),
                            child: Column(
                              children: [
                                TextField(
                                  // 検索バー
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'レビューしたい食品を入力してください',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2.0),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2.0),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(color: Colors.black),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                        //表示順ボタン
                                        child: const Text(' 表示順 '),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          onPrimary: HexColor('EC9361'),
                                          side: BorderSide(
                                              color: HexColor('EC9361')),
                                        ),
                                        onPressed: () async {
                                          setState(() {});
                                          return showDialog<void>(
                                              context: context,
                                              barrierDismissible:
                                                  true, // user must tap button!
                                              builder: (BuildContext context) {
                                                return ProductSelectionSortDialog();
                                              });
                                        }),
                                    SpaceBox.width(10),
                                    ElevatedButton(
                                        //絞り込みボタン
                                        child: const Text('絞り込み'),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          onPrimary: HexColor('EC9361'),
                                          side: BorderSide(
                                              color: HexColor('EC9361')),
                                        ),
                                        onPressed: () async {
                                          setState(() {});
                                          return showDialog<void>(
                                              context: context,
                                              barrierDismissible:
                                                  true, // user must tap button!
                                              builder: (BuildContext context) {
                                                return Details_FilteringDialog();
                                              });
                                        }),
                                    SpaceBox.width(10),
                                    if (switchBool) //昇順降順
                                      Container(
                                        child: Transform.rotate(
                                            child: TextButton(
                                              child: Icon(
                                                Icons.sort_outlined,
                                                color: HexColor('FFDFC5'),
                                                size: 50,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  switchBool = !switchBool;
                                                });
                                              },
                                            ),
                                            angle: pi / 1),
                                      )
                                    else
                                      TextButton(
                                        child: Icon(
                                          Icons.sort_outlined,
                                          color: HexColor('FFDFC5'),
                                          size: 50,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            switchBool = !switchBool;
                                          });
                                        },
                                      ),
                                  ],
                                ),
                                Container(
                                    child: Column(
                                  children: [
                                    for (int x = 0; x < 2; x++)
                                      Row(
                                        children: [
                                          for (int i = 0 + (x * 4);
                                              i < 4 * (x + 1);
                                              i++)
                                            Container(
                                                child: Row(
                                              children: [
                                                SpaceBox.width(23),
                                                Card(
                                                  //商品カード
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ReviewPostPage(
                                                                    'productId',
                                                                    'レビュー商品選択'),
                                                          ));
                                                      setState(
                                                          () {}); //商品詳細ページへ
                                                    },
                                                    child: Container(
                                                      child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                //商品画像
                                                                height: 100,
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Image
                                                                      .network(
                                                                          'https://images-na.ssl-images-amazon.com/images/I/71tcgatTdML._AC_SL1500_.jpg'),
                                                                ),
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {},
                                                                      child:
                                                                          SizedBox(
                                                                        height:
                                                                            20,
                                                                        child:
                                                                            SelectableText(
                                                                          'グリコ',
                                                                          scrollPhysics:
                                                                              NeverScrollableScrollPhysics(),
                                                                          style:
                                                                              TextStyle(color: Colors.black),
                                                                        ), //メーカー
                                                                      )),
                                                                  SizedBox(
                                                                    height: 20,
                                                                    child:
                                                                        SelectableText(
                                                                      'つぶつぶいちごポッキー',
                                                                      scrollPhysics:
                                                                          NeverScrollableScrollPhysics(),
                                                                    ), //商品名
                                                                  ),
                                                                  Row(
                                                                    //星評価
                                                                    children: [
                                                                      star(3,
                                                                          25),
                                                                      SelectableText(
                                                                        '500',
                                                                        style: TextStyle(
                                                                            color:
                                                                                HexColor('EC9361'),
                                                                            fontSize: 12),
                                                                        scrollPhysics:
                                                                            NeverScrollableScrollPhysics(),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          RichText(
                                                                              //気になる数
                                                                              text: TextSpan(style: TextStyle(color: Colors.black), children: [
                                                                            TextSpan(
                                                                                text: '1',
                                                                                style: TextStyle(fontWeight: FontWeight.w800, color: HexColor('EC9361'))),
                                                                            TextSpan(text: '気になる')
                                                                          ])),
                                                                          RichText(
                                                                              //リピート数
                                                                              text: TextSpan(style: TextStyle(color: Colors.black), children: [
                                                                            TextSpan(
                                                                                text: '100',
                                                                                style: TextStyle(fontWeight: FontWeight.w800, color: HexColor('EC9361'))),
                                                                            TextSpan(text: 'リピート')
                                                                          ]))
                                                                        ],
                                                                      ),
                                                                      SpaceBox
                                                                          .width(
                                                                              10),
                                                                      ElevatedButton(
                                                                        //クリップボタン
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .assignment_turned_in,
                                                                        ),
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          padding:
                                                                              EdgeInsets.all(15),
                                                                          primary:
                                                                              HexColor('EC9361'),
                                                                          onPrimary:
                                                                              Colors.white,
                                                                          shape:
                                                                              CircleBorder(
                                                                            side:
                                                                                BorderSide(
                                                                              color: Colors.transparent,
                                                                              width: 1,
                                                                              style: BorderStyle.solid,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onPressed:
                                                                            () {},
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ))
                                        ],
                                      ),
                                  ],
                                )),
                                SpaceBox.height(30),
                                Container(
                                    child: Row(
                                  //ページング
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      //数字ボタン
                                      width: 35,
                                      height: 50,
                                      child: ElevatedButton(
                                        child: Text(
                                          '1',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: HexColor('EC9361'),
                                          onPrimary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                    TextButton(
                                      //＞ボタン
                                      child: const Text(
                                        '>',
                                        style: TextStyle(fontSize: 40),
                                      ),
                                      style: TextButton.styleFrom(
                                        primary: Colors.black,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ))
                              ],
                            ))),
                    Expanded(
                        flex: 2,
                        child: Padding(
                            padding:
                                EdgeInsets.only(left: 5, right: 40, bottom: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  height: 300,
                                  color: Colors.grey,
                                  child: Text('広告'),
                                ),
                                SpaceBox.height(40),
                                Column(
                                  children: [
                                    TextButton(
                                      //新商品タイトル
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 35,
                                            child: Image.asset(
                                                'images/icon/newgoods.png'), //アイコン
                                          ),
                                          SpaceBox.width(10),
                                          Text(
                                            '新商品',
                                            style: TextStyle(
                                                color: HexColor('EC9361'),
                                                fontSize: 20.0),
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        setState(() {}); //新商品ページへ
                                      },
                                    ),
                                    SpaceBox.height(10), //隙間
                                    Container(
                                      //新商品
                                      color: HexColor('F5F3EF'),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 15),
                                        child: Card(
                                            child: InkWell(
                                                onTap: () {
                                                  setState(() {}); //商品詳細ページへ
                                                },
                                                child: Container(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: TextButton(
                                                          child: Container(
                                                            //商品画像
                                                            height: 90,
                                                            width: 90,
                                                            child: Image.asset(
                                                                'images/190525pokka.jpg'),
                                                          ),
                                                          onPressed: () {
                                                            setState(
                                                                () {}); //商品詳細ページへ
                                                          },
                                                        ),
                                                      ),
                                                      Expanded(
                                                          flex: 2,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text('発売日' +
                                                                  '2020/10/03'), //発売日
                                                              SpaceBox.height(
                                                                  10),
                                                              TextButton(
                                                                onPressed:
                                                                    () {},
                                                                child:
                                                                    SelectableText(
                                                                  'ポッカサッポロ',
                                                                  style: TextStyle(
                                                                      color: HexColor(
                                                                          '616161'),
                                                                      fontSize:
                                                                          10),
                                                                  scrollPhysics:
                                                                      NeverScrollableScrollPhysics(),
                                                                ), //メーカー名
                                                              ),
                                                              SpaceBox.height(
                                                                  10),
                                                              TextButton(
                                                                onPressed:
                                                                    () {}, //商品詳細へ
                                                                child:
                                                                    SelectableText(
                                                                  'LEMON MADE',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                  scrollPhysics:
                                                                      NeverScrollableScrollPhysics(),
                                                                ), //商品名
                                                              )
                                                            ],
                                                          )),
                                                    ],
                                                  ),
                                                ))),
                                      ),
                                    )
                                  ],
                                ),
                                SpaceBox.height(40), //隙間
                                Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey,
                                  child: Text('広告'),
                                ),
                              ],
                            )))
                  ],
                )),
                FooterCreate(),
              ]))),
    );
  }
}
