import 'package:flutter/material.dart';
// パッケージ
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; //font_awesome
import 'package:percent_indicator/percent_indicator.dart'; //割合棒グラフ
// import 'package:multi_charts/multi_charts.dart'; //レーダーチャート
// import 'package:contained_tab_bar_view/contained_tab_bar_view.dart'; //年代別レビュー

// 外部ファイル
import 'package:umy_foods/HexColor.dart'; //16進数カラーコード
import 'package:umy_foods/SpaceBox.dart'; //空間
import 'package:umy_foods/star.dart'; //星評価

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  //気になる、リピートボタン
  List<bool> _selections = List.generate(1, (_) => false);
  List<bool> _selections1 = List.generate(1, (_) => false);

  //栄養など詳細情報ボタン
  bool _materials = false;
  bool _allergy = false;
  bool _nutrition = false;

  //商品情報
  var plist = ['商品名', 'メーカ名', 'ブランド名', '発売日', '内容量'];
  var pinfo = ['つぶつぶいちごポッキー', 'グリコ', 'ポッキー', '2019/1/25', '‎750 g'];

  //商品画像
  String imgmain =
      'https://m.media-amazon.com/images/I/71tcgatTdML._AC_SL1500_.jpg';
  String img1 =
      'https://m.media-amazon.com/images/I/71tcgatTdML._AC_SL1500_.jpg';
  String img2 =
      'https://m.media-amazon.com/images/I/61qh2yP5IkS._AC_SL1000_.jpg';
  String img3 =
      'https://m.media-amazon.com/images/I/61D6cymmZuS._AC_SL1000_.jpg';
  String img4 =
      'https://m.media-amazon.com/images/I/61U5RiR9kyS._AC_SL1000_.jpg';
  String img5 =
      'https://m.media-amazon.com/images/I/61E2OBPzmoS._AC_SL1000_.jpg';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(pinfo[0],
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
                        Icon(Icons.rate_review, color: Colors.grey, size: 30),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text('総合評価'), star(4, 30)],
                                )),
                            Expanded(
                                flex: 1,
                                child: Column(
                                  //コスパ星評価
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text('コスパ'), star(2, 30)],
                                )),
                          ],
                        ),
                        SpaceBox.height(20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('商品情報', style: TextStyle(fontSize: 20)),
                        ),
                        SpaceBox.height(20),
                        Table(
                          //商品情報テーブル
                          columnWidths: const <int, TableColumnWidth>{
                            0: FlexColumnWidth(0.6), //１列目の幅の割合
                            1: FlexColumnWidth(1.0), //２列目の幅の割合
                          },
                          children: [
                            for (int i = 0; i < 5; i++)
                              TableRow(children: [
                                Text(plist[i]),
                                Text(pinfo[i]),
                                SpaceBox.height(30),
                              ]),
                          ],
                        ),
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
                    GestureDetector(
                        //商品画像１
                        onTap: () {
                          setState(() {
                            imgmain = img1;
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
                            child: Image.network(img1),
                          ),
                        )),
                    GestureDetector(
                        //商品画像２
                        onTap: () {
                          setState(() {
                            imgmain = img2;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image.network(img2),
                          ),
                        )),
                    GestureDetector(
                        //商品画像３
                        onTap: () {
                          setState(() {
                            imgmain = img3;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image.network(img3),
                          ),
                        )),
                    GestureDetector(
                        //商品画像４
                        onTap: () {
                          setState(() {
                            imgmain = img4;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image.network(img4),
                          ),
                        )),
                    GestureDetector(
                        //商品画像５
                        onTap: () {
                          setState(() {
                            imgmain = img5;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image.network(img5),
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
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
                          border: Border.all(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
                          child: Text(
                              '小麦粉、砂糖、植物油脂、乳糖、全粉乳、ココアパウダー、いちごパウダー、小麦たんぱく、ショートニング、キャンデーチップ、食塩、イースト／着色料（アカビート色素、ブドウ果皮色素、カラメル）、乳化剤、香料、調味料（無機塩）、膨脹剤、酸味料、トレハロース、甘味料（スクラロース）、（一部に乳成分・小麦・大豆を含む）'),
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
                          child: Text('乳成分、小麦、大豆、カカオ'),
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
                              'たん白質（g）　2.1g/1袋（標準27.5g） 脂質（g）　6.8g/1袋（標準27.5g） 炭水化物（g）　18g/1袋（標準27.5g） ナトリウム（mg）　140mg/1袋（標準27.5g）')),
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
