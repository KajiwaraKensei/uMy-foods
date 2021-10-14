import 'package:flutter/material.dart';
import 'dart:math';
// パッケージ
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; //font_awesome
import 'package:percent_indicator/percent_indicator.dart'; //割合棒グラフ
import 'package:multi_charts/multi_charts.dart'; //レーダーチャート
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart'; //年代別レビュー
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; //DB
import "package:intl/intl.dart";
import 'package:intl/date_symbol_data_local.dart'; //日時用

// 外部ファイル
import 'package:umy_foods/HexColor.dart'; //16進数カラーコード
import 'package:umy_foods/SpaceBox.dart'; //空間
import 'package:umy_foods/Filtering.dart'; //フィルタリングポップアップ
import 'package:umy_foods/sort.dart'; //ソートポップアップ
import 'package:umy_foods/star.dart'; //星評価
import 'package:umy_foods/main.dart';

class ReviewPage extends StatefulWidget {
  ReviewPage(this.productID);
  final String productID;
  @override
  _ReviewPageState createState() => _ReviewPageState(productID);
}

final List<Map<String, dynamic>> new_item = [
  {
    'Text': 'Red Bull 250ml',
    'image': 'https://img07.shop-pro.jp/PA01350/082/product/137945030.jpg',
    'date': '2021/09/16',
    'maker': 'レッドブル・ジャパン',
  },
  {
    'Text': 'ガルボチョコパウチ 76g',
    'image': 'https://livedoor.blogimg.jp/plankman/imgs/b/f/bfa6566c.jpg',
    'date': '2021/08/30',
    'maker': '明治'
  },
  {
    'Text': 'ウィルキンソン',
    'image': 'https://m.media-amazon.com/images/I/61KZUmru1sL._AC_SL1500_.jpg',
    'date': '2021/09/16',
    'maker': 'アサヒ飲料'
  },
];

class _ReviewPageState extends State<ReviewPage> {
  _ReviewPageState(this.productId);
  final String productId;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(

        //表示したいFiresotreの保存先を指定
        stream: reviewData(productId),

        //streamが更新されるたびに呼ばれる
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //データが取れていない時の処理
          if (!snapshot.hasData) return const Text('Loading...');

          final result = snapshot.data!.docs;
          List<int> evaList = []; //評価リスト

          if (result.length == 0) {
            return Text('レビューはありません');
          }

          for (int j = 0; j < result.length; j++) {
            //評価
            evaList.add(result[j]['review_evaluation']);
          }

          double ave = evaList.reduce((a, b) => a + b) / evaList.length;
          int average = ave.round();

          num sweet_sum = 0;
          num acidity_sum = 0;
          num salty_sum = 0;
          num bitter_sum = 0;
          num spicy_sum = 0;
          num umami_sum = 0;

          for (int i = 0; i < result.length; i++) {
            sweet_sum = sweet_sum + result[i]['taste'][0];
            acidity_sum = acidity_sum + result[i]['taste'][1];
            salty_sum = salty_sum + result[i]['taste'][2];
            bitter_sum = bitter_sum + result[i]['taste'][3];
            spicy_sum = spicy_sum + result[i]['taste'][4];
            umami_sum = umami_sum + result[i]['taste'][5];
          }

          double sweet = sweet_sum / result.length; //甘味
          double acidity = acidity_sum / result.length; //酸味
          double salty = salty_sum / result.length; //塩味
          double bitter = bitter_sum / result.length; //苦味
          double spicy = spicy_sum / result.length; //辛味
          double umami = umami_sum / result.length; //うまみ

          int S_one = 0;
          int S_two = 0;
          int S_three = 0;
          int S_four = 0;
          int S_five = 0;
          List<double> mikaku = [sweet, acidity, salty, bitter, spicy, umami];

          evaList.forEach((eva) {
            if (eva == 1)
              S_one++;
            else if (eva == 2)
              S_two++;
            else if (eva == 3)
              S_three++;
            else if (eva == 4)
              S_four++;
            else
              S_five++;
          });

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IntrinsicHeight(
                  child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText('レビュー',
                            style: TextStyle(
                                color: HexColor('EC9361'), fontSize: 27.0),
                            scrollPhysics: NeverScrollableScrollPhysics()),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  star(average, 50), //星評価
                                  SelectableText(result.length.toString() + '件',
                                      scrollPhysics:
                                          NeverScrollableScrollPhysics()), //評価件数
                                  Container(
                                    height: 170,
                                    //Radar Chart
                                    child: RadarChart(
                                      values: mikaku,
                                      labels: [
                                        "甘味",
                                        "酸味",
                                        "塩味",
                                        "苦味",
                                        "辛味",
                                        "うま味",
                                      ],
                                      maxValue: 10,
                                      fillColor: Colors.blue,
                                      chartRadiusFactor: 0.7,
                                      animationDuration:
                                          Duration(milliseconds: 500),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  //評価別のパーセント
                                  percent_indicator(
                                      '5', S_five / result.length),
                                  percent_indicator(
                                      '4', S_four / result.length),
                                  percent_indicator(
                                      '3', S_three / result.length),
                                  percent_indicator('2', S_two / result.length),
                                  percent_indicator('1', S_one / result.length),
                                ],
                              ),
                            )
                          ],
                        ),
                        Age_Review(productId, mikaku)
                      ],
                    ),
                  ),
                  SpaceBox.width(30),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 300,
                            // color: Colors.grey,
                            // child: Text('広告'),
                          ),
                          SpaceBox.height(25),
                          Column(
                            children: [
                              GestureDetector(
                                //新商品タイトル
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 35,
                                      child: Image.asset(
                                          'images/icon/newgoods.png'),
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
                                onTap: () {
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
                                    child: Column(
                                      children: [
                                        for (int i = 0; i < 3; i++)
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Card(
                                                child: InkWell(
                                                    onTap: () {
                                                      setState(
                                                          () {}); //商品詳細ページへ
                                                    },
                                                    child: Container(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child:
                                                                GestureDetector(
                                                              child: Container(
                                                                //商品画像
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                height: 90,
                                                                width: 90,
                                                                child: Image
                                                                    .network(
                                                                  new_item[i]
                                                                      ['image'],
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                              onTap: () {
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
                                                                      new_item[
                                                                              i]
                                                                          [
                                                                          'date']), //発売日
                                                                  SpaceBox
                                                                      .height(
                                                                          5),
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                          flex:
                                                                              3,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              GestureDetector(
                                                                                child: Text(
                                                                                  new_item[i]['maker'],
                                                                                  style: TextStyle(color: HexColor('616161'), fontSize: 10),
                                                                                ),
                                                                                onTap: () {
                                                                                  setState(() {}); //メーカーページへ
                                                                                },
                                                                              ),
                                                                              SpaceBox.height(5),
                                                                              GestureDetector(
                                                                                child: Text(new_item[i]['Text']),
                                                                                onTap: () {
                                                                                  setState(() {}); //商品詳細ページへ
                                                                                },
                                                                              ),
                                                                            ],
                                                                          )),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            ElevatedButton(
                                                                          //クリップボタン
                                                                          child:
                                                                              Icon(
                                                                            Icons.assignment_turned_in,
                                                                          ),
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            padding:
                                                                                EdgeInsets.all(11),
                                                                            primary:
                                                                                HexColor('EC9361'),
                                                                            onPrimary:
                                                                                Colors.white,
                                                                            shape:
                                                                                CircleBorder(
                                                                              side: BorderSide(
                                                                                color: Colors.transparent,
                                                                                width: 1,
                                                                                style: BorderStyle.solid,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            clipList.add({
                                                                              'Text': new_item[i]['Text'],
                                                                              'image': new_item[i]['image'],
                                                                              'product_id': new_item[i]['product_id'],
                                                                            });
                                                                          },
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              )),
                                                        ],
                                                      ),
                                                    ))),
                                          )
                                      ],
                                    )),
                              )
                            ],
                          ),
                          SpaceBox.height(25), //隙間
                          Container(
                            width: 100,
                            height: 300,
                            // color: Colors.grey,
                            // child: Text('広告'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ))
            ],
          );
        });
  }

  Widget percent_indicator(String name, double persent) {
    double persentsub = persent * 100; //パーセントを100表示
    String persenttext = persentsub.ceil().toString(); //パーセントを文字化

    return Padding(
      padding: EdgeInsets.all(0),
      child: new LinearPercentIndicator(
        width: 310.0,
        lineHeight: 14.0,
        percent: persent,
        center: Text(
          persenttext + '%',
          style: new TextStyle(fontSize: 12.0),
        ),
        leading: Container(
          width: 60,
          child: Row(
            children: [
              Icon(
                Icons.star_outlined,
                color: HexColor('ffe14c'),
                size: 35,
              ),
              Text(name, style: TextStyle(color: Colors.black))
            ],
          ),
        ),
        linearStrokeCap: LinearStrokeCap.roundAll,
        backgroundColor: HexColor('E0E0E0'),
        progressColor: HexColor('FFDF4C'),
      ),
    );
  }
}

class Age_Review extends StatefulWidget {
  Age_Review(this.productId, this.mikaku);
  final String productId;
  final List<double> mikaku;
  @override
  _Age_Review createState() => _Age_Review(productId, mikaku);
}

//レビュー年代別
class _Age_Review extends State<Age_Review> {
  _Age_Review(this.productId, this.mikaku);
  final String productId;
  List<double> mikaku;
  List<double> allage_list = [1, 2, 4, 7, 9, 6]; //レーダーチャート全体
  List<double> age_list = [5, 3, 2, 4, 5, 6]; //レーダーチャート年代

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 1000,
        child: ContainedTabBarView(
          tabBarProperties: TabBarProperties(
            padding: const EdgeInsets.symmetric(
              vertical: 3.0,
            ),
            indicator: ContainerTabIndicator(
              radius: BorderRadius.circular(16.0),
              color: HexColor('FFDFC5'),
              borderWidth: 2.0,
              borderColor: HexColor('EC9361'),
            ),
            labelColor: HexColor('616161'),
            unselectedLabelColor: HexColor('EC9361'),
          ),
          tabs: [
            Container(child: Text('～10代')),
            Container(child: Text('20代')),
            Container(child: Text('30代')),
            Container(child: Text('40代～')),
          ],
          views: [
            Container(
              //ここで年代別の内容
              child: age_reviewbar('～10代', productId),
            ),
            Container(
              child: age_reviewbar('20代', productId),
            ),
            Container(
              child: age_reviewbar('30代', productId),
            ),
            Container(
              child: age_reviewbar('40代～', productId),
            ),
          ],
          onChange: (index) => print(index),
        ),
      ),
    ]);
  }

  //年代タイトル、絞り込み、表示順
  bool switchBool = false;
  void _onPressedStart() {
    setState(() {
      switchBool = !switchBool;
    });
  }

  String selected_text = "";
  String sort_text = "評価順";

  Widget age_reviewbar(String age, String productId) {
    final now = DateTime.now();
    int max = 0;
    int min = 0;
    if (age == '～10代') {
      min = 0;
      max = 7300;
    } else if (age == '20代') {
      min = 7300;
      max = 10950;
    } else if (age == '30代') {
      min = 10950;
      max = 14600;
    } else {
      min = 14600;
      max = 999999;
    }
    return StreamBuilder<QuerySnapshot>(

        //表示したいFiresotreの保存先を指定
        stream: reviewData(productId),

        //streamが更新されるたびに呼ばれる
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //データが取れていない時の処理
          if (!snapshot.hasData) return const Text('Loading...');

          final result = snapshot.data!.docs;

          List<QueryDocumentSnapshot> reviewResult = result;

          if (result.length >= 1) {
            if (sort_text == '評価順') {
              for (int i = 0; i < result.length; i++) {
                for (int j = 1; j < result.length; j++) {
                  if (result[i]['review_evaluation'] <=
                      result[j]['review_evaluation']) {
                    reviewResult[i] = result[i];
                  }
                }
              }
            } else if (sort_text == '投稿順') {
              for (int i = 0; i < result.length; i++) {
                for (int j = 1; j < result.length; j++) {
                  if (result[i]['review_postdate']
                          .toDate()
                          .isAfter(result[j]['review_postdate'].toDate()) ==
                      false) {
                    reviewResult[i] = result[i];
                  }
                }
              }
            }
          } else {
            reviewResult = result;
          }

          List evaList = [];
          int evaluation = 0;
          List cospaList = [];
          int cospa = 0;
          List<double> ageMikaku = [0, 0, 0, 0, 0, 0];
          num sweet_sum = 0;
          num acidity_sum = 0;
          num salty_sum = 0;
          num bitter_sum = 0;
          num spicy_sum = 0;
          num umami_sum = 0;

          for (int i = 0; i < reviewResult.length; i++)
            if (now
                        .difference(reviewResult[i]['user_birthday'].toDate())
                        .inDays >
                    min &&
                now
                        .difference(reviewResult[i]['user_birthday'].toDate())
                        .inDays <
                    max) {
              evaList.add(reviewResult[i]['review_evaluation']);

              cospaList.add(reviewResult[i]['review_cospa']);

              sweet_sum = sweet_sum + reviewResult[i]['taste'][0];
              acidity_sum = acidity_sum + reviewResult[i]['taste'][1];
              salty_sum = salty_sum + reviewResult[i]['taste'][2];
              bitter_sum = bitter_sum + reviewResult[i]['taste'][3];
              spicy_sum = spicy_sum + reviewResult[i]['taste'][4];
              umami_sum = umami_sum + reviewResult[i]['taste'][5];
            }

          if (evaList.length == 0) {
            return Column(children: [
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 100),
                height: 200,
                child: Text(
                  'この年代のレビューはありません。',
                  style: TextStyle(
                    color: HexColor('ec9361'),
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ]);
          }
          double eva = evaList.reduce((a, b) => a + b) / evaList.length;
          evaluation = eva.round();
          double cos = cospaList.reduce((a, b) => a + b) / cospaList.length;
          cospa = cos.round();
          double sweet = sweet_sum / reviewResult.length; //甘味
          double acidity = acidity_sum / reviewResult.length; //酸味
          double salty = salty_sum / reviewResult.length; //塩味
          double bitter = bitter_sum / reviewResult.length; //苦味
          double spicy = spicy_sum / reviewResult.length; //辛味
          double umami = umami_sum / reviewResult.length; //うまみ
          ageMikaku = [sweet, acidity, salty, bitter, spicy, umami];

          return Column(
            children: [
              Container(
                height: 74,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SelectableText(age + 'の総合評価',
                          style: TextStyle(fontSize: 27.0),
                          scrollPhysics:
                              NeverScrollableScrollPhysics()), //年代タイトル
                      Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 120,
                              height: 40,
                              child: ElevatedButton(
                                  //表示順
                                  child: const Text('表示順'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    onPrimary: HexColor('EC9361'),
                                    side: BorderSide(color: HexColor('EC9361')),
                                  ),
                                  onPressed: () async {
                                    var selected = await showDialog<String>(
                                        context: context,
                                        barrierDismissible:
                                            true, // user must tap button!
                                        builder: (BuildContext context) {
                                          return SortDialog();
                                        });
                                    setState(() {
                                      if (selected != null) {
                                        //何も押さず閉じた場合nullになる
                                        sort_text = selected
                                            .toString(); //同じクラス内にString selected_text='';
                                      }
                                    });
                                  }),
                            ),
                            SpaceBox.width(20),
                            SizedBox(
                              width: 120,
                              height: 40,
                              child: ElevatedButton(
                                  //絞り込みボタン
                                  child: const Text('絞り込み'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    onPrimary: HexColor('EC9361'),
                                    side: BorderSide(color: HexColor('EC9361')),
                                  ),
                                  onPressed: () async {
                                    var selected = await showDialog<String>(
                                        //選択したものを取得、 <String>←取得する型
                                        context: context,
                                        barrierDismissible:
                                            true, // user must tap button!
                                        builder: (BuildContext context) {
                                          return Gender_FilteringDialog();
                                        });
                                    setState(() {
                                      if (selected != null) {
                                        //何も押さず閉じた場合nullになる
                                        selected_text = selected
                                            .toString(); //同じクラス内にString selected_text='';
                                      }
                                    });
                                  }),
                            ),
                            //Text(sort_text.toString()),//動作確認用
                            if (switchBool) //昇順降順ボタン
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
                          ],
                        ),
                      )
                    ]),
              ), //年代別
              Divider(
                //仕切り線
                height: 20,
                thickness: 5,
                color: HexColor('FFDFC5'),
              ),
              Container(
                  child: Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          //総合星評価
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('総合評価', style: TextStyle(fontSize: 15)),
                          ),
                          SpaceBox.width(30),
                          star(evaluation, 50)
                        ],
                      ),
                      Row(
                        children: [
                          //コスパ星評価
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('コスパ', style: TextStyle(fontSize: 15)),
                          ),
                          SpaceBox.width(40),
                          star(cospa, 50)
                        ],
                      )
                    ],
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                          child: Column(
                        children: [
                          Stack(
                            children: [
                              reader(mikaku, '2196F3'), //全年代レーダーチャート
                              reader(ageMikaku, 'EC9361') //選択した年代のレーダーチャート
                            ],
                          ),
                          RichText(
                            //レーダーの色説明
                            text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: '■',
                                      style: TextStyle(
                                          color: HexColor('2196F3'),
                                          fontWeight: FontWeight.w900)),
                                  TextSpan(text: '全年代'),
                                  TextSpan(text: '          '),
                                  TextSpan(
                                      text: '■',
                                      style: TextStyle(
                                          color: HexColor('EC9361'),
                                          fontWeight: FontWeight.w900)),
                                  TextSpan(text: age),
                                ]),
                          )
                        ],
                      ))),
                ],
              )),
              Align(
                alignment: Alignment.centerLeft,
                child: SelectableText(age + 'のコメント',
                    style: TextStyle(fontSize: 27.0),
                    scrollPhysics: NeverScrollableScrollPhysics()),
              ),
              SpaceBox.height(20),
              Container(
                //レビュー内容
                child: Column(
                  children: [
                    for (int i = 0; i < reviewResult.length; i++)
                      if (selected_text != '男性' ||
                          reviewResult[i]['user_gender'] != 'female')
                        if (selected_text != '女性' ||
                            reviewResult[i]['user_gender'] != 'male')
                          if (now
                                      .difference(reviewResult[i]
                                              ['user_birthday']
                                          .toDate())
                                      .inDays >
                                  min &&
                              now
                                      .difference(reviewResult[i]
                                              ['user_birthday']
                                          .toDate())
                                      .inDays <
                                  max)
                            Container(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Row(
                                children: [
                                  reviewUserIcon(reviewResult[i]['user_id']),
                                  reviewUserData(reviewResult[i]['user_id'],
                                      reviewResult[i]['review_evaluation']),
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: RichText(
                                              //レビュー内容
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3, //最大行数
                                              text: TextSpan(
                                                  text: reviewResult[i]
                                                      ['review_comment'],
                                                  style: TextStyle(
                                                      color: Colors.black))),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            //setState(() {});
                                          },
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '続きを読む',
                                              style: TextStyle(
                                                  color: Colors.lightBlue),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.favorite,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                            StreamBuilder<QuerySnapshot>(

                                                //表示したいFiresotreの保存先を指定
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('/review/' +
                                                        reviewResult[i]
                                                            ['review_id'] +
                                                        '/favorite/')
                                                    .snapshots(),

                                                //streamが更新されるたびに呼ばれる
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<QuerySnapshot>
                                                        snapshot) {
                                                  //データが取れていない時の処理
                                                  if (!snapshot.hasData)
                                                    return const Text(
                                                        'Loading...');

                                                  final result =
                                                      snapshot.data!.docs;
                                                  return Text(
                                                      result.length.toString());
                                                }),
                                            SpaceBox.width(20),
                                            Icon(
                                              Icons.chat_bubble_outline,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                            StreamBuilder<QuerySnapshot>(

                                                //表示したいFiresotreの保存先を指定
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('/review/' +
                                                        reviewResult[i]
                                                            ['review_id'] +
                                                        '/comment/')
                                                    .snapshots(),

                                                //streamが更新されるたびに呼ばれる
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<QuerySnapshot>
                                                        snapshot) {
                                                  //データが取れていない時の処理
                                                  if (!snapshot.hasData)
                                                    return const Text(
                                                        'Loading...');

                                                  final result =
                                                      snapshot.data!.docs;
                                                  return Text(
                                                      result.length.toString());
                                                }),
                                            SpaceBox.width(50),
                                            Text(DateFormat("yyyy/MM/dd")
                                                .format(reviewResult[i]
                                                        ['review_postdate']
                                                    .toDate())
                                                .toString()), //投稿日時
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        //ページング
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
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
                                  borderRadius: BorderRadius.circular(10),
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
                      ),
                    ],
                  ))
            ],
          );
        });
  }

  Widget reader(List<double> cnt, String color) {
    return RadarChart(
      values: cnt,
      labels: [
        "甘味",
        "酸味",
        "塩味",
        "苦味",
        "辛味",
        "うま味",
      ],
      maxValue: 10,
      fillColor: HexColor(color),
      chartRadiusFactor: 0.7,
      animationDuration: Duration(milliseconds: 500),
    );
  }
}

Stream<QuerySnapshot> reviewData(String id) {
  return FirebaseFirestore.instance
      .collection('review')
      .where('product_id', isEqualTo: id)
      .snapshots();
}

Widget reviewUserData(userId, evaluation) {
  return StreamBuilder<QuerySnapshot>(

      //表示したいFiresotreの保存先を指定
      stream: reviewUser(userId),

      //streamが更新されるたびに呼ばれる
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //データが取れていない時の処理
        if (!snapshot.hasData) return const Text('Loading...');

        final result = snapshot.data!.docs[0];
        String gender = "";
        if (result['user_gender'] == "male") {
          gender = '男性';
        } else if (result['user_gender'] == "female") {
          gender = '女性';
        }
        return Expanded(
          flex: 2,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: SelectableText(result['user_name'],
                      style: TextStyle(fontSize: 17),
                      scrollPhysics: NeverScrollableScrollPhysics())), //ユーザー名
              Align(
                  alignment: Alignment.centerLeft,
                  child: SelectableText(gender,
                      style: TextStyle(fontSize: 17),
                      scrollPhysics: NeverScrollableScrollPhysics())), //性別
              /*Align(
                  alignment: Alignment.centerLeft,
                  child: Text('ゴールド', style: TextStyle(fontSize: 17))),*/ //ランク
              Align(
                alignment: Alignment.centerLeft,
                child: star(evaluation, 17),
              ), //星評価
            ],
          ),
        );
      });
}

Widget reviewUserIcon(userId) {
  return StreamBuilder<QuerySnapshot>(

      //表示したいFiresotreの保存先を指定
      stream: reviewUser(userId),

      //streamが更新されるたびに呼ばれる
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //データが取れていない時の処理
        if (!snapshot.hasData) return const Text('Loading...');

        final result = snapshot.data!.docs[0];

        return Expanded(
            flex: 2,
            child: Container(
              // margin: EdgeInsets.only(right: 20),
              child: ElevatedButton(
                //ユーザーアイコン
                style: ElevatedButton.styleFrom(shape: CircleBorder()),
                child: ClipOval(
                    child: Image(
                  width: 85,
                  image: NetworkImage((result['user_icon'] == "")
                      ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf'
                      : result['user_icon']),
                  fit: BoxFit.contain,
                )),
                onPressed: () {}, //ユーザーへ
              ),
            ));
      });
}

Stream<QuerySnapshot> reviewUser(String id) {
  return FirebaseFirestore.instance
      .collection('account')
      .where('user_id', isEqualTo: id)
      .snapshots();
}
