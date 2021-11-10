import 'dart:html';

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
import 'package:flutter_screenutil/flutter_screenutil.dart'; //レスポンシブ

// 外部ファイル
import 'package:umy_foods/HexColor.dart'; //16進数カラーコード
import 'package:umy_foods/SpaceBox.dart'; //空間
import 'package:umy_foods/Filtering.dart'; //フィルタリングポップアップ
import 'package:umy_foods/sort.dart'; //ソートポップアップ
import 'package:umy_foods/star.dart'; //星評価
import 'package:umy_foods/main.dart';
import 'package:umy_foods/alert.dart';
import 'package:umy_foods/new_item/newitem.dart';
import 'package:umy_foods/details/details.dart';

class ReviewPage extends StatefulWidget {
  ReviewPage(this.productID);
  final String productID;
  @override
  _ReviewPageState createState() => _ReviewPageState(productID);
}

final List<Map<String, dynamic>> new_item = [
  {
    'Text': 'メルティーキッス くちどけブランデー＆オレンジピール',
    'image':
        'https://m.media-amazon.com/images/I/71nmdI2ZVuL._AC_SX679_PIbundle-10,TopRight,0,0_SH20_.jpg',
    'date': '2021/09/16',
    'maker': '明治',
    'product_id': 'RwBbBy9OWVy99lcWOcz',
  },
  {
    'Text': '明治ストロベリーチョコレートスティックパック',
    'image': 'https://www.meiji.co.jp/products/chocolate/assets/img/04825.jpg',
    'date': '2021/08/30',
    'maker': '明治',
    'product_id': 'YoPNvXANuVslPJRNzcY',
  },
  {
    'Text': 'チョコレート効果 カカオ72％',
    'image':
        'data:image/jpeg;base64,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',
    'date': '2021/09/16',
    'maker': '明治',
    'product_id': 'VYemANsOhBiAs0Mjctk',
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
          if (!snapshot.hasData)
            return Text('Loading...', style: TextStyle(fontSize: 14.sp));

          final result = snapshot.data!.docs;
          List<int> evaList = []; //評価リスト

          if (result.length == 0) {
            return Text('レビューはありません', style: TextStyle(fontSize: 14.sp));
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
          List<double> mikaku = [sweet, acidity, salty, bitter, spicy, umami];

          int S_one = 0;
          int S_two = 0;
          int S_three = 0;
          int S_four = 0;
          int S_five = 0;

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
                                color: HexColor('EC9361'), fontSize: 27.0.sp),
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
                                          NeverScrollableScrollPhysics(),
                                      style: TextStyle(fontSize: 14.sp)), //評価件数
                                  Container(
                                    height: 170.h,
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
                  SpaceBox.width(30.w),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 100.w,
                            height: 300.h,
                            // color: Colors.grey,
                            // child: Text('広告'),
                          ),
                          SpaceBox.height(25.h),
                          Column(
                            children: [
                              GestureDetector(
                                //新商品タイトル
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 35.w,
                                      child:
                                          Image.asset('images/new_goods.png'),
                                    ),
                                    SpaceBox.width(10.w),
                                    Text(
                                      '新商品',
                                      style: TextStyle(
                                          color: HexColor('EC9361'),
                                          fontSize: 20.0.sp),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NewItemPage(),
                                      ));
                                  setState(() {}); //新商品ページへ
                                },
                              ),
                              SpaceBox.height(10.h), //隙間
                              Container(
                                //新商品
                                color: HexColor('F5F3EF'),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20.h, horizontal: 15.w),
                                    child: Column(
                                      children: [
                                        for (int i = 0; i < 3; i++)
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.h),
                                            child: Card(
                                                child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetailsPage(
                                                                    new_item[i][
                                                                        'product_id'],
                                                                    'TOP'),
                                                          ));
                                                      setState(
                                                          () {}); //商品詳細ページへ
                                                    },
                                                    child: Container(
                                                      height: 100.h,
                                                      width: 260.w,
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
                                                                        .all(5
                                                                            .sp),
                                                                height: 90.h,
                                                                width: 90.w,
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
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) => DetailsPage(
                                                                          new_item[i]
                                                                              [
                                                                              'product_id'],
                                                                          '新商品'),
                                                                    ));
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
                                                                  Text(
                                                                      '発売日' +
                                                                          new_item[i]
                                                                              [
                                                                              'date'],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14.sp)), //発売日
                                                                  SpaceBox
                                                                      .height(
                                                                          5.h),
                                                                  GestureDetector(
                                                                    child: Text(
                                                                      new_item[
                                                                              i]
                                                                          [
                                                                          'maker'],
                                                                      style: TextStyle(
                                                                          color: HexColor(
                                                                              '616161'),
                                                                          fontSize:
                                                                              10.sp),
                                                                    ),
                                                                    onTap: () {
                                                                      showDialog<
                                                                          void>(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return BetaAlert();
                                                                        },
                                                                      );
                                                                      setState(
                                                                          () {}); //メーカーページへ
                                                                    },
                                                                  ),
                                                                  SpaceBox
                                                                      .height(
                                                                          5.h),
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
                                                                                child: Text(new_item[i]['Text'], style: TextStyle(fontSize: 14.sp)),
                                                                                onTap: () {
                                                                                  setState(() {}); //商品詳細ページへ
                                                                                  Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(
                                                                                        builder: (context) => DetailsPage(new_item[i]['product_id'], 'TOP'),
                                                                                      ));
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
                                                                            size:
                                                                                14.sp,
                                                                          ),
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            padding:
                                                                                EdgeInsets.all(11.sp),
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
                                                                            FirebaseFirestore.instance.collection("/account/" + Id + "/clip_list").doc(new_item[i]['product_id']).set({
                                                                              'product_name': new_item[i]['Text'],
                                                                              'image_url': new_item[i]['image'],
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
                          SpaceBox.height(25.h), //隙間
                          Container(
                            width: 100.w,
                            height: 300.h,
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
        width: 310.0.w,
        lineHeight: 20.0.h,
        percent: persent,
        center: Text(
          persenttext + '%',
          style: new TextStyle(fontSize: 12.0.sp),
        ),
        leading: Container(
          width: 60.w,
          child: Row(
            children: [
              Icon(
                Icons.star_outlined,
                color: HexColor('ffe14c'),
                size: 35.sp,
              ),
              Text(name, style: TextStyle(color: Colors.black, fontSize: 14.sp))
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
        height: 1000.h,
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
            Container(child: Text('～10代', style: TextStyle(fontSize: 14.sp))),
            Container(child: Text('20代', style: TextStyle(fontSize: 14.sp))),
            Container(child: Text('30代', style: TextStyle(fontSize: 14.sp))),
            Container(child: Text('40代～', style: TextStyle(fontSize: 14.sp))),
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
        stream: sortedReviewData(productId),

        //streamが更新されるたびに呼ばれる
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //データが取れていない時の処理
          if (!snapshot.hasData)
            return Text('Loading...', style: TextStyle(fontSize: 14.sp));

          final result = snapshot.data!.docs;

          List<QueryDocumentSnapshot> reviewResult = result;
          QueryDocumentSnapshot some;

          if (sort_text == '評価順') {
            for (int i = 0; i < result.length; i++) {
              for (int j = i + 1; j < result.length; j++) {
                if (switchBool == false) {
                  if (result[i]['review_evaluation'] <=
                      result[j]['review_evaluation']) {
                    some = reviewResult[i];
                    reviewResult[i] = reviewResult[j];
                    reviewResult[j] = some;
                  }
                } else if (switchBool == true) {
                  if (result[i]['review_evaluation'] >
                      result[j]['review_evaluation']) {
                    some = reviewResult[i];
                    reviewResult[i] = reviewResult[j];
                    reviewResult[j] = some;
                  }
                }
              }
            }
          } else if (sort_text == '投稿順') {
            for (int i = 0; i < result.length; i++) {
              for (int j = i + 1; j < result.length; j++) {
                if (result[i]['review_postdate']
                        .toDate()
                        .isAfter(result[j]['review_postdate'].toDate()) ==
                    switchBool) {
                  some = reviewResult[i];
                  reviewResult[i] = reviewResult[j];
                  reviewResult[j] = some;
                }
              }
            }
          } else if (sort_text == 'いいね順') {
            for (int i = 0; i < result.length; i++) {
              for (int j = i + 1; j < result.length; j++) {
                if (switchBool == false) {
                  if (result[i]['favorite_sum'] <= result[j]['favorite_sum']) {
                    some = reviewResult[i];
                    reviewResult[i] = reviewResult[j];
                    reviewResult[j] = some;
                  }
                } else if (switchBool == true) {
                  if (result[i]['favorite_sum'] > result[j]['favorite_sum']) {
                    some = reviewResult[i];
                    reviewResult[i] = reviewResult[j];
                    reviewResult[j] = some;
                  }
                }
              }
            }
          } else if (sort_text == 'コメント数順') {
            for (int i = 0; i < result.length; i++) {
              for (int j = i + 1; j < result.length; j++) {
                if (switchBool == false) {
                  if (result[i]['comment_sum'] <= result[j]['comment_sum']) {
                    some = reviewResult[i];
                    reviewResult[i] = reviewResult[j];
                    reviewResult[j] = some;
                  }
                } else if (switchBool == true) {
                  if (result[i]['comment_sum'] > result[j]['comment_sum']) {
                    some = reviewResult[i];
                    reviewResult[i] = reviewResult[j];
                    reviewResult[j] = some;
                  }
                }
              }
            }
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
                padding: EdgeInsets.only(top: 100.h),
                height: 200.h,
                child: Text(
                  'この年代のレビューはありません。',
                  style: TextStyle(
                    color: HexColor('ec9361'),
                    fontSize: 25.sp,
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
                height: 74.h,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SelectableText(age + 'の総合評価',
                          style: TextStyle(fontSize: 27.0.sp),
                          scrollPhysics:
                              NeverScrollableScrollPhysics()), //年代タイトル
                      Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 120.w,
                              height: 40.h,
                              child: ElevatedButton(
                                  //表示順
                                  child: Text('表示順',
                                      style: TextStyle(fontSize: 14.sp)),
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
                            SpaceBox.width(20.w),
                            SizedBox(
                              width: 120.w,
                              height: 40.h,
                              child: ElevatedButton(
                                  //絞り込みボタン
                                  child: Text('絞り込み',
                                      style: TextStyle(fontSize: 14.sp)),
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
                                        size: 50.sp,
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
                                    size: 50.sp,
                                  ),
                                  onPressed: _onPressedStart),
                          ],
                        ),
                      )
                    ]),
              ), //年代別
              Divider(
                //仕切り線
                height: 20.h,
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
                            child:
                                Text('総合評価', style: TextStyle(fontSize: 15.sp)),
                          ),
                          SpaceBox.width(30.w),
                          star(evaluation, 50)
                        ],
                      ),
                      Row(
                        children: [
                          //コスパ星評価
                          Align(
                            alignment: Alignment.centerLeft,
                            child:
                                Text('コスパ', style: TextStyle(fontSize: 15.sp)),
                          ),
                          SpaceBox.width(40.w),
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
                    style: TextStyle(fontSize: 27.0.sp),
                    scrollPhysics: NeverScrollableScrollPhysics()),
              ),
              SpaceBox.height(20.h),
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
                              padding: EdgeInsets.only(bottom: 20.h),
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
                                                      color: Colors.black,
                                                      fontSize: 14.sp))),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return BetaAlert();
                                              },
                                            );
                                            //setState(() {});
                                          },
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '続きを読む',
                                              style: TextStyle(
                                                  color: Colors.lightBlue,
                                                  fontSize: 14.sp),
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
                                              size: 20.sp,
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
                                                    return Text('Loading...',
                                                        style: TextStyle(
                                                            fontSize: 14.sp));

                                                  final result =
                                                      snapshot.data!.docs;
                                                  return Text(
                                                      result.length.toString(),
                                                      style: TextStyle(
                                                          fontSize: 14.sp));
                                                }),
                                            SpaceBox.width(20.w),
                                            Icon(
                                              Icons.chat_bubble_outline,
                                              color: Colors.grey,
                                              size: 20.sp,
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
                                                    return Text('Loading...',
                                                        style: TextStyle(
                                                            fontSize: 14.sp));

                                                  final result =
                                                      snapshot.data!.docs;
                                                  return Text(
                                                      result.length.toString(),
                                                      style: TextStyle(
                                                          fontSize: 14.sp));
                                                }),
                                            SpaceBox.width(50.w),
                                            Text(
                                                DateFormat("yyyy/MM/dd")
                                                    .format(reviewResult[i]
                                                            ['review_postdate']
                                                        .toDate())
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 14.sp)), //投稿日時
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
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  child: Column(
                    children: [
                      Row(
                        //ページング
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 35.w,
                            height: 50.h,
                            child: ElevatedButton(
                              child: Text(
                                '1',
                                style: TextStyle(fontSize: 20.sp),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: HexColor('EC9361'),
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                              ),
                              onPressed: () {
                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BetaAlert();
                                  },
                                );
                              },
                            ),
                          ),
                          TextButton(
                            //＞ボタン
                            child: Text(
                              '>',
                              style: TextStyle(fontSize: 40.sp),
                            ),
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                            ),
                            onPressed: () {
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return BetaAlert();
                                },
                              );
                            },
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

Stream<QuerySnapshot> sortedReviewData(String id) {
  return FirebaseFirestore.instance
      .collection('review')
      .where('product_id', isEqualTo: id)
      .orderBy('review_evaluation', descending: false)
      .snapshots();
}

Widget reviewUserData(userId, evaluation) {
  return StreamBuilder<QuerySnapshot>(

      //表示したいFiresotreの保存先を指定
      stream: reviewUser(userId),

      //streamが更新されるたびに呼ばれる
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //データが取れていない時の処理
        if (!snapshot.hasData)
          return Text('Loading...', style: TextStyle(fontSize: 14.sp));

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
                      style: TextStyle(fontSize: 17.sp),
                      scrollPhysics: NeverScrollableScrollPhysics())), //ユーザー名
              Align(
                  alignment: Alignment.centerLeft,
                  child: SelectableText(gender,
                      style: TextStyle(fontSize: 17.sp),
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
        if (!snapshot.hasData)
          return Text('Loading...', style: TextStyle(fontSize: 14.sp));

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
                  width: 85.w,
                  height: 85.h,
                  image: NetworkImage((result['user_icon'] == "")
                      ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf'
                      : result['user_icon']),
                  fit: BoxFit.contain,
                )),
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return BetaAlert();
                    },
                  );
                }, //ユーザーへ
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
