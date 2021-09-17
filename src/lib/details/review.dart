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

class ReviewPage extends StatefulWidget {
  ReviewPage(this.productID);
  final String productID;
  @override
  _ReviewPageState createState() => _ReviewPageState(productID);
}

class _ReviewPageState extends State<ReviewPage> {
  _ReviewPageState(this.productId);
  final String productId;
  @override
  Widget build(BuildContext context) {
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
                  Text(
                    'レビュー',
                    style: TextStyle(color: HexColor('EC9361'), fontSize: 27.0),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            star(4, 50), //星評価
                            Text('5000件'), //評価件数
                            Container(
                              height: 170,
                              //Radar Chart
                              child: RadarChart(
                                values: [1, 2, 4, 7, 9, 0, 6],
                                labels: [
                                  "甘味",
                                  "酸味",
                                  "塩味",
                                  "苦味",
                                  "辛味",
                                  "刺激",
                                  "うま味",
                                ],
                                maxValue: 10,
                                fillColor: Colors.blue,
                                chartRadiusFactor: 0.7,
                                animationDuration: Duration(milliseconds: 500),
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
                            percent_indicator('5', 0.9),
                            percent_indicator('4', 0.4),
                            percent_indicator('3', 0.2),
                            percent_indicator('2', 0.6),
                            percent_indicator('1', 0.1),
                          ],
                        ),
                      )
                    ],
                  ),
                  Age_Review(productId)
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
                      color: Colors.grey,
                      child: Text('広告'),
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
                                child: Image.asset('images/icon/newgoods.png'),
                              ),
                              SpaceBox.width(10),
                              Text(
                                '新商品',
                                style: TextStyle(
                                    color: HexColor('EC9361'), fontSize: 20.0),
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
                                            child: GestureDetector(
                                              child: Container(
                                                //商品画像
                                                height: 90,
                                                width: 90,
                                                child: Image.asset(
                                                    'images/190525pokka.jpg'),
                                              ),
                                              onTap: () {
                                                setState(() {}); //商品詳細ページへ
                                              },
                                            ),
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text('発売日' +
                                                      '2020/10/03'), //発売日
                                                  SpaceBox.height(10),
                                                  GestureDetector(
                                                    child: Text(
                                                      'ポッカサッポロ',
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              '616161'),
                                                          fontSize: 10),
                                                    ),
                                                    onTap: () {
                                                      setState(
                                                          () {}); //メーカーページへ
                                                    },
                                                  ),
                                                  SpaceBox.height(10),
                                                  GestureDetector(
                                                    child: Text('LEMON MADE'),
                                                    onTap: () {
                                                      setState(
                                                          () {}); //商品詳細ページへ
                                                    },
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ))),
                          ),
                        )
                      ],
                    ),
                    SpaceBox.height(25), //隙間
                    Container(
                      width: 100,
                      height: 300,
                      color: Colors.grey,
                      child: Text('広告'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ))
      ],
    );
  }

  Widget percent_indicator(String name, double persent) {
    double persentsub = persent * 100; //パーセントを100表示
    String persenttext = persentsub.toString(); //パーセントを文字化

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
  Age_Review(this.productId);
  final String productId;
  @override
  _Age_Review createState() => _Age_Review(productId);
}

//レビュー年代別
class _Age_Review extends State<Age_Review> {
  _Age_Review(this.productId);
  final String productId;
  List<double> allage_list = [1, 2, 4, 7, 9, 0, 6]; //レーダーチャート全体
  List<double> age_list = [5, 3, 2, 4, 5, 0, 6]; //レーダーチャート年代

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

  Widget age_reviewbar(String age, String productId) {
    return Column(
      children: [
        Container(
          height: 74,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(age + 'の総合評価', style: TextStyle(fontSize: 27.0)), //年代タイトル
            Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 80,
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
                          setState(() {});
                          return showDialog<void>(
                              context: context,
                              barrierDismissible: true, // user must tap button!
                              builder: (BuildContext context) {
                                return SortDialog();
                              });
                        }),
                  ),
                  SpaceBox.width(20),
                  SizedBox(
                    width: 80,
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
                          setState(() {});
                          return showDialog<void>(
                              context: context,
                              barrierDismissible: true, // user must tap button!
                              builder: (BuildContext context) {
                                return Gender_FilteringDialog();
                              });
                        }),
                  ),
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
        ),
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
                    star(4, 50)
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
                    star(4, 50)
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
                        reader(allage_list, '2196F3'), //全年代レーダーチャート
                        reader(age_list, 'EC9361') //選択した年代のレーダーチャート
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
                            TextSpan(text: age + '代'),
                          ]),
                    )
                  ],
                ))),
          ],
        )),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(age + '代のコメント', style: TextStyle(fontSize: 27.0)),
        ),
        SpaceBox.height(20),
        Container(
          child: review(productId),
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
        "刺激",
        "うま味",
      ],
      maxValue: 10,
      fillColor: HexColor(color),
      chartRadiusFactor: 0.7,
      animationDuration: Duration(milliseconds: 500),
    );
  }
}

Widget review(productId) {
  return StreamBuilder<QuerySnapshot>(

      //表示したいFiresotreの保存先を指定
      stream: reviewData(productId),

      //streamが更新されるたびに呼ばれる
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //データが取れていない時の処理
        if (!snapshot.hasData) return const Text('Loading...');

        final result = snapshot.data!.docs;

        return Column(
          children: [
            for (int i = 0; i < result.length; i++)
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    reviewUserIcon(result[i]['user_id']),
                    reviewUserData(
                        result[i]['user_id'], result[i]['review_evaluation']),
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          RichText(
                              //レビュー内容
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3, //最大行数
                              text: TextSpan(
                                  text: result[i]['review_comment'],
                                  style: TextStyle(color: Colors.black))),
                          GestureDetector(
                            onTap: () {
                              //setState(() {});
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '続きを読む',
                                style: TextStyle(color: Colors.lightBlue),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Colors.grey,
                                size: 20,
                              ),
                              Text('100'),
                              SpaceBox.width(20),
                              Icon(
                                Icons.chat_bubble_outline,
                                color: Colors.grey,
                                size: 20,
                              ),
                              Text('100'),
                              SpaceBox.width(50),
                              Text(DateFormat("yyyy/MM/dd")
                                  .format(result[i]['review_postdate'].toDate())
                                  .toString()) //投稿日時
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
          ],
        );
      });
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
                  child: Text(result['user_name'],
                      style: TextStyle(fontSize: 17))), //ユーザー名
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(gender, style: TextStyle(fontSize: 17))), //性別
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
