import 'package:flutter/material.dart';
// パッケージ
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; //font_awesome
import 'package:percent_indicator/percent_indicator.dart'; //割合棒グラフ
// import 'package:multi_charts/multi_charts.dart'; //レーダーチャート
// import 'package:contained_tab_bar_view/contained_tab_bar_view.dart'; //年代別レビュー
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; //DB
import 'package:firebase_storage/firebase_storage.dart';

// 外部ファイル
import 'package:umy_foods/HexColor.dart'; //16進数カラーコード
import 'package:umy_foods/SpaceBox.dart'; //空間
import 'package:umy_foods/star.dart'; //星評価

class ProductPage extends StatefulWidget {
  ProductPage(this.productID);
  final String productID;
  @override
  _ProductPageState createState() => _ProductPageState(productID);
}

class _ProductPageState extends State<ProductPage> {
  _ProductPageState(this.productID);
  final String productID;
  //気になる、リピートボタン
  List<bool> _selections = List.generate(1, (_) => false);
  List<bool> _selections1 = List.generate(1, (_) => false);

  //栄養など詳細情報ボタン
  bool _materials = false;
  bool _allergy = false;
  bool _nutrition = false;

  //商品情報
  var plist = ['商品名', 'メーカ名', 'ブランド名', '発売日'];
  var pinfo = ['product_name', 'maker_id', 'brand_id', 'add_date'];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(

        //表示したいFiresotreの保存先を指定
        stream: product(productID),

        //streamが更新されるたびに呼ばれる
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //データが取れていない時の処理
          if (!snapshot.hasData) return const Text('Loading...');

          final result = snapshot.data!.docs[0];
          String imgmain = result['images'][0];

          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(result['product_name'],
                            style: TextStyle(
                              fontSize: 27.0,
                              fontWeight: FontWeight.bold,
                            )), //商品名
                        Container(
                          child: Row(
                            children: [
                              SpaceBox.width(5),
                              Icon(
                                FontAwesomeIcons.sync,
                                color: Colors.grey,
                                size: 20,
                              ),
                              Text('100',
                                  style: TextStyle(
                                    color: HexColor('#EC9361'),
                                    fontWeight: FontWeight.w900,
                                  )),
                              SpaceBox.width(20),
                              Icon(Icons.rate_review,
                                  color: Colors.grey, size: 30),
                              Text('100',
                                  style: TextStyle(
                                    color: HexColor('#EC9361'),
                                    fontWeight: FontWeight.w900,
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          //スパナ
                          icon: const Icon(
                            FontAwesomeIcons.wrench,
                            color: Colors.grey,
                            size: 20,
                          ),
                          onPressed: () {},
                        ),
                        SpaceBox.width(10),
                        Ink(
                          //Twitterボタン
                          decoration: ShapeDecoration(
                            color: HexColor('1DA1F2'),
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              FontAwesomeIcons.twitter,
                              color: Colors.white,
                              size: 20,
                            ),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ),
                        SpaceBox.width(10),
                        Ink(
                          //Instagramボタン
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              colors: [
                                HexColor('4C64D3'),
                                HexColor('CF2E92'),
                                HexColor('F26939'),
                                HexColor('FFDD83'),
                              ],
                            ),
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              FontAwesomeIcons.instagram,
                              color: Colors.white,
                              size: 20,
                            ),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ),
                        SpaceBox.width(10),
                        Ink(
                          //Facebookボタン
                          decoration: ShapeDecoration(
                            color: HexColor('3b5998'),
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              FontAwesomeIcons.facebook,
                              color: Colors.white,
                              size: 20,
                            ),
                            color: Colors.white,
                            onPressed: () {},
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
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            height: 330,
                            child: Image.network(imgmain), //メイン商品画像
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                          padding: EdgeInsets.only(left: 100),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        //総合星評価
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [Text('総合評価'), star(4, 30)],
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        //コスパ星評価
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [Text('コスパ'), star(2, 30)],
                                      )),
                                ],
                              ),
                              SpaceBox.height(20),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('商品情報',
                                    style: TextStyle(fontSize: 20)),
                              ),
                              SpaceBox.height(20),
                              Table(
                                //商品情報テーブル
                                columnWidths: const <int, TableColumnWidth>{
                                  0: FlexColumnWidth(0.4), //１列目の幅の割合
                                  1: FlexColumnWidth(1.0), //２列目の幅の割合
                                },
                                children: [
                                  TableRow(children: [
                                    Text('商品名'),
                                    Text(result['product_name']),
                                    SpaceBox.height(30),
                                  ]),
                                  TableRow(children: [
                                    Text('メーカーID'),
                                    Text(result['maker_id']),
                                    SpaceBox.height(30),
                                  ]),
                                  TableRow(children: [
                                    Text('メーカー名'),
                                    makerName(result['maker_id']),
                                    SpaceBox.height(30),
                                  ]),
                                  TableRow(children: [
                                    Text('ブランド名'),
                                    brandName(result['brand_id']),
                                    SpaceBox.height(30),
                                  ]),
                                ],
                              )
                            ],
                          ))),
                ],
              ),
              SpaceBox.height(20),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                          //商品画像切り替え
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (int i = 0; i < result['images'].length; i++)
                            GestureDetector(
                                //商品画像
                                onTap: () {
                                  setState(() {
                                    imgmain = (result['images'][i] == "null")
                                        ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf'
                                        : result['images'][i];
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Container(
                                    height: 100, //画像サイズ
                                    width: 100,
                                    child: (result['images'][i] == "null")
                                        ? Image.network(
                                            'gs://umyfoods-rac.appspot.com/NoImage.png')
                                        : Image.network(result['images'][i]),
                                  ),
                                )),
                        ],
                      ))),
                  Expanded(
                      flex: 1,
                      child: Container(
                        //購入情報（未定）
                        padding: EdgeInsets.only(left: 100),
                        child: Text('購入情報'),
                      )),
                ],
              ),
              SpaceBox.height(20),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                          //気になるボタン
                          child: Center(
                        child: Container(
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: HexColor('FFDFC5'),
                            border: Border.all(color: Colors.white, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: ToggleButtons(
                            color: HexColor('616161'), //文字色
                            selectedColor: Colors.white, //押したときの文字色
                            selectedBorderColor: HexColor('EC9361'), //押したときの枠
                            fillColor: HexColor('EC9361'), //押したときの背景
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.exclamation,
                                        size: 15,
                                      ),
                                      SpaceBox.width(15),
                                      Text('気になる (435)')
                                    ],
                                  ))
                            ],
                            isSelected: _selections,
                            onPressed: (int index) {
                              setState(() {
                                _selections[index] = !_selections[index];
                              });
                            },
                          ),
                        ),
                      ))),
                  Expanded(
                      flex: 1,
                      child: Container(
                          //リピートボタン
                          padding: EdgeInsets.only(left: 100),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                color: HexColor('FFDFC5'),
                                border:
                                    Border.all(color: Colors.white, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: ToggleButtons(
                                color: HexColor('616161'), //文字色
                                selectedColor: Colors.white, //押したときの文字色
                                selectedBorderColor:
                                    HexColor('EC9361'), //押したときの枠
                                fillColor: HexColor('EC9361'), //押したときの背景
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Row(
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.exclamation,
                                            size: 15,
                                          ),
                                          SpaceBox.width(15),
                                          Text('リピート (435)')
                                        ],
                                      ))
                                ],
                                isSelected: _selections1,
                                onPressed: (int index) {
                                  setState(() {
                                    _selections1[index] = !_selections1[index];
                                  });
                                },
                              ),
                            ),
                          ))),
                ],
              ),
              SpaceBox.height(20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                          child: Column(
                        children: [
                          SizedBox(
                            //原材料ドロップダウン
                            width: 700,
                            height: 40,
                            child: ElevatedButton(
                                child: const Text('原材料'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: HexColor('EC9361'),
                                  side: BorderSide(color: HexColor('EC9361')),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    _materials = !_materials;
                                  });
                                }),
                          ),
                          Visibility(
                              //押してない時の空間
                              visible: !_materials,
                              child: SpaceBox.height(40)),
                          Visibility(
                              //押したとき表示
                              visible: _materials,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Text(result['raw_material']),
                              )),
                          SizedBox(
                            //アレルギードロップダウン
                            width: 700,
                            height: 40,
                            child: ElevatedButton(
                                child: const Text('アレルギー'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: HexColor('EC9361'),
                                  side: BorderSide(color: HexColor('EC9361')),
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
                              child: SpaceBox.height(40)),
                          Visibility(
                              //押したとき表示
                              visible: _allergy,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Row(children: [
                                  for (int i = 0;
                                      i < result['allergy_id'].length;
                                      i++)
                                    allergyName(result['allergy_id'][i])
                                ]),
                              )),
                          SizedBox(
                            //栄養成分ドロップダウン
                            width: 700,
                            height: 40,
                            child: ElevatedButton(
                                child: const Text('栄養成分'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: HexColor('EC9361'),
                                  side: BorderSide(color: HexColor('EC9361')),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    _nutrition = !_nutrition;
                                  });
                                }),
                          ),
                          // Visibility(
                          //   visible: !_nutrition,
                          //   child: SpaceBox.height(40)
                          // ),
                          Visibility(
                            //押したとき表示
                            visible: _nutrition,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Text(
                                  '${result['nutritional_ingredients'][0]} / ${result['nutritional_ingredients'][1]} / ${result['nutritional_ingredients'][2]} / ${result['nutritional_ingredients'][3]} / ${result['nutritional_ingredients'][4]} / ${result['nutritional_ingredients'][5]}'),
                            ),
                          )
                        ],
                      ))),
                  Expanded(
                      flex: 1,
                      child: Container(
                          //割合棒グラフ
                          height: 300,
                          padding: EdgeInsets.only(left: 100),
                          child: Column(
                            children: [
                              Text('この商品を「気になる」しているユーザーの年代'),
                              Table(
                                children: [
                                  TableRow(children: [
                                    percent_indicator('~10代', 0.1),
                                    percent_indicator('20代', 0.2),
                                  ]),
                                  TableRow(children: [
                                    percent_indicator('30代', 0.9),
                                    percent_indicator('40代~', 0.2),
                                  ])
                                ],
                              ),
                              SpaceBox.height(20),
                              Text('この商品を「レビュー」しているユーザーの年代'),
                              Table(
                                children: [
                                  TableRow(children: [
                                    percent_indicator('~10代', 0.1),
                                    percent_indicator('20代', 0.2),
                                  ]),
                                  TableRow(children: [
                                    percent_indicator('30代', 0.9),
                                    percent_indicator('40代~', 0.2),
                                  ])
                                ],
                              ),
                            ],
                          ))),
                ],
              ),
            ],
          );
        });
  }

  //割合棒グラフ
  Widget percent_indicator(String name, double persent) {
    double persentsub = persent * 100; //パーセントを100表示
    String persenttext = persentsub.toString(); //パーセントを文字化

    return Padding(
      padding: EdgeInsets.all(15.0),
      child: new LinearPercentIndicator(
        width: 140.0,
        lineHeight: 14.0,
        percent: persent,
        center: Text(
          persenttext + '%',
          style: new TextStyle(fontSize: 12.0),
        ),
        leading: Container(
          width: 60,
          child: Text(name),
        ),
        linearStrokeCap: LinearStrokeCap.roundAll,
        backgroundColor: HexColor('E0E0E0'),
        progressColor: HexColor('FFDF4C'),
      ),
    );
  }
}

Stream<QuerySnapshot> product(String id) {
  return FirebaseFirestore.instance
      .collection('product')
      .where('product_id', isEqualTo: id)
      .snapshots();
}

//メーカー

Widget makerName(id) {
  return StreamBuilder<QuerySnapshot>(

      //表示したいFiresotreの保存先を指定
      stream: FirebaseFirestore.instance
          .collection('maker')
          .where('maker_id', isEqualTo: int.parse(id))
          .snapshots(),

      //streamが更新されるたびに呼ばれる
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //データが取れていない時の処理
        if (!snapshot.hasData) return const Text('Loading...');

        String result = snapshot.data!.docs[0]['maker_name'];

        return Text(result);
      });
}

//ブランド

Widget brandName(id) {
  return StreamBuilder<QuerySnapshot>(

      //表示したいFiresotreの保存先を指定
      stream: FirebaseFirestore.instance
          .collection('brand')
          .where('brand_id', isEqualTo: id)
          .snapshots(),

      //streamが更新されるたびに呼ばれる
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //データが取れていない時の処理
        if (!snapshot.hasData) return const Text('Loading...');

        String result = snapshot.data!.docs[0]['brand_name'];

        return Text(result);
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
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //データが取れていない時の処理
        if (!snapshot.hasData) return const Text('Loading...');

        String result = snapshot.data!.docs[0]['allergy_name'];

        return Text('${result}　');
      });
}
