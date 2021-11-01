import 'dart:html';

import 'package:flutter/material.dart';
import 'package:multi_charts/multi_charts.dart';
import 'package:umy_foods/HexColor.dart';
import 'package:umy_foods/clipButton.dart';
import 'package:umy_foods/header.dart';
import 'package:umy_foods/footer.dart';
import 'package:umy_foods/main.dart';
import 'package:umy_foods/details/details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; //DB
import "package:intl/intl.dart";
import 'package:intl/date_symbol_data_local.dart'; //日時用

import 'package:flutter_breadcrumb/flutter_breadcrumb.dart'; //パンくず
import 'package:umy_foods/star.dart'; //星評価
import 'package:umy_foods/SpaceBox.dart'; //空間

double nameheight = 27.5;
double imageheight = 150;
double evaheight = 20.6;
double tastehight = 200;
double materialheight = 300;
double nutritionalheight = 160;

class Comparison extends StatefulWidget {
  Comparison({Key? key, required this.productList}) : super(key: key);
  List<String> productList;
  @override
  _ComparisonState createState() => _ComparisonState(productList);
}

class _ComparisonState extends State<Comparison> {
  _ComparisonState(this.productList);
  List<String> productList;
  bool darkMode = false;
  bool useSides = false;
  double numberOfFeatures = 6;

  // 行カウント
  var ccnt = 0;

  List<String> conItemLabels = [
    'Name',
    'Image',
    'Eval',
    'Rank',
    'Repeat',
    'Con',
    'CostP',
    'taste',
    'Material',
    'Allergy',
    'Nutrition',
    'Manufact',
    'Brand',
    'RelDate',
  ];
  // 味覚以外のリスト
  final List<Map<String, dynamic>> conItems = [];
  final List<int> _items = List<int>.generate(50, (int index) => index);

  @override
  Widget build(BuildContext context) {
    Widget myContainer({
      double size = 350,
      String text = '',
    }) {
      var slist = [
        "商品名",
        "商品画像",
        "総合評価",
        "ランキング",
        "リピート",
        "気になる",
        "コスパ",
        "味覚",
        "原材料",
        "アレルギー",
        "栄養成分表示",
        "メーカー",
        "ブランド",
        "発売日" //削除？
      ];

      return Container(
        width: size,
        child: Column(children: [
          Container(
            //スペースとるためのコンテナ
            height: 69,
          ),
          Table(
            border: TableBorder.all(),
            children: [
              for (int rcnt = 0; rcnt < 14; rcnt++)
                TableRow(children: [
                  //height通常20
                  if (text == 'list')
                    if (rcnt == 1)
                      Container(
                        child: Center(
                            child: Text(slist[rcnt],
                                style: TextStyle(color: HexColor('616161')))),
                        color: HexColor('ffdfc5'),
                        height: imageheight,
                      )
                    else if (rcnt == 0)
                      Container(
                        child: Center(
                            child: Text(slist[rcnt],
                                style: TextStyle(color: HexColor('616161')))),
                        color: HexColor('ffdfc5'),
                        height: nameheight,
                      )
                    else if (rcnt == 2)
                      Container(
                        child: Center(
                            child: Text(slist[rcnt],
                                style: TextStyle(color: HexColor('616161')))),
                        color: HexColor('ffdfc5'),
                        height: evaheight,
                      )
                    else if (rcnt == 6)
                      Container(
                        child: Center(
                            child: Text(slist[rcnt],
                                style: TextStyle(color: HexColor('616161')))),
                        color: HexColor('ffdfc5'),
                        height: evaheight,
                      )
                    else if (rcnt == 7)
                      Container(
                        child: Center(
                            child: Text(slist[rcnt],
                                style: TextStyle(color: HexColor('616161')))),
                        color: HexColor('ffdfc5'),
                        height: tastehight,
                      )
                    else if (rcnt == 8)
                      Container(
                        child: Center(
                            child: Text(slist[rcnt],
                                style: TextStyle(color: HexColor('616161')))),
                        color: HexColor('ffdfc5'),
                        height: materialheight,
                      )
                    else if (rcnt == 10)
                      Container(
                        child: Center(
                            child: Text(slist[rcnt],
                                style: TextStyle(color: HexColor('616161')))),
                        color: HexColor('ffdfc5'),
                        height: nutritionalheight,
                      )
                    else
                      Container(
                        child: Center(
                            child: Text(slist[rcnt],
                                style: TextStyle(color: HexColor('616161')))),
                        color: HexColor('ffdfc5'),
                      )
                ])
            ],
          ),
        ]),
      );
    }

    String showRepeat(List lists) {
      const base_namber = 1; // 四捨五入する小数点の場所  1(小数点第1) 10(第2) 100(第3) ...
      String tmp =
          (((lists[1] / lists[0] * 100) * base_namber).round() / base_namber)
                  .toString() +
              '%';
      return tmp;
    }

    return Scaffold(
      appBar: Header(),
      body: ListView(children: [
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
                          Navigator.pop(context);
                        }),
                  ),
                  BreadCrumbItem(
                    content: TextButton(
                        child: Text(
                          '比較',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {}),
                  ),
                ],
                divider: Icon(Icons.chevron_right),
              ),
              LimitedBox(
                maxHeight: 1165, //最大の高さを指定
                child: ReorderableListView(
                  header: Container(
                    child: myContainer(size: 120, text: 'list'),
                  ),
                  scrollDirection: Axis.horizontal, // スクロールの向きを水平方向に指定
                  buildDefaultDragHandles: false,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final item = productList.removeAt(oldIndex);
                      productList.insert(newIndex, item);
                    });
                  },
                  children: <Widget>[
                    for (int index = 0; index < productList.length; index++)
                      Card(
                        key: Key('$index'),
                        child: Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SpaceBox.width(110),
                                Container(
                                  width: 64,
                                  height: 64,
                                  padding: const EdgeInsets.all(8),
                                  child: ReorderableDragStartListener(
                                    index: index,
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.drag_handle_outlined,
                                        ),
                                        onPressed: () {}),
                                  ),
                                ),
                                SpaceBox.width(90),
                                Align(
                                  child: Tooltip(
                                    message: 'クリップボードから削除します',
                                    child: showGX(index, productList[index]),
                                  ),
                                  alignment: Alignment.centerRight,
                                ),
                              ]),
                          data(productList[index]),
                        ]),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        FooterCreate(),
      ]),
    );
  }

  // リストの要素削除
  void deleteList(int i, product_id) {
    setState(() {
      FirebaseFirestore.instance
          .collection('/account/' + Id + '/clip_list/')
          .doc(product_id)
          .delete();
      productList.removeAt(i); // 添え字xの要素を削除
    });
  }

  // X を表示
  GestureDetector showGX(int i, product_id) {
    return GestureDetector(
        onTap: () => {
              showDialog<int>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('確認'),
                    content: Text('クリップボードから削除します。よろしいですか。'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('削除'),
                        onPressed: () {
                          deleteList(i, product_id);
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text('戻る'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  );
                },
              ),
            },
        child: Icon(
          Icons.close,
          color: HexColor('696969'),
          size: 20,
        ));
  }

  Widget data(product_id) {
    return StreamBuilder<QuerySnapshot>(
        //key: Key(product_id),

        //表示したいFiresotreの保存先を指定
        stream: FirebaseFirestore.instance
            .collection('product')
            .where('product_id', isEqualTo: product_id)
            .snapshots(),

        //streamが更新されるたびに呼ばれる
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //データが取れていない時の処理
          if (!snapshot.hasData) return const Text('Loading...');

          final result = snapshot.data!.docs[0];
          return Container(
              width: 300,
              child: Column(
                children: [
                  Table(border: TableBorder.all(), children: [
                    TableRow(children: [
                      Container(
                        //商品名
                        child: Center(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailsPage(
                                              result['product_id'], '比較')));
                                },
                                child: Text(result['product_name'],
                                    style: TextStyle(color: Colors.black)))),
                        color: Colors.white,
                      ),
                    ]),
                    TableRow(children: [
                      Container(
                        //画像
                        child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Center(
                                child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                            result['product_id'], '比較')));
                              },
                              child: Image.network((result['images'][0] == "")
                                  ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf'
                                  : result['images'][0]),
                            ))),
                        height: imageheight,
                        width: 200,
                        color: Colors.white,
                      ),
                    ]),
                    TableRow(children: [
                      elevalation(result['product_id']),
                    ]),
                    TableRow(children: [
                      Container(
                        //ランキング
                        child: Center(
                            child: Text('ランキング',
                                style: TextStyle(color: Colors.black))),
                        color: Colors.white,
                      ),
                    ]),
                    TableRow(children: [repeat(result['product_id'])]),
                    TableRow(children: [
                      concern(result['product_id']),
                    ]),
                    TableRow(children: [
                      cospa(result['product_id']),
                    ]),
                    TableRow(children: [
                      mikaku(result['product_id']),
                    ]),
                    TableRow(children: [
                      Container(
                        //原材料
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Scrollbar(
                            isAlwaysShown: false,
                            child: SingleChildScrollView(
                                child: Text(result['raw_material'],
                                    style: TextStyle(color: Colors.black))),
                          ),
                        ),
                        color: Colors.white,
                        height: materialheight,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      ),
                    ]),
                    TableRow(children: [
                      allergyName(result['allergy_id']),
                    ]),
                    TableRow(children: [
                      nutritionalIngredients(result['product_id']),
                    ]),
                    TableRow(children: [
                      makerName(result['maker_id']),
                    ]),
                    TableRow(children: [
                      brandName(result['maker_id'], result['brand_id'])
                    ]),
                    TableRow(children: [
                      Container(
                        //発売日
                        child: Center(
                            child: (DateFormat("yyyy/MM/dd")
                                        .format(result['release_date'].toDate())
                                        .toString() ==
                                    '0001/01/01')
                                ? Text('')
                                : Text(
                                    DateFormat("yyyy/MM/dd")
                                        .format(result['release_date'].toDate())
                                        .toString(),
                                    style: TextStyle(color: Colors.black))),
                        color: Colors.white,
                      ),
                    ]),
                  ]),
                ],
              ));
        });
  }
}

review(product_id) {
  return FirebaseFirestore.instance
      .collection('review')
      .where('product_id', isEqualTo: product_id)
      .snapshots();
}

Widget elevalation(product_id) {
  return StreamBuilder<QuerySnapshot>(

      //表示したいFiresotreの保存先を指定
      stream: review(product_id),

      //streamが更新されるたびに呼ばれる
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //データが取れていない時の処理
        if (!snapshot.hasData) return const Text('Loading...');

        final result = snapshot.data!.docs;
        List<int> evaList = []; //評価リスト

        if (result.length == 0) {
          return Container(
              height: evaheight,
              //評価
              child: Center(child: Text('レビューなし')));
        }

        for (int j = 0; j < result.length; j++) {
          //評価
          evaList.add(result[j]['review_evaluation']);
        }

        double ave = evaList.reduce((a, b) => a + b) / evaList.length;
        int average = ave.round();

        return Container(
            //評価
            child: Center(
          child: star(average, 20),
        ));
      });
}

Widget repeat(product_id) {
  return StreamBuilder<QuerySnapshot>(

      //表示したいFiresotreの保存先を指定
      stream: FirebaseFirestore.instance
          .collection('repeat')
          .where('product_id', isEqualTo: product_id)
          .snapshots(),

      //streamが更新されるたびに呼ばれる
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //データが取れていない時の処理
        if (!snapshot.hasData) return const Text('Loading...');

        final result = snapshot.data!.docs;

        return Container(
          //リピート
          child: Center(
              child: Text(result.length.toString(),
                  style: TextStyle(color: Colors.black))),
          color: Colors.white,
        );
      });
}

Widget concern(product_id) {
  return StreamBuilder<QuerySnapshot>(

      //表示したいFiresotreの保存先を指定
      stream: FirebaseFirestore.instance
          .collection('concern')
          .where('product_id', isEqualTo: product_id)
          .snapshots(),

      //streamが更新されるたびに呼ばれる
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //データが取れていない時の処理
        if (!snapshot.hasData) return const Text('Loading...');

        final result = snapshot.data!.docs;

        return Container(
          //リピート
          child: Center(
              child: Text(result.length.toString(),
                  style: TextStyle(color: Colors.black))),
          color: Colors.white,
        );
      });
}

Widget cospa(product_id) {
  return StreamBuilder<QuerySnapshot>(

      //表示したいFiresotreの保存先を指定
      stream: review(product_id),

      //streamが更新されるたびに呼ばれる
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //データが取れていない時の処理
        if (!snapshot.hasData) return const Text('Loading...');

        final result = snapshot.data!.docs;
        List<int> cospaList = []; //評価リスト

        if (result.length == 0) {
          return Container(
              height: evaheight,
              //評価
              child: Center(child: Text('レビューなし')));
        }

        for (int j = 0; j < result.length; j++) {
          //評価
          cospaList.add(result[j]['review_cospa']);
        }

        double ave = cospaList.reduce((a, b) => a + b) / cospaList.length;
        int average = ave.round();

        return Container(
            height: evaheight,
            //評価
            child: Center(
              child: star(average, 20),
            ));
      });
}

Widget mikaku(product_id) {
  return StreamBuilder<QuerySnapshot>(

      //表示したいFiresotreの保存先を指定
      stream: review(product_id),

      //streamが更新されるたびに呼ばれる
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //データが取れていない時の処理
        if (!snapshot.hasData) return const Text('Loading...');

        final result = snapshot.data!.docs;
        List<int> cospaList = []; //評価リスト

        if (result.length == 0) {
          List<double> mikaku = [0, 0, 0, 0, 0, 0];
        }

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

        return Container(
          //味覚
          width: 200,
          height: tastehight,
          color: Colors.white,
          //Radar Chart
          child: RadarChart(
            animate: false, // アニメーションの有無 true or false
            animationDuration: Duration(milliseconds: 700), //アニメーションの再生速度 ミリ秒
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
            chartRadiusFactor: 0.8,
          ),
        );
      });
}

Widget allergyName(id) {
  return Container(
    //アレルギー
    child: Center(
      child: StreamBuilder<QuerySnapshot>(

          //表示したいFiresotreの保存先を指定
          stream: FirebaseFirestore.instance
              .collection('allergy')
              .where('allergy_id', whereIn: id)
              .snapshots(),

          //streamが更新されるたびに呼ばれる
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //データが取れていない時の処理
            if (!snapshot.hasData) return const Text('Loading...');

            final result = snapshot.data!.docs;
            String allergyList = '';

            for (int i = 0; i < result.length; i++) {
              if (i == 0)
                allergyList += result[i]['allergy_name'];
              else
                allergyList += '、' + result[i]['allergy_name'];
            }

            if (result.length == 0) {
              return Text('');
            }

            return Text(allergyList);
          }),
    ),
    color: Colors.white,
  );
}

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
        if (!snapshot.hasData) return const Text('Loading...');

        return Container(
          //栄養成分
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText('${snapshot.data!['subject']}',
                  scrollPhysics: NeverScrollableScrollPhysics()),
              Container(
                height: 5,
              ),
              SelectableText('たんぱく質　　　　　${snapshot.data!['たんぱく質']}',
                  scrollPhysics: NeverScrollableScrollPhysics()),
              SelectableText('エネルギー　　　　　${snapshot.data!['エネルギー']}',
                  scrollPhysics: NeverScrollableScrollPhysics()),
              SelectableText('炭水化物　　　　　　${snapshot.data!['炭水化物']}',
                  scrollPhysics: NeverScrollableScrollPhysics()),
              SelectableText('脂質　　　　　　　　${snapshot.data!['脂質']}',
                  scrollPhysics: NeverScrollableScrollPhysics()),
              SelectableText('食塩相当量　　　　　${snapshot.data!['食塩相当量']}',
                  scrollPhysics: NeverScrollableScrollPhysics()),
            ],
          ),
          color: Colors.white,
          height: nutritionalheight,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        );
      });
}

Widget makerName(String id) {
  return StreamBuilder<QuerySnapshot>(

      //表示したいFiresotreの保存先を指定
      stream: FirebaseFirestore.instance
          .collection('maker')
          .where('maker_id', isEqualTo: id)
          .snapshots(),

      //streamが更新されるたびに呼ばれる
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //データが取れていない時の処理
        if (!snapshot.hasData) return const Text('Loading...');

        final result = snapshot.data!.docs;

        if (result.length == 0) {
          return Container(
            child: Center(child: Text('No Data')),
            color: Colors.white,
          );
        }

        return Container(
          //メーカー
          child: Center(child: Text(result[0]['maker_name'])),
          color: Colors.white,
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
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //データが取れていない時の処理
        if (!snapshot.hasData) return const Text('Loading...');

        final result = snapshot.data!.docs;

        if (result.length == 0) {
          return Container(
            //アレルギー
            child: Center(child: Text('No Data')),
            color: Colors.white,
          );
        }

        return Container(
          //ブランド
          child: Center(child: Text(result[0]['brand_name'])),
          color: Colors.white,
        );
      });
}
