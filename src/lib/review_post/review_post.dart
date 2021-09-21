import 'dart:html';

import 'package:flutter/material.dart';
// パッケージ
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart'; //パンくず
// 外部ファイル
import 'package:umy_foods/HexColor.dart'; //16進数カラーコード
import 'package:umy_foods/SpaceBox.dart'; //空間
import 'package:umy_foods/details/details.dart';
import 'package:umy_foods/header.dart';
import 'package:umy_foods/footer.dart';
import 'package:umy_foods/main.dart';

class ReviewPostPage extends StatefulWidget {
  ReviewPostPage(
      this.productId, this.product_name, this.image, this.maker, this.where);
  final String productId;
  final String where;
  final String product_name;
  final String image;
  final String maker;
  @override
  _ReviewPostPageState createState() =>
      _ReviewPostPageState(productId, product_name, image, maker, where);
}

//ラジオボタンの割り当て
enum SweetnessRadio { FIRST, SECOND, THIRD, FOUR, FIVE }
enum AcidityRadio { FIRST, SECOND, THIRD, FOUR, FIVE }
enum SaltyRadio { FIRST, SECOND, THIRD, FOUR, FIVE }
enum BitterRadio { FIRST, SECOND, THIRD, FOUR, FIVE }
enum SpicyRadio { FIRST, SECOND, THIRD, FOUR, FIVE }
enum TasteRadio { FIRST, SECOND, THIRD, FOUR, FIVE }

class _ReviewPostPageState extends State<ReviewPostPage> {
  _ReviewPostPageState(
      this.productId, this.product_name, this.image, this.maker, this.where);
  final String productId;
  final String product_name;
  final String image;
  final String maker;
  final String where;
  //星評価on,off判定
  final List<int> _comprehensive = [1, 2, 3];
  final List<int> _costperformance = [1, 2, 3];

  //選択した星評価の値（初期値３）
  int comprehensive_rate = 3;
  int costperformance_rate = 3;

  var repeat_text = ['はい', 'いいえ', 'わからない'];
  //選択したリピートの値（初期値はい）
  String repeat_button = 'はい';

  //ラジオボタン設定(初期値１)
  SweetnessRadio _sweetnessValue = SweetnessRadio.FIRST;
  AcidityRadio _acidityValue = AcidityRadio.FIRST;
  SaltyRadio _saltyValue = SaltyRadio.FIRST;
  BitterRadio _bitterValue = BitterRadio.FIRST;
  SpicyRadio _spicyValue = SpicyRadio.FIRST;
  TasteRadio _tasteValue = TasteRadio.FIRST;

  Widget build(BuildContext context) {
    //ユーザーID
    String userId = UID;
    return Scaffold(
        appBar: Header(),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ListView(children: [
              BreadCrumb(
                //パンくずリスト
                items: <BreadCrumbItem>[
                  BreadCrumbItem(
                    content: GestureDetector(
                      child: Text('TOP'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyApp(),
                            ));
                        setState(() {});
                      },
                    ),
                  ),
                  BreadCrumbItem(
                    content: GestureDetector(
                      child: Text(where),
                      onTap: () {
                        if (where == "商品詳細") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsPage(productId, 'レビュー投稿'),
                              ));
                          setState(() {});
                        }
                      },
                    ),
                  ),
                  BreadCrumbItem(
                    content: TextButton(
                      onPressed: () {},
                      child: SelectableText(
                        'レビュー投稿',
                        style: TextStyle(color: Colors.black),
                        scrollPhysics: NeverScrollableScrollPhysics(),
                      ),
                    ),
                  ),
                ],
                divider: Icon(Icons.chevron_right),
              ),
              SpaceBox.height(20),
              Row(children: [
                Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 25),
                            child: Row(
                              children: [
                                Container(
                                  //商品画像
                                  height: 100,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Image.network(image),
                                  ),
                                ),
                                SpaceBox.width(100),
                                Column(
                                  //商品名、メーカー
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: SelectableText(maker,
                                          style: TextStyle(fontSize: 16),
                                          scrollPhysics:
                                              NeverScrollableScrollPhysics()),
                                      height: 20,
                                    ),
                                    Container(
                                      child: SelectableText(product_name,
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                          scrollPhysics:
                                              NeverScrollableScrollPhysics()),
                                      height: 30,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                              //評価
                              margin: EdgeInsets.symmetric(vertical: 25),
                              child: Column(
                                //
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SelectableText('・評価',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: HexColor('EC9361'),
                                          fontWeight: FontWeight.bold),
                                      scrollPhysics:
                                          NeverScrollableScrollPhysics()),
                                  SpaceBox.height(20),
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 80),
                                      child: Table(
                                        columnWidths: const <int,
                                            TableColumnWidth>{
                                          0: FlexColumnWidth(0.36), //1列目幅
                                          1: FlexColumnWidth(1.0), //２列目幅
                                        },
                                        children: [
                                          TableRow(children: [
                                            Container(
                                              height: 60,
                                              child: SelectableText('総合評価',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                  scrollPhysics:
                                                      NeverScrollableScrollPhysics()),
                                            ),
                                            Row(
                                              //星評価
                                              children: [
                                                for (int cnt = 1;
                                                    cnt <= 5;
                                                    cnt++)
                                                  TextButton(
                                                    child: Icon(
                                                      Icons.star_outlined,
                                                      size: 35,
                                                    ),
                                                    style: TextButton.styleFrom(
                                                      primary: _comprehensive
                                                              .contains(cnt)
                                                          ? HexColor('FFDF4C')
                                                          : Colors
                                                              .grey, //押したとき色変化
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (comprehensive_rate !=
                                                            cnt) {
                                                          //押した星ボタンが前と違ったら
                                                          comprehensive_rate =
                                                              cnt;
                                                          _comprehensive
                                                              .clear();
                                                          for (int x = 1;
                                                              x <=
                                                                  comprehensive_rate;
                                                              x++)
                                                            _comprehensive
                                                                .add(x); //表示設定
                                                          for (int i = 5;
                                                              i >
                                                                  comprehensive_rate;
                                                              i--)
                                                            _comprehensive
                                                                .remove(
                                                                    i); //非表示設定
                                                        }
                                                      });
                                                    },
                                                  ),
                                              ],
                                            )
                                          ]),
                                          TableRow(children: [
                                            Container(
                                              height: 60,
                                              child: SelectableText('コスパ',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                  scrollPhysics:
                                                      NeverScrollableScrollPhysics()),
                                            ),
                                            Row(
                                              children: [
                                                for (int cnt = 1;
                                                    cnt <= 5;
                                                    cnt++)
                                                  TextButton(
                                                    child: Icon(
                                                      Icons.star_outlined,
                                                      size: 35,
                                                    ),
                                                    style: TextButton.styleFrom(
                                                      primary: _costperformance
                                                              .contains(cnt)
                                                          ? HexColor('FFDF4C')
                                                          : Colors.grey,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (costperformance_rate !=
                                                            cnt) {
                                                          //押した星ボタンが前と違ったら
                                                          costperformance_rate =
                                                              cnt;
                                                          _costperformance
                                                              .clear();
                                                          for (int x = 1;
                                                              x <=
                                                                  costperformance_rate;
                                                              x++)
                                                            _costperformance
                                                                .add(x); //表示設定
                                                          for (int i = 5;
                                                              i >
                                                                  costperformance_rate;
                                                              i--)
                                                            _costperformance
                                                                .remove(
                                                                    i); //非表示設定
                                                        }
                                                      });
                                                    },
                                                  ),
                                              ],
                                            )
                                          ]),
                                        ],
                                      ))
                                ],
                              )),
                          Container(
                              //味覚
                              margin: EdgeInsets.symmetric(vertical: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SelectableText('・味覚',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: HexColor('EC9361'),
                                          fontWeight: FontWeight.bold),
                                      scrollPhysics:
                                          NeverScrollableScrollPhysics()),
                                  SpaceBox.height(20),
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 80),
                                      child: Table(
                                        columnWidths: const <int,
                                            TableColumnWidth>{
                                          0: FlexColumnWidth(0.2), //1列目幅
                                          1: FlexColumnWidth(0.2), //2列目幅
                                          2: FlexColumnWidth(0.2), //3列目幅
                                          3: FlexColumnWidth(0.2), //4列目幅
                                          4: FlexColumnWidth(0.2), //5列目幅
                                          5: FlexColumnWidth(0.2), //6列目幅
                                          6: FlexColumnWidth(0.2), //7列目幅
                                          7: FlexColumnWidth(0.2), //8列目幅
                                        },
                                        children: [
                                          TableRow(children: [
                                            //値のラベル
                                            Container(
                                              height: 35,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(''),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text('低い'),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text('１'),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text('２'),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text('３'),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text('４'),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text('５'),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text('高い'),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            //甘味
                                            Container(
                                              height: 50,
                                              child: SelectableText('甘味',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                  scrollPhysics:
                                                      NeverScrollableScrollPhysics()),
                                            ),
                                            Text(''),
                                            Radio(
                                              value: SweetnessRadio.FIRST,
                                              groupValue: _sweetnessValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Sweetness(
                                                      value),
                                            ),
                                            Radio(
                                              value: SweetnessRadio.SECOND,
                                              groupValue: _sweetnessValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Sweetness(
                                                      value),
                                            ),
                                            Radio(
                                              value: SweetnessRadio.THIRD,
                                              groupValue: _sweetnessValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Sweetness(
                                                      value),
                                            ),
                                            Radio(
                                              value: SweetnessRadio.FOUR,
                                              groupValue: _sweetnessValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Sweetness(
                                                      value),
                                            ),
                                            Radio(
                                              value: SweetnessRadio.FIVE,
                                              groupValue: _sweetnessValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Sweetness(
                                                      value),
                                            ),
                                            Text(''),
                                          ]),
                                          TableRow(children: [
                                            //酸味
                                            Container(
                                              height: 50,
                                              child: SelectableText('酸味',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                  scrollPhysics:
                                                      NeverScrollableScrollPhysics()),
                                            ),
                                            Text(''),
                                            Radio(
                                              value: AcidityRadio.FIRST,
                                              groupValue: _acidityValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Acidity(
                                                      value),
                                            ),
                                            Radio(
                                              value: AcidityRadio.SECOND,
                                              groupValue: _acidityValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Acidity(
                                                      value),
                                            ),
                                            Radio(
                                              value: AcidityRadio.THIRD,
                                              groupValue: _acidityValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Acidity(
                                                      value),
                                            ),
                                            Radio(
                                              value: AcidityRadio.FOUR,
                                              groupValue: _acidityValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Acidity(
                                                      value),
                                            ),
                                            Radio(
                                              value: AcidityRadio.FIVE,
                                              groupValue: _acidityValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Acidity(
                                                      value),
                                            ),
                                            Text(''),
                                          ]),
                                          TableRow(children: [
                                            //塩味
                                            Container(
                                              height: 50,
                                              child: SelectableText('塩味',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                  scrollPhysics:
                                                      NeverScrollableScrollPhysics()),
                                            ),
                                            Text(''),
                                            Radio(
                                              value: SaltyRadio.FIRST,
                                              groupValue: _saltyValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Salty(value),
                                            ),
                                            Radio(
                                              value: SaltyRadio.SECOND,
                                              groupValue: _saltyValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Salty(value),
                                            ),
                                            Radio(
                                              value: SaltyRadio.THIRD,
                                              groupValue: _saltyValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Salty(value),
                                            ),
                                            Radio(
                                              value: SaltyRadio.FOUR,
                                              groupValue: _saltyValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Salty(value),
                                            ),
                                            Radio(
                                              value: SaltyRadio.FIVE,
                                              groupValue: _saltyValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Salty(value),
                                            ),
                                            Text(''),
                                          ]),
                                          TableRow(children: [
                                            //苦味
                                            Container(
                                              height: 50,
                                              child: SelectableText('苦味',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                  scrollPhysics:
                                                      NeverScrollableScrollPhysics()),
                                            ),
                                            Text(''),
                                            Radio(
                                              value: BitterRadio.FIRST,
                                              groupValue: _bitterValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Bitter(
                                                      value),
                                            ),
                                            Radio(
                                              value: BitterRadio.SECOND,
                                              groupValue: _bitterValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Bitter(
                                                      value),
                                            ),
                                            Radio(
                                              value: BitterRadio.THIRD,
                                              groupValue: _bitterValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Bitter(
                                                      value),
                                            ),
                                            Radio(
                                              value: BitterRadio.FOUR,
                                              groupValue: _bitterValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Bitter(
                                                      value),
                                            ),
                                            Radio(
                                              value: BitterRadio.FIVE,
                                              groupValue: _bitterValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Bitter(
                                                      value),
                                            ),
                                            Text(''),
                                          ]),
                                          TableRow(children: [
                                            //辛味
                                            Container(
                                              height: 50,
                                              child: SelectableText('辛味',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                  scrollPhysics:
                                                      NeverScrollableScrollPhysics()),
                                            ),
                                            Text(''),
                                            Radio(
                                              value: SpicyRadio.FIRST,
                                              groupValue: _spicyValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Spicy(value),
                                            ),
                                            Radio(
                                              value: SpicyRadio.SECOND,
                                              groupValue: _spicyValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Spicy(value),
                                            ),
                                            Radio(
                                              value: SpicyRadio.THIRD,
                                              groupValue: _spicyValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Spicy(value),
                                            ),
                                            Radio(
                                              value: SpicyRadio.FOUR,
                                              groupValue: _spicyValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Spicy(value),
                                            ),
                                            Radio(
                                              value: SpicyRadio.FIVE,
                                              groupValue: _spicyValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Spicy(value),
                                            ),
                                            Text(''),
                                          ]),
                                          TableRow(children: [
                                            //旨味
                                            Container(
                                              height: 50,
                                              child: SelectableText('旨味',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                  scrollPhysics:
                                                      NeverScrollableScrollPhysics()),
                                            ),
                                            Text(''),
                                            Radio(
                                              value: TasteRadio.FIRST,
                                              groupValue: _tasteValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Taste(value),
                                            ),
                                            Radio(
                                              value: TasteRadio.SECOND,
                                              groupValue: _tasteValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Taste(value),
                                            ),
                                            Radio(
                                              value: TasteRadio.THIRD,
                                              groupValue: _tasteValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Taste(value),
                                            ),
                                            Radio(
                                              value: TasteRadio.FOUR,
                                              groupValue: _tasteValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Taste(value),
                                            ),
                                            Radio(
                                              value: TasteRadio.FIVE,
                                              groupValue: _tasteValue,
                                              onChanged: (value) =>
                                                  _onRadioSelected_Taste(value),
                                            ),
                                            Text(''),
                                          ]),
                                        ],
                                      ))
                                ],
                              )),
                          Container(
                              //リピート
                              margin: EdgeInsets.symmetric(vertical: 25),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SelectableText('・リピートしたいですか？',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: HexColor('EC9361'),
                                            fontWeight: FontWeight.bold),
                                        scrollPhysics:
                                            NeverScrollableScrollPhysics()),
                                    SpaceBox.height(30),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 80),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          for (int cnt = 0; cnt < 3; cnt++)
                                            SizedBox(
                                              //リピートボタン
                                              width: 120,
                                              height: 30,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary:
                                                      repeat_button.contains(
                                                              repeat_text[cnt])
                                                          ? HexColor('B8AA8E')
                                                          : Colors.grey,
                                                ),
                                                child: Text(
                                                  repeat_text[cnt],
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    repeat_button = repeat_text[
                                                        cnt]; //選択を代入
                                                  });
                                                },
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        //投稿
                                        margin: EdgeInsets.only(
                                            top: 100, bottom: 25),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              //投稿ボタン
                                              width: 180,
                                              height: 40,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: HexColor('EC9361'),
                                                ),
                                                child: Text(
                                                  '投稿する',
                                                ),
                                                onPressed: () {
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          ],
                                        ))
                                  ]))
                        ],
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: [Text('広告')],
                    ))
              ]),
              FooterCreate(),
            ])));
  }

  //以下ラジオボタンの処理
  _onRadioSelected_Sweetness(value) {
    setState(() {
      _sweetnessValue = value;
    });
  }

  _onRadioSelected_Acidity(value) {
    setState(() {
      _acidityValue = value;
    });
  }

  _onRadioSelected_Salty(value) {
    setState(() {
      _saltyValue = value;
    });
  }

  _onRadioSelected_Bitter(value) {
    setState(() {
      _bitterValue = value;
    });
  }

  _onRadioSelected_Spicy(value) {
    setState(() {
      _spicyValue = value;
    });
  }

  _onRadioSelected_Taste(value) {
    setState(() {
      _tasteValue = value;
    });
  }
}
