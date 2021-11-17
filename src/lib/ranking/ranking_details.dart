import 'dart:math';

import 'package:flutter/material.dart';
// パッケージ
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart'; //パンくず
// 外部ファイル
import 'package:umy_foods/Filtering.dart'; //フィルタリングポップアップ
import 'package:umy_foods/HexColor.dart'; //16進数カラーコード
import 'package:umy_foods/SpaceBox.dart'; //空間
import 'package:umy_foods/star.dart'; //星評価
import 'package:umy_foods/main.dart';
import 'package:umy_foods/header.dart';
import 'package:umy_foods/footer.dart';
import 'package:umy_foods/ranking/ranking.dart';

class Ranking_detailsPage extends StatefulWidget {
  @override
  _Ranking_detailsPageState createState() => _Ranking_detailsPageState();
}

class _Ranking_detailsPageState extends State<Ranking_detailsPage> {
  List image = ['first', 'second', 'third']; //順位画像

  bool switchBool = false;

  void _onPressedStart() {
    //昇順降順の判定
    setState(() {
      switchBool = !switchBool;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(),
        body: ListView(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 60),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BreadCrumb(
                        //パンくずリスト
                        items: <BreadCrumbItem>[
                          BreadCrumbItem(
                            content: TextButton(
                                child: Text(
                                  'TOP',
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyApp()));
                                }),
                          ),
                          BreadCrumbItem(
                            content: TextButton(
                                child: Text(
                                  'ランキング一覧ページ',
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RankingPage()));
                                }),
                          ),
                          BreadCrumbItem(
                            content: TextButton(
                                child: Text(
                                  'ランキング詳細ページ',
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Ranking_detailsPage()));
                                }),
                          ),
                        ],
                        divider: Icon(Icons.chevron_right),
                      ),
                      SpaceBox.height(20),
                      Row(children: [
                        Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BreadCrumb(
                                      //カテゴリタイトル
                                      items: <BreadCrumbItem>[
                                        BreadCrumbItem(
                                            content: Text('飲料水',
                                                style:
                                                    TextStyle(fontSize: 23))),
                                        BreadCrumbItem(
                                            content: Text('炭酸飲料',
                                                style:
                                                    TextStyle(fontSize: 23))),
                                        BreadCrumbItem(
                                            content: Text('サイダー',
                                                style:
                                                    TextStyle(fontSize: 23))),
                                      ],
                                      divider: Icon(Icons.chevron_right),
                                    ),
                                    Row(children: [
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
                                                builder:
                                                    (BuildContext context) {
                                                  return Details_FilteringDialog();
                                                });
                                          }),
                                      if (switchBool) //昇順降順
                                        Container(
                                          child: Transform.rotate(
                                              child: TextButton(
                                                child: Icon(
                                                  Icons.sort_outlined,
                                                  color: HexColor('FFDFC5'),
                                                  size: 50,
                                                ),
                                                onPressed: _onPressedStart,
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
                                            onPressed: _onPressedStart)
                                    ])
                                  ],
                                ),
                                for (int x = 0; x < 3; x++)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      for (int i = 0 + (x * 3);
                                          i < 3 * (x + 1);
                                          i++)
                                        Container(
                                            child: Row(
                                          children: [
                                            SpaceBox.width(23),
                                            Card(
                                              //商品カード
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {}); //商品詳細ページへ
                                                },
                                                child: Container(
                                                  child: Stack(
                                                    children: [
                                                      if ((i + x) <
                                                          3) //１～３の場合順位の画像、それ以降は数字
                                                        Container(
                                                          height: 40,
                                                          width: 40,
                                                          child: Image.asset(
                                                              'images/icon/' +
                                                                  image[i] +
                                                                  '.png'),
                                                        )
                                                      else
                                                        Text(
                                                          (i + 1).toString(),
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      Padding(
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
                                                                  GestureDetector(
                                                                    child: Text(
                                                                      'グリコ',
                                                                      style: TextStyle(
                                                                          color: HexColor(
                                                                              '616161'),
                                                                          fontSize:
                                                                              10),
                                                                    ), //メーカー
                                                                    onTap: () {
                                                                      setState(
                                                                          () {}); //メーカーページへ
                                                                    },
                                                                  ),
                                                                  Text(
                                                                    'つぶつぶいちごポッキー',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ), //商品名
                                                                  Row(
                                                                    //星評価
                                                                    children: [
                                                                      star(3,
                                                                          25),
                                                                      Text(
                                                                          '500',
                                                                          style: TextStyle(
                                                                              color: HexColor('EC9361'),
                                                                              fontSize: 12))
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
                                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: HexColor('EC9361'))),
                                                                            TextSpan(
                                                                                text: '気になる',
                                                                                style: TextStyle(fontSize: 12))
                                                                          ])),
                                                                          RichText(
                                                                              //リピート数
                                                                              text: TextSpan(style: TextStyle(color: Colors.black), children: [
                                                                            TextSpan(
                                                                                text: '100',
                                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: HexColor('EC9361'))),
                                                                            TextSpan(
                                                                                text: 'リピート',
                                                                                style: TextStyle(fontSize: 12))
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
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))
                                    ],
                                  ),
                                SpaceBox.height(20),
                                Row(
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
                                )
                              ],
                            )),
                        Expanded(flex: 2, child: Text('')),
                      ])
                    ])),
            FooterCreate(),
          ],
        ));
  }
}
