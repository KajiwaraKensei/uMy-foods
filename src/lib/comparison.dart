import 'package:flutter/material.dart';
import 'package:multi_charts/multi_charts.dart';

class Comparison extends StatefulWidget {
  @override
  _ComparisonState createState() => _ComparisonState();
}

class _ComparisonState extends State<Comparison> {
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
    'RefPrice',
    'InterCap',
    'Brand',
    'RelDate',
  ];
  // 味覚以外のリスト
  final List<Map<String, dynamic>> conItems = [
    {
      'Name': 'カントリーマアム',
      'Image': 'https://www.toysrus.co.jp/i/5/0/8/508961100AML.jpg',
      'Eval': 5, // 総合評価
      'Rank': 'お菓子2位',
      'Repeat': <double>[252, 249],
      'Con': 252, // 気になる
      'CostP': 4, // コスパ
      'taste': <double>[10, 0, 0, 0, 0, 0, 8],
      'Material': 'いろいろ', // 原材料
      'Allergy': '小麦',
      'Nutrition': 'カロリー：10g,タンパク質：11g',
      'Manufact': 'どこか', // メーカー
      'RefPrice': '250円',
      'InterCap': '100g',
      'Brand': 'カントリーマアム',
      'RelDate': '1990/01/01',
    },
    {
      'Name': 'エリーゼ',
      'Image': 'https://www.life-netsuper.jp/k-kinkicommon/parts/data/item/04901360273010.jpg',
      'Eval': 5, // 総合評価
      'Rank': 'お菓子1位',
      'Repeat': <double>[999, 999],
      'Con': 99999, // 気になる
      'CostP': 5, // コスパ
      'taste': <double>[10, 0, 0, 0, 0, 0, 10],
      'Material': 'いろいろ', // 原材料
      'Allergy': '小麦',
      'Nutrition': 'カロリー：5g,タンパク質：8g',
      'Manufact': 'ブルボン', // メーカー
      'RefPrice': '200円',
      'InterCap': '110g',
      'Brand': 'エリーゼ',
      'RelDate': '1990/01/01',
    },
    {
      'Name': '苺トッポ',
      'Image': 'https://images-fe.ssl-images-amazon.com/images/I/71SBG7SSapL.__AC_SX300_SY300_QL70_ML2_.jpg',
      'Eval': 5, // 総合評価
      'Rank': 'お菓子3位',
      'Repeat': <double>[212, 200],
      'Con': 212, // 気になる
      'CostP': 5, // コスパ
      'taste': <double>[8, 0, 0, 0, 0, 0, 8],
      'Material': 'いろいろ', // 原材料
      'Allergy': '小麦',
      'Nutrition': 'エネルギー：10g,タンパク質：11g',
      'Manufact': 'ロッテ', // メーカー
      'RefPrice': '112円',
      'InterCap': '51g',
      'Brand': 'トッポ',
      'RelDate': '2021/06/20',
    },
    {
      'Name': 'ポッキー',
      'Image': 'https://images-na.ssl-images-amazon.com/images/I/71mxyAVWynL._AC_SL1500_.jpg',
      'Eval': 5, // 総合評価
      'Rank': 'お菓子4位',
      'Repeat': <double>[111, 80],
      'Con': 51, // 気になる
      'CostP': 4, // コスパ
      'taste': <double>[7, 0, 0, 0, 0, 0, 7],
      'Material': 'いろいろ', // 原材料
      'Allergy': '小麦',
      'Nutrition': 'エネルギー：10g,タンパク質：11g',
      'Manufact': '江崎グリコ', // メーカー
      'RefPrice': '120円',
      'InterCap': '51g',
      'Brand': 'ポッキー',
      'RelDate': '2021/06/20',
    },
    {
      'Name': 'プリッツ',
      'Image': 'https://stat.ameba.jp/user_images/20200226/19/feals/4c/99/j/o0466034614719411273.jpg',
      'Eval': 5, // 総合評価
      'Rank': 'お菓子5位',
      'Repeat': <double>[300, 250], // [レビュー数, リピしたい数]
      'Con': 300, // 気になる
      'CostP': 4, // コスパ
      'taste': <double>[4, 0, 7, 0, 0, 0, 10],
      'Material': 'いろいろ', // 原材料
      'Allergy': '小麦',
      'Nutrition': 'エネルギー：10g,タンパク質：11g',
      'Manufact': '江崎グリコ', // メーカー
      'RefPrice': '120円',
      'InterCap': '51g',
      'Brand': 'プリッツ',
      'RelDate': '2021/06/20',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor('F5F3EF'),
        ),
        body: Padding(
          padding: EdgeInsets.all(30.0),
          child: ListView(children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text('トップ＞比較'),
            ),
            SingleChildScrollView(
              // SingleChildScrollViewで子ウィジェットをラップ
              scrollDirection: Axis.horizontal, // スクロールの向きを水平方向に指定
              child: Column(
                children: [
                  // 入れ替えボタン
                  Container(
                    margin: EdgeInsets.fromLTRB(120, 0, 0, 0),
                    child: Row(
                      children: <Widget>[
                        for (ccnt = 0; ccnt < conItems.length; ccnt++)
                          Container(
                            //color: HexColor('ff9999'), // 確認用
                            width: 300, // 商品一覧コンテナと同じ数値
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  //color: HexColor('ffff99'), // 確認用
                                  width: 200,
                                  margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      showGL(ccnt),
                                      showGR(ccnt),
                                    ],
                                  ),
                                ),
                                Container(
                                  //color: Colors.blue, // 確認用
                                  width: 50,
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: showGX(ccnt),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  // 比較する商品一覧
                  Row(
                    children: [
                      myContainer(size: 120, color: Colors.blue, text: 'list'),
                      for (ccnt = 0; ccnt < conItems.length; ccnt++) myContainer(color: Colors.orange, text: 'contents'),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  Widget myContainer({double size = 300, required Color color, String text = ''}) {
    var slist = ["商品名", "商品画像", "総合評価", "ランキング", "リピートしたい", "気になる", "コスパ", "味覚", "原材料", "アレルギー", "栄養成分表示", "メーカー", "参考価格", "内容量", "ブランド", "発売日"];

    return Container(
      color: color,
      width: size,
      child: Column(children: [
        Table(
          border: TableBorder.all(),
          children: [
            for (int rcnt = 0; rcnt < 16; rcnt++)
              TableRow(children: [
                //height通常20
                if (text == 'list')
                  if (rcnt == 1)
                    Container(
                      child: Center(child: Text(slist[rcnt], style: TextStyle(color: HexColor('616161')))),
                      color: HexColor('ffdfc5'),
                      height: 150,
                    )
                  else if (rcnt == 7)
                    Container(
                      child: Center(child: Text(slist[rcnt], style: TextStyle(color: HexColor('616161')))),
                      color: HexColor('ffdfc5'),
                      height: 200,
                    )
                  else
                    Container(
                      child: Center(child: Text(slist[rcnt], style: TextStyle(color: HexColor('616161')))),
                      color: HexColor('ffdfc5'),
                    )
                else if (text == 'contents')
                  if (rcnt == 1) //商品画像
                    Container(
                      child: Padding(padding: EdgeInsets.all(5.0), child: Center(child: Image.network(conItems[ccnt]['Image']))),
                      height: 150,
                      width: 200,
                      color: Colors.white,
                    )
                  else if (rcnt == 2) //総合評価
                    Container(
                      child: Center(child: Text(conItems[ccnt]['Eval'].toString(), style: TextStyle(color: Colors.black))),
                      color: Colors.white,
                    )
                  else if (rcnt == 4) //リピートしたい
                    Container(
                      child: Center(child: Text(showRepeat(conItems[ccnt][conItemLabels[rcnt]]), style: TextStyle(color: Colors.black))),
                      color: Colors.white,
                    )
                  else if (rcnt == 5) //気になる
                    Container(
                      child: Center(child: Text(conItems[ccnt][conItemLabels[rcnt]].toString() + '回', style: TextStyle(color: Colors.black))),
                      color: Colors.white,
                    )
                  else if (rcnt == 6) //コスパ
                    Container(
                      child: Center(child: Text(conItems[ccnt]['CostP'].toString(), style: TextStyle(color: Colors.black))),
                      color: Colors.white,
                    )
                  else if (rcnt == 7) //レーダーチャート
                    Container(
                      width: 200,
                      height: 200,
                      color: Colors.white,
                      //Radar Chart
                      child: RadarChart(
                        animate: false, // アニメーションの有無 true or false
                        //animationDuration: Duration(milliseconds: 150), //アニメーションの再生速度 150ミリ秒
                        values: conItems[ccnt]['taste'],
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
                      ),
                    )
                  else
                    Container(
                      child: Center(child: Text(conItems[ccnt][conItemLabels[rcnt]], style: TextStyle(color: Colors.black))),
                      color: Colors.white,
                    )
              ])
          ],
        ),
        // child: Text(
        //   text,
        //   style: TextStyle(
        //       fontSize: 48,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.white
        //   ),
        // ),
      ]),
    );
  }

  String showRepeat(List lists) {
    const base_namber = 1; // 四捨五入する小数点の場所  1(小数点第1) 10(第2) 100(第3) ...
    String tmp = (((lists[1] / lists[0] * 100) * base_namber).round() / base_namber).toString() + '%';
    return tmp;
  }

  // < を表示
  GestureDetector showGL(int i) {
    return GestureDetector(
        onTap: () => {changeListL(i)},
        child: Icon(
          Icons.chevron_left,
          color: HexColor('696969'),
          size: 40,
        ));
  }

  // > を表示
  GestureDetector showGR(int i) {
    return GestureDetector(
        onTap: () => {changeListR(i)},
        child: Icon(
          Icons.chevron_right,
          color: HexColor('696969'),
          size: 40,
        ));
  }

  // X を表示
  GestureDetector showGX(int i) {
    return GestureDetector(
        onTap: () => {deleteList(i)},
        child: Icon(
          Icons.close,
          color: HexColor('696969'),
          size: 20,
        ));
  }

  // リストの入れ替え
  void changeListR(int x) {
    // x・・・対象の添え字
    if (x != -1) {
      var temp = conItems[x];
      setState(() {
        conItems[x] = conItems[x + 1];
        conItems[x + 1] = temp;
      });
    }
  }

  // リストの入れ替え(左移動)
  void changeListL(int x) {
    if (x != 0) {
      var temp = conItems[x];
      setState(() {
        conItems[x] = conItems[x - 1];
        conItems[x - 1] = temp;
      });
    }
  }

  // リストの要素削除
  void deleteList(int x) {
    setState(() {
      conItems.removeAt(x); // 添え字xの要素を削除
    });
  }
}

//16進数カラーコード
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
