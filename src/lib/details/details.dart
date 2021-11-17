import 'dart:html';
import "package:intl/intl.dart";
import 'package:intl/date_symbol_data_local.dart';
import 'dart:math';
import 'package:flutter/material.dart';

// パッケージ
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart'; //パンくず
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; //font_awesome
import 'package:percent_indicator/percent_indicator.dart'; //割合棒グラフ
// import 'package:multi_charts/multi_charts.dart'; //レーダーチャート
// import 'package:contained_tab_bar_view/contained_tab_bar_view.dart'; //年代別レビュー
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; //DB
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/date_symbol_data_local.dart'; //日時用
import 'package:flutter_screenutil/flutter_screenutil.dart'; //レスポンシブ

// 外部ファイル
import 'package:umy_foods/HexColor.dart'; //16進数カラーコード
import 'package:umy_foods/SpaceBox.dart'; //空間
import 'package:umy_foods/details/review.dart'; //レビュー
import 'package:umy_foods/star.dart'; //星評価
import 'package:umy_foods/footer.dart'; //フッター
import 'package:umy_foods/header.dart'; //ヘッダー
import 'package:umy_foods/main.dart';
import 'package:umy_foods/review_post/review_post.dart'; //レビュー投稿
import 'package:umy_foods/clipButton.dart';
import 'package:umy_foods/comparison.dart';
import 'package:umy_foods/alert.dart';

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

  //気になる、リピートボタン
  bool concern = false;
  bool repeat = false;

  //栄養など詳細情報ボタン
  bool _materials = false;
  bool _allergy = false;
  bool _nutrition = false;
  String image = "";
  String product_name = "";
  String maker = "";
  String product_id = "";
  int numberOfReview = 0;
  int repeatnum = 0;

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> product(String id) {
      return FirebaseFirestore.instance
          .collection('product')
          .where('product_id', isEqualTo: id)
          .snapshots();
    }

//メーカー

    Widget makerName(String id) {
      return StreamBuilder<QuerySnapshot>(

          //表示したいFiresotreの保存先を指定
          stream: FirebaseFirestore.instance
              .collection('maker')
              .where('maker_id', isEqualTo: id)
              .snapshots(),

          //streamが更新されるたびに呼ばれる
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //データが取れていない時の処理
            if (!snapshot.hasData)
              return Text('Loading...', style: TextStyle(fontSize: 14.sp));

            String result = snapshot.data!.docs[0]['maker_name'];
            maker = result;

            return Text(
              result,
              style: TextStyle(fontSize: 14.sp),
            );
          });
    }

//ブランド

    Widget brandName(String maker_id, String brand_id) {
      return StreamBuilder<QuerySnapshot>(

          //表示したいFiresotreの保存先を指定
          stream: FirebaseFirestore.instance
              .collection('/maker/' + maker_id + '/brand/')
              .where('brand_id', isEqualTo: brand_id)
              .snapshots(),

          //streamが更新されるたびに呼ばれる
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //データが取れていない時の処理
            if (!snapshot.hasData)
              return Text('Loading...', style: TextStyle(fontSize: 14.sp));

            String result = snapshot.data!.docs[0]['brand_name'];

            return Text(result, style: TextStyle(fontSize: 14.sp));
          });
    }

//アレルギー

    Widget allergyName(id) {
      return StreamBuilder<QuerySnapshot>(

          //表示したいFiresotreの保存先を指定
          stream: FirebaseFirestore.instance
              .collection('allergy')
              .where('allergy_id', isEqualTo: id)
              .snapshots(),

          //streamが更新されるたびに呼ばれる
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //データが取れていない時の処理
            if (!snapshot.hasData)
              return Text('Loading...', style: TextStyle(fontSize: 14.sp));

            String result = snapshot.data!.docs[0]['allergy_name'];

            if (result.length == 0) {
              return Text('');
            }

            return Text('${result}　', style: TextStyle(fontSize: 14.sp));
          });
    }

    //評価

    Widget evaluation(String id) {
      return StreamBuilder<QuerySnapshot>(

          //表示したいFiresotreの保存先を指定
          stream: FirebaseFirestore.instance
              .collection('review')
              .where('product_id', isEqualTo: id)
              .snapshots(),

          //streamが更新されるたびに呼ばれる
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //データが取れていない時の処理
            if (!snapshot.hasData)
              return Text('Loading...', style: TextStyle(fontSize: 14.sp));

            final result = snapshot.data!.docs;

            if (result.length == 0) {
              //レビューがない場合は強制的に評価、コスパが0
              return Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        //総合星評価
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText('総合評価',
                              scrollPhysics: NeverScrollableScrollPhysics(),
                              style: TextStyle(fontSize: 14.sp)),
                          star(0, 30)
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Column(
                        //コスパ星評価
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText('コスパ',
                              scrollPhysics: NeverScrollableScrollPhysics(),
                              style: TextStyle(fontSize: 14.sp)),
                          star(0, 30)
                        ],
                      )),
                ],
              );
            }

            List<int> evaList = [];
            List<int> cospaList = [];

            for (int j = 0; j < result.length; j++) {
              evaList.add(result[j]['review_evaluation']);
            }
            double eva = evaList.reduce((a, b) => a + b) / evaList.length;
            int evaluation = eva.round();

            for (int i = 0; i < result.length; i++) {
              cospaList.add(result[i]['review_cospa']);
            }
            double cos = cospaList.reduce((a, b) => a + b) / cospaList.length;
            int cospa = cos.round();

            return Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      //総合星評価
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText('総合評価',
                            scrollPhysics: NeverScrollableScrollPhysics(),
                            style: TextStyle(fontSize: 14.sp)),
                        star(evaluation, 30)
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      //コスパ星評価
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText('コスパ',
                            scrollPhysics: NeverScrollableScrollPhysics(),
                            style: TextStyle(fontSize: 14.sp)),
                        star(cospa, 30)
                      ],
                    )),
              ],
            );
          });
    }

    //リピート
    Widget numberOfReview(id) {
      return StreamBuilder<QuerySnapshot>(

          //表示したいFiresotreの保存先を指定
          stream: FirebaseFirestore.instance
              .collection('review')
              .where('product_id', isEqualTo: id)
              .snapshots(),

          //streamが更新されるたびに呼ばれる
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //データが取れていない時の処理
            if (!snapshot.hasData)
              return Text('Loading...', style: TextStyle(fontSize: 14.sp));

            final result = snapshot.data!.docs;

            return Text(result.length.toString(),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: HexColor('#EC9361'),
                  fontWeight: FontWeight.w900,
                ));
          });
    }

    //リピート
    Widget numberOfRepeat(id) {
      return StreamBuilder<QuerySnapshot>(

          //表示したいFiresotreの保存先を指定
          stream: FirebaseFirestore.instance
              .collection('repeat')
              .where('product_id', isEqualTo: id)
              .snapshots(),

          //streamが更新されるたびに呼ばれる
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //データが取れていない時の処理
            if (!snapshot.hasData)
              return Text('Loading...', style: TextStyle(fontSize: 14.sp));

            final result = snapshot.data!.docs;
            repeatnum = result.length;

            return Text(result.length.toString(),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: HexColor('#EC9361'),
                  fontWeight: FontWeight.w900,
                ));
          });
    }

    //気になる
    Widget numberOfConcern(id) {
      return StreamBuilder<QuerySnapshot>(

          //表示したいFiresotreの保存先を指定
          stream: FirebaseFirestore.instance
              .collection('concern')
              .where('product_id', isEqualTo: id)
              .snapshots(),

          //streamが更新されるたびに呼ばれる
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //データが取れていない時の処理
            if (!snapshot.hasData)
              return Text('Loading...', style: TextStyle(fontSize: 14.sp));

            final result = snapshot.data!.docs;

            return Text('気になる (${result.length})',
                style: TextStyle(
                    color: concern == true ? Colors.white : HexColor('616161'),
                    fontSize: 17.sp));
          });
    }

    Widget parcentAge(List<String> userId) {
      return StreamBuilder<QuerySnapshot>(

          //表示したいFiresotreの保存先を指定
          stream: FirebaseFirestore.instance
              .collection('account')
              .where('user_id', whereIn: userId)
              .snapshots(),

          //streamが更新されるたびに呼ばれる
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //データが取れていない時の処理
            if (!snapshot.hasData)
              return Text('Loading...', style: TextStyle(fontSize: 14.sp));

            final result = snapshot.data!.docs;
            final now = DateTime.now();
            int teen = 0;
            int twenties = 0;
            int thirties = 0;
            int forties = 0;
            List<int> year = [];

            for (int i = 0; i < result.length; i++) {
              year.add(
                  now.difference(result[i]['user_birthday'].toDate()).inDays);
            }

            year.forEach((y) {
              if (y > 0 && y < 7300) {
                teen++;
              } else if (y >= 7300 && y < 10950) {
                twenties++;
              } else if (y >= 10950 && y < 14600) {
                thirties++;
              } else {
                forties++;
              }
            });
            return Table(
              children: [
                TableRow(children: [
                  percent_indicator('~10代', teen / result.length),
                  percent_indicator('20代', twenties / result.length),
                ]),
                TableRow(children: [
                  percent_indicator('30代', thirties / result.length),
                  percent_indicator('40代~', forties / result.length),
                ])
              ],
            );
          });
    }

    //リピート年代
    Widget repeatAge(id) {
      return StreamBuilder<QuerySnapshot>(

          //表示したいFiresotreの保存先を指定
          stream: FirebaseFirestore.instance
              .collection('repeat')
              .where('product_id', isEqualTo: id)
              .snapshots(),

          //streamが更新されるたびに呼ばれる
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //データが取れていない時の処理
            if (!snapshot.hasData)
              return Text('Loading...', style: TextStyle(fontSize: 14.sp));

            final result = snapshot.data!.docs;

            if (result.length == 0) {
              return Container(
                child: Column(children: [
                  Text('この商品を「リピート」しているユーザーの年代',
                      style: TextStyle(fontSize: 14.sp)),
                  Table(
                    children: [
                      TableRow(children: [
                        percent_indicator('~10代', 0.0),
                        percent_indicator('20代', 0.0),
                      ]),
                      TableRow(children: [
                        percent_indicator('30代', 0.0),
                        percent_indicator('40代~', 0.0),
                      ])
                    ],
                  ),
                ]),
              );
            }

            List<String> userId = []; //id一覧
            for (int i = 0; i < result.length; i++) {
              userId.add(result[i]['user_id']);
            }
            return Container(
              child: Column(children: [
                Text('この商品を「リピート」しているユーザーの年代',
                    style: TextStyle(fontSize: 14.sp)),
                parcentAge(userId),
              ]),
            );
          });
    }

    //レビュー年代
    Widget reviewAge(id) {
      return StreamBuilder<QuerySnapshot>(

          //表示したいFiresotreの保存先を指定
          stream: FirebaseFirestore.instance
              .collection('review')
              .where('product_id', isEqualTo: id)
              .snapshots(),

          //streamが更新されるたびに呼ばれる
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //データが取れていない時の処理
            if (!snapshot.hasData)
              return Text('Loading...', style: TextStyle(fontSize: 14.sp));

            final result = snapshot.data!.docs;

            if (result.length == 0) {
              return Container(
                child: Column(children: [
                  Text('この商品を「レビュー」しているユーザーの年代',
                      style: TextStyle(fontSize: 14.sp)),
                  Table(
                    children: [
                      TableRow(children: [
                        percent_indicator('~10代', 0.0),
                        percent_indicator('20代', 0.0),
                      ]),
                      TableRow(children: [
                        percent_indicator('30代', 0.0),
                        percent_indicator('40代~', 0.0),
                      ])
                    ],
                  ),
                ]),
              );
            }

            List<String> userId = []; //id一覧
            for (int i = 0; i < result.length; i++) {
              userId.add(result[i]['user_id']);
            }
            return Container(
              child: Column(children: [
                Text('この商品を「レビュー」しているユーザーの年代',
                    style: TextStyle(fontSize: 14.sp)),
                parcentAge(userId),
              ]),
            );
          });
    }

    //成分

    Widget nutritionalIngredients(String id) {
      return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(

          //表示したいFiresotreの保存先を指定
          stream: FirebaseFirestore.instance
              .collection('product')
              .doc(id)
              .collection('nutritional_ingredients')
              .doc(id)
              .snapshots(),

          //streamが更新されるたびに呼ばれる
          builder: (context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            //データが取れていない時の処理
            if (!snapshot.hasData)
              return Text('Loading...', style: TextStyle(fontSize: 14.sp));

            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText('${snapshot.data!['subject']}',
                      style: TextStyle(fontSize: 14.sp),
                      scrollPhysics: NeverScrollableScrollPhysics()),
                  SelectableText(
                      'たんぱく質　${snapshot.data!['たんぱく質']}　/　エネルギー　${snapshot.data!['エネルギー']}　/　炭水化物　${snapshot.data!['炭水化物']}　/　脂質　${snapshot.data!['脂質']}　/　食塩相当量　${snapshot.data!['食塩相当量']}',
                      style: TextStyle(fontSize: 14.sp),
                      scrollPhysics: NeverScrollableScrollPhysics()),
                ]);
          });
    }

    return Scaffold(
      appBar: Header(),
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BreadCrumb(
                          //パンくずリスト
                          items: <BreadCrumbItem>[
                            BreadCrumbItem(
                              content: TextButton(
                                  child: Text(
                                    where,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14.sp),
                                  ),
                                  onPressed: () {
                                    if (where != 'レビュー投稿')
                                    Navigator.pop(context);
                                  }),
                            ),
                            BreadCrumbItem(
                              content: TextButton(
                                  child: Text(
                                    '商品詳細',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14.sp),
                                  ),
                                  onPressed: () {}),
                            ),
                          ],
                          divider: Icon(Icons.chevron_right),
                        ),
                        SpaceBox.height(20.h),
                        //商品詳細
                        StreamBuilder<QuerySnapshot>(

                            //表示したいFiresotreの保存先を指定
                            stream: product(productId),

                            //streamが更新されるたびに呼ばれる
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              //データが取れていない時の処理
                              if (!snapshot.hasData)
                                return Text('Loading...',
                                    style: TextStyle(fontSize: 14.sp));

                              final result = snapshot.data!.docs[0];
                              String imgmain = (result['images'][0] == "")
                                  ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf'
                                  : result['images'][0];
                              image = imgmain;
                              product_name = result['product_name'];

                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SelectableText(
                                                result['product_name'],
                                                style: TextStyle(
                                                  fontSize: 27.0.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                scrollPhysics:
                                                    NeverScrollableScrollPhysics()), //商品名
                                            // Container(
                                            //   child: Row(
                                            //     children: [
                                            //       SpaceBox.width(5),
                                            //       Icon(
                                            //         //リピート
                                            //         FontAwesomeIcons.sync,
                                            //         color: Colors.grey,
                                            //         size: 20,
                                            //       ),
                                            //       numberOfRepeat(productId),
                                            //       SpaceBox.width(20),
                                            //       Icon(Icons.rate_review, //レビュー
                                            //           color: Colors.grey,
                                            //           size: 30),
                                            //       numberOfReview(productId),
                                            //     ],
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              //スパナ
                                              icon: Icon(
                                                FontAwesomeIcons.wrench,
                                                color: Colors.grey,
                                                size: 20.sp,
                                              ),
                                              onPressed: () {
                                                showDialog<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return BetaAlert();
                                                  },
                                                );
                                              },
                                            ),
                                            SpaceBox.width(10.w),
                                            Ink(
                                              //Twitterボタン
                                              decoration: ShapeDecoration(
                                                color: HexColor('1DA1F2'),
                                                shape: CircleBorder(),
                                              ),
                                              child: IconButton(
                                                icon: Icon(
                                                  FontAwesomeIcons.twitter,
                                                  color: Colors.white,
                                                  size: 20.sp,
                                                ),
                                                color: Colors.white,
                                                onPressed: () async {
                                                  if (await canLaunch(
                                                      "https://twitter.com/intent/tweet?text=" +
                                                          result[
                                                              'product_name'] +
                                                          "がいい！&url=https://umyfoods-rac.web.app/#/")) {
                                                    await launch(
                                                        "https://twitter.com/intent/tweet?text=" +
                                                            result[
                                                                'product_name'] +
                                                            "がいい！&url=https://umyfoods-rac.web.app/#/");
                                                  }
                                                },
                                              ),
                                            ),
                                            // SpaceBox.width(10.w),
                                            // Ink(
                                            //   //Instagramボタン
                                            //   decoration: ShapeDecoration(
                                            //     gradient: LinearGradient(
                                            //       colors: [
                                            //         HexColor('4C64D3'),
                                            //         HexColor('CF2E92'),
                                            //         HexColor('F26939'),
                                            //         HexColor('FFDD83'),
                                            //       ],
                                            //     ),
                                            //     shape: CircleBorder(),
                                            //   ),
                                            //   child: IconButton(
                                            //     icon: Icon(
                                            //       FontAwesomeIcons.instagram,
                                            //       color: Colors.white,
                                            //       size: 20.sp,
                                            //     ),
                                            //     color: Colors.white,
                                            //     onPressed: () {},
                                            //   ),
                                            // ),
                                            SpaceBox.width(10.w),
                                            Ink(
                                              //Facebookボタン
                                              decoration: ShapeDecoration(
                                                color: HexColor('3b5998'),
                                                shape: CircleBorder(),
                                              ),
                                              child: IconButton(
                                                icon: Icon(
                                                  FontAwesomeIcons.facebook,
                                                  color: Colors.white,
                                                  size: 20.sp,
                                                ),
                                                color: Colors.white,
                                                onPressed: () async {
                                                  if (await canLaunch(
                                                      "https://www.facebook.com/sharer.php?u=https://umyfoods-rac.web.app/#/")) {
                                                    await launch(
                                                        "https://www.facebook.com/sharer.php?u=https://umyfoods-rac.web.app/#/");
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          // height: 454,
                                          padding: EdgeInsets.all(10.sp),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 330.h,
                                                width: 330.w,
                                                child: Image.network(
                                                    imgmain), //メイン商品画像
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 20.w),
                                              child: Column(
                                                children: [
                                                  evaluation(productId),
                                                  SpaceBox.height(20.h),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: SelectableText(
                                                        '商品情報',
                                                        scrollPhysics:
                                                            NeverScrollableScrollPhysics(),
                                                        style: TextStyle(
                                                            fontSize: 20.sp)),
                                                  ),
                                                  SpaceBox.height(20.h),
                                                  Table(
                                                    //商品情報テーブル
                                                    columnWidths: const <int,
                                                        TableColumnWidth>{
                                                      0: FlexColumnWidth(
                                                          0.4), //１列目の幅の割合
                                                      1: FlexColumnWidth(
                                                          1.0), //２列目の幅の割合
                                                    },
                                                    children: [
                                                      TableRow(children: [
                                                        SelectableText('商品名',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    14.sp),
                                                            scrollPhysics:
                                                                NeverScrollableScrollPhysics()),
                                                        SelectableText(result['product_name'],
                                                            style: TextStyle(
                                                                fontSize:
                                                                    14.sp),
                                                            scrollPhysics:
                                                                NeverScrollableScrollPhysics()),
                                                        SpaceBox.height(30.h),
                                                      ]),
                                                      TableRow(children: [
                                                        SelectableText('メーカー名',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    14.sp),
                                                            scrollPhysics:
                                                                NeverScrollableScrollPhysics()),
                                                        makerName(
                                                            result['maker_id']),
                                                        SpaceBox.height(30.h),
                                                      ]),
                                                      TableRow(children: [
                                                        SelectableText('ブランド名',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    14.sp),
                                                            scrollPhysics:
                                                                NeverScrollableScrollPhysics()),
                                                        brandName(
                                                            result['maker_id'],
                                                            result['brand_id']),
                                                        SpaceBox.height(30.h),
                                                      ]),
                                                      TableRow(children: [
                                                        SelectableText('内容量',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    14.sp),
                                                            scrollPhysics:
                                                                NeverScrollableScrollPhysics()),
                                                        SelectableText(result['Internal_capacity'],
                                                            style: TextStyle(
                                                                fontSize:
                                                                    14.sp),
                                                            scrollPhysics:
                                                                NeverScrollableScrollPhysics()),
                                                        SpaceBox.height(30.h),
                                                      ]),
                                                      TableRow(children: [
                                                        SelectableText('発売日',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    14.sp),
                                                            scrollPhysics:
                                                                NeverScrollableScrollPhysics()),
                                                        (DateFormat("yyyy/MM/dd")
                                                                    .format(result[
                                                                            'release_date']
                                                                        .toDate())
                                                                    .toString() ==
                                                                '0001/01/01')
                                                            ? SelectableText(
                                                                'データなし',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp),
                                                                scrollPhysics:
                                                                    NeverScrollableScrollPhysics())
                                                            : SelectableText(
                                                                DateFormat("yyyy/MM/dd")
                                                                    .format(result[
                                                                            'release_date']
                                                                        .toDate())
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp),
                                                                scrollPhysics:
                                                                    NeverScrollableScrollPhysics()),
                                                        SpaceBox.height(30.h),
                                                      ]),
                                                    ],
                                                  )
                                                ],
                                              ))),
                                    ],
                                  ),
                                  SpaceBox.height(20.h),
                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              //商品画像切り替え
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              for (int i = 0;
                                                  i < result['images'].length;
                                                  i++)
                                                GestureDetector(
                                                    //商品画像
                                                    onTap: () {
                                                      setState(() {
                                                        imgmain = (result[
                                                                        'images']
                                                                    [i] ==
                                                                "")
                                                            ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf'
                                                            : result['images']
                                                                [i];
                                                      });
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5.h,
                                                              horizontal: 5.w),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                      ),
                                                      child: Container(
                                                        height: 100.h, //画像サイズ
                                                        width: 100.w,
                                                        child: (result['images']
                                                                    [i] ==
                                                                "")
                                                            ? Image.network(
                                                                'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf')
                                                            : Image.network(
                                                                result['images']
                                                                    [i]),
                                                      ),
                                                    )),
                                            ],
                                          ))),
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              // color: Colors.red,
                                              padding:
                                                  EdgeInsets.only(left: 20.w),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    SizedBox(
                                                        width: 170.w,
                                                        height: 35.h,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: HexColor(
                                                                'FF9900'),
                                                            onPrimary:
                                                                Colors.white,
                                                          ),
                                                          child: Text(
                                                              'Amazonで購入',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      12.sp)),
                                                          onPressed: () async {
                                                            if (await canLaunch(
                                                                "https://www.amazon.co.jp/s?k=" +
                                                                    result[
                                                                        'product_name'])) {
                                                              await launch(
                                                                  "https://www.amazon.co.jp/s?k=" +
                                                                      result[
                                                                          'product_name']);
                                                            }
                                                          },
                                                        )),
                                                    SizedBox(
                                                        width: 170.w,
                                                        height: 35.h,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: HexColor(
                                                                'bf0000'),
                                                            onPrimary:
                                                                Colors.white,
                                                          ),
                                                          child: Text('楽天市場で購入',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      12.sp)),
                                                          onPressed: () async {
                                                            if (await canLaunch(
                                                                "https://search.rakuten.co.jp/search/mall/" +
                                                                    result[
                                                                        'product_name'])) {
                                                              await launch(
                                                                  "https://search.rakuten.co.jp/search/mall/" +
                                                                      result[
                                                                          'product_name']);
                                                            }
                                                          },
                                                        )),
                                                    SizedBox(
                                                        width: 170.w,
                                                        height: 35.h,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: HexColor(
                                                                'FF0027'),
                                                            onPrimary:
                                                                Colors.white,
                                                          ),
                                                          child: Text(
                                                              'Y！ショッピングで購入',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      12.sp)),
                                                          onPressed: () async {
                                                            if (await canLaunch(
                                                                "https://shopping.yahoo.co.jp/search?first=&p=" +
                                                                    result[
                                                                        'product_name'])) {
                                                              await launch(
                                                                  "https://shopping.yahoo.co.jp/search?first=&p=" +
                                                                      result[
                                                                          'product_name']);
                                                            }
                                                          },
                                                        )),
                                                  ]))),
                                    ],
                                  ),
                                  SpaceBox.height(20.h),
                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              child: Center(
                                            child: SizedBox(
                                              //気になるボタン
                                              width: 200.w,
                                              height: 50.h,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: concern == true
                                                      ? HexColor('EC9361')
                                                      : HexColor(
                                                          'FFDFC5'), //押したとき：押してない時
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                        FontAwesomeIcons
                                                            .exclamation,
                                                        size: 17,
                                                        color: concern == true
                                                            ? Colors.white
                                                            : HexColor(
                                                                '616161')),
                                                    SpaceBox.width(10.w),
                                                    numberOfConcern(productId),
                                                  ],
                                                ),
                                                onPressed: () async {
                                                  final user =
                                                        await FirebaseAuth
                                                            .instance
                                                            .currentUser;
                                                    final userId =
                                                        user?.uid.toString();
                                                  setState(() async {
                                                    concern = !concern;
                                                    if (userId != '') {
                                                      if (concern == false) {
                                                        String doc =
                                                            randomString(20);
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "concern")
                                                            .doc(doc)
                                                            .set({
                                                          "concern_id": doc,
                                                          'product_id':
                                                              productId,
                                                          'user_id': userId,
                                                          "addtime": FieldValue
                                                              .serverTimestamp(),
                                                          "update_date": FieldValue
                                                              .serverTimestamp(),
                                                        });
                                                      } else {
                                                        final snapshot =
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'concern')
                                                                .where(
                                                                    'user_id',
                                                                    isEqualTo:
                                                                        userId)
                                                                .where(
                                                                    'product_id',
                                                                    isEqualTo:
                                                                        productId)
                                                                .get();
                                                        final concern =
                                                            snapshot.docs[0];
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'concern')
                                                            .doc(concern[
                                                                'concern_id'])
                                                            .delete();
                                                      }
                                                    } else {
                                                      showDialog<void>(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return LoginAlert();
                                                          });
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                          ))),
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              child: Center(
                                            child: SizedBox(
                                              //リピートボタン
                                              width: 200.w,
                                              height: 50.h,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: repeat == true
                                                      ? HexColor('EC9361')
                                                      : HexColor('FFDFC5'),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(FontAwesomeIcons.sync,
                                                        size: 17,
                                                        color: repeat == true
                                                            ? Colors.white
                                                            : HexColor(
                                                                '616161')),
                                                    SpaceBox.width(10),
                                                    Text('リピート (${repeatnum})',
                                                        style: TextStyle(
                                                            color: repeat ==
                                                                    true
                                                                ? Colors.white
                                                                : HexColor(
                                                                    '616161'),
                                                            fontSize: 17.sp))
                                                  ],
                                                ),
                                                onPressed: () {
                                                  setState(() async {
                                                    repeat = !repeat;
                                                    final user =
                                                        await FirebaseAuth
                                                            .instance
                                                            .currentUser;
                                                    final userId =
                                                        user?.uid.toString();
                                                    if (userId != '') {
                                                      if (repeat == false) {
                                                        String doc =
                                                            randomString(20);
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "repeat")
                                                            .doc(doc)
                                                            .set({
                                                          "repeat_id": doc,
                                                          'product_id':
                                                              productId,
                                                          'user_id': userId,
                                                          "addtime": FieldValue
                                                              .serverTimestamp(),
                                                          "update_date": FieldValue
                                                              .serverTimestamp(),
                                                        });
                                                      } else {
                                                        final snapshot =
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'repeat')
                                                                .where(
                                                                    'user_id',
                                                                    isEqualTo:
                                                                        userId)
                                                                .where(
                                                                    'product_id',
                                                                    isEqualTo:
                                                                        productId)
                                                                .get();
                                                        final concern =
                                                            snapshot.docs[0];
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'repeat')
                                                            .doc(concern[
                                                                'repeat_id'])
                                                            .delete();
                                                      }
                                                    } else {
                                                      showDialog<void>(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return LoginAlert();
                                                          });
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                          ))),
                                    ],
                                  ),
                                  SpaceBox.height(20.h),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              child: Column(
                                            children: [
                                              SizedBox(
                                                //原材料ドロップダウン
                                                width: 700.w,
                                                height: 40.h,
                                                child: ElevatedButton(
                                                    child: Text(
                                                      '原材料',
                                                      style: TextStyle(
                                                          fontSize: 14.sp),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: Colors.white,
                                                      onPrimary:
                                                          HexColor('EC9361'),
                                                      side: BorderSide(
                                                          color: HexColor(
                                                              'EC9361')),
                                                    ),
                                                    onPressed: () async {
                                                      setState(() {
                                                        _materials =
                                                            !_materials;
                                                      });
                                                    }),
                                              ),
                                              Visibility(
                                                  //押してない時の空間
                                                  visible: !_materials,
                                                  child: SpaceBox.height(40.h)),
                                              Visibility(
                                                  //押したとき表示
                                                  visible: _materials,
                                                  child: Container(
                                                      width: 700.w,
                                                      // height: 150,
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SelectableText(
                                                              result[
                                                                  'raw_material'],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.sp),
                                                              scrollPhysics:
                                                                  NeverScrollableScrollPhysics(),
                                                            ),
                                                            SpaceBox.height(
                                                                20.h)
                                                          ])
                                                      // child: SelectableText(result['raw_material'],scrollPhysics: NeverScrollableScrollPhysics(),),
                                                      )),
                                              SizedBox(
                                                //アレルギードロップダウン
                                                width: 700.w,
                                                height: 40.h,
                                                child: ElevatedButton(
                                                    child: Text('アレルギー',
                                                        style: TextStyle(
                                                            fontSize: 14.sp)),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: Colors.white,
                                                      onPrimary:
                                                          HexColor('EC9361'),
                                                      side: BorderSide(
                                                          color: HexColor(
                                                              'EC9361')),
                                                    ),
                                                    onPressed: () async {
                                                      setState(() {
                                                        _allergy = !_allergy;
                                                      });
                                                    }),
                                              ),
                                              Visibility(
                                                  //押してない時の空間
                                                  visible: !_allergy,
                                                  child: SpaceBox.height(40.h)),
                                              Visibility(
                                                  //押したとき表示
                                                  visible: _allergy,
                                                  child: Container(
                                                      width: 700.w,
                                                      // height: 100,
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            (result['allergy_id']
                                                                        [0] ==
                                                                    '')
                                                                ? Text('')
                                                                : Row(
                                                                    children: [
                                                                        for (int i =
                                                                                0;
                                                                            i < result['allergy_id'].length;
                                                                            i++)
                                                                          allergyName(result['allergy_id'][i])
                                                                      ]),
                                                            SpaceBox.height(
                                                                20.h)
                                                          ]))),
                                              SizedBox(
                                                //栄養成分ドロップダウン
                                                width: 700.w,
                                                height: 40.h,
                                                child: ElevatedButton(
                                                    child: Text('栄養成分',
                                                        style: TextStyle(
                                                            fontSize: 14.sp)),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: Colors.white,
                                                      onPrimary:
                                                          HexColor('EC9361'),
                                                      side: BorderSide(
                                                          color: HexColor(
                                                              'EC9361')),
                                                    ),
                                                    onPressed: () async {
                                                      setState(() {
                                                        _nutrition =
                                                            !_nutrition;
                                                      });
                                                    }),
                                              ),
                                              Visibility(
                                                  //押したとき表示
                                                  visible: _nutrition,
                                                  child: Container(
                                                      width: 700.w,
                                                      // height: 100,
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            nutritionalIngredients(
                                                                result[
                                                                    'product_id']),
                                                            SpaceBox.height(20)
                                                          ])
                                                      // child: SelectableText(
                                                      //     '${result['nutritional_ingredients'][0]} / ${result['nutritional_ingredients'][1]} / ${result['nutritional_ingredients'][2]} / ${result['nutritional_ingredients'][3]} / ${result['nutritional_ingredients'][4]} / ${result['nutritional_ingredients'][5]}',scrollPhysics: NeverScrollableScrollPhysics())

                                                      ))
                                            ],
                                          ))),
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              //割合棒グラフ
                                              height: 300.h,
                                              padding:
                                                  EdgeInsets.only(left: 20.w),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  repeatAge(productId),
                                                  // SpaceBox.height(20.h),
                                                  reviewAge(productId),
                                                ],
                                              ))),
                                    ],
                                  ),
                                ],
                              );
                            }),
                        //仕切り線
                        Divider(
                          height: 20.h,
                          thickness: 5,
                          indent: 0,
                          endIndent: 0,
                        ),
                        ReviewPage(productId), //レビュー
                      ])),
              FooterCreate(),
            ],
          ),

          //フッター固定ボタン
          Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                  data: Theme.of(context)
                      .copyWith(canvasColor: Colors.transparent),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    padding:
                        EdgeInsets.symmetric(vertical: 7.h, horizontal: 17.w),
                    width: 370.w,
                    height: 65.h,
                    decoration: BoxDecoration(
                      color: HexColor('EC9361'),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            //レビューボタン
                            child: Text('この商品をレビューする',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp)),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 30.w),
                              primary: Colors.white,
                              onPrimary: HexColor('EC9361'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReviewPostPage(
                                        productId,
                                        product_name,
                                        image,
                                        maker,
                                        '商品詳細'),
                                  ));
                            },
                          ),
                          Tooltip(
                            message: 'クリップボードに保存します',
                            child: StreamBuilder(
                                stream:
                                    FirebaseAuth.instance.authStateChanges(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }

                                  if (snapshot.hasData) {
                                    final user =
                                        FirebaseAuth.instance.currentUser;
                                    final data = user?.uid;
                                    if (data != null) {
                                      String uid = data.toString();
                                      return ElevatedButton(
                                        //クリップボタン
                                        child: Icon(Icons.assignment_turned_in,
                                            size: 30.sp),
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.all(20.sp),
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
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("/account/" +
                                                  uid +
                                                  "/clip_list/")
                                              .doc(productId)
                                              .set({
                                            'product_name': product_name,
                                            'image_url': image,
                                            'product_id': productId,
                                          });
                                        },
                                      );
                                    }
                                  }
                                  return ElevatedButton(
                                      //クリップボタン
                                      child: Icon(Icons.assignment_turned_in,
                                          size: 30.sp),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(20.sp),
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
                                      onPressed: () async {
                                        final snapshot =
                                            FirebaseAuth.instance.currentUser;
                                        if (snapshot == null) {
                                          return showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return LoginAlert();
                                            },
                                          );
                                        }
                                      });
                                }),
                          ),
                        ],
                      ),
                    ),
                  ))),
        ],
      ),
      floatingActionButton: clipButton('商品詳細'),
    );
  }
}

//割合棒グラフ
Widget percent_indicator(String name, double persent) {
  double persentsub = persent * 100; //パーセントを100表示
  String persenttext = persentsub.ceil().toString(); //パーセントを文字化

  return Padding(
    padding: EdgeInsets.all(15.0.sp),
    child: new LinearPercentIndicator(
      width: 140.0.w,
      lineHeight: 17.0.h,
      percent: persent,
      center: Text(
        persenttext + '%',
        style: TextStyle(fontSize: 12.0.sp),
      ),
      leading: Container(
        width: 60.w,
        child: Text(name, style: TextStyle(fontSize: 14.sp)),
      ),
      linearStrokeCap: LinearStrokeCap.roundAll,
      backgroundColor: HexColor('E0E0E0'),
      progressColor: HexColor('FFDF4C'),
    ),
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
