import 'package:flutter/material.dart';

// パッケージ
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart'; //パンくず
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
import 'package:umy_foods/details/review.dart'; //レビュー
import 'package:umy_foods/star.dart'; //星評価
import 'package:umy_foods/footer.dart'; //フッター
import 'package:umy_foods/header.dart'; //ヘッダー
import 'package:umy_foods/main.dart';
import 'package:umy_foods/review_post/review_post.dart'; //レビュー投稿
import 'package:umy_foods/clipButton.dart';

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

  @override
  Widget build(BuildContext context) {

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
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //データが取れていない時の処理
            if (!snapshot.hasData) return const Text('Loading...');

            String result = snapshot.data!.docs[0]['maker_name'];
            maker = result;

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
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //データが取れていない時の処理
            if (!snapshot.hasData) return const Text('Loading...');

            String result = snapshot.data!.docs[0]['allergy_name'];

            return Text('${result}　');
          });
    }

    return Scaffold(
      appBar: Header(),
      body: Stack(
        children: [
          ListView(
            children: [Padding(
              padding: EdgeInsets.symmetric(horizontal: 60,vertical: 20),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                BreadCrumb(
                  //パンくずリスト
                  items: <BreadCrumbItem>[
                    BreadCrumbItem(
                      content: TextButton(
                        child: Text(
                          where,
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp()));
                        }
                      ),
                    ),
                      BreadCrumbItem(
                        content: TextButton(
                          child: Text(
                            '商品詳細',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: (){
                          }
                        ),
                      ),
                  ],
                  divider: Icon(Icons.chevron_right),
                ),
                SpaceBox.height(20),
                //商品詳細
                StreamBuilder<QuerySnapshot>(

                    //表示したいFiresotreの保存先を指定
                    stream: product(productId),

                    //streamが更新されるたびに呼ばれる
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      //データが取れていない時の処理
                      if (!snapshot.hasData) return const Text('Loading...');

                      final result = snapshot.data!.docs[0];
                      String imgmain = result['images'][0];
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
                                    SelectableText(result['product_name'],
                                        style: TextStyle(
                                          fontSize: 27.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        scrollPhysics: NeverScrollableScrollPhysics()
                                    ), //商品名
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SelectableText('総合評価',scrollPhysics: NeverScrollableScrollPhysics()),
                                                      star(4, 30)
                                                    ],
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    //コスパ星評価
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SelectableText('コスパ',scrollPhysics: NeverScrollableScrollPhysics()),
                                                      star(2, 30)
                                                    ],
                                                  )),
                                            ],
                                          ),
                                          SpaceBox.height(20),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: SelectableText('商品情報',
                                              scrollPhysics: NeverScrollableScrollPhysics(),
                                              style: TextStyle(fontSize: 20)),
                                          ),
                                          SpaceBox.height(20),
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
                                                SelectableText('商品名',scrollPhysics: NeverScrollableScrollPhysics()),
                                                SelectableText(result['product_name'],scrollPhysics: NeverScrollableScrollPhysics()),
                                                SpaceBox.height(30),
                                              ]),
                                              TableRow(children: [
                                                SelectableText('メーカー名',scrollPhysics: NeverScrollableScrollPhysics()),
                                                makerName(result['maker_id']),
                                                SpaceBox.height(30),
                                              ]),
                                              TableRow(children: [
                                                SelectableText('ブランド名',scrollPhysics: NeverScrollableScrollPhysics()),
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
                                                imgmain = (result['images']
                                                            [i] ==
                                                        "null")
                                                    ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf'
                                                    : result['images'][i];
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                              child: Container(
                                                height: 100, //画像サイズ
                                                width: 100,
                                                child: (result['images'][i] ==
                                                        "null")
                                                    ? Image.network(
                                                        'gs://umyfoods-rac.appspot.com/NoImage.png')
                                                    : Image.network(
                                                        result['images'][i]),
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
                                  child: Center(
                                    child:SizedBox(  //気になるボタン
                                      width: 200,
                                      height: 50,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: concern==true ? HexColor('EC9361') : HexColor('FFDFC5'), //押したとき：押してない時
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(FontAwesomeIcons.exclamation,size: 17,color:concern==true ? Colors.white : HexColor('616161')),
                                            SpaceBox.width(10),
                                            Text('気になる (435)',style:TextStyle(color:concern==true ? Colors.white : HexColor('616161'),fontSize: 17)) 
                                          ],
                                        ),                                
                                        onPressed: () {
                                          setState(() {
                                            concern= !concern;
                                          });
                                        },
                                      ),
                                    ),  
                                  )
                                )
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(  
                                  child: Center(
                                    child:SizedBox(  //リピートボタン
                                      width: 200,
                                      height: 50,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: repeat==true ? HexColor('EC9361') : HexColor('FFDFC5'),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(FontAwesomeIcons.sync,size: 17,color:repeat==true ? Colors.white : HexColor('616161')),
                                            SpaceBox.width(10),
                                            Text('リピート (435)',style:TextStyle(color:repeat==true ? Colors.white : HexColor('616161'),fontSize: 17)) 
                                          ],
                                        ),                                 
                                        onPressed: () {
                                          setState(() {
                                            repeat= !repeat;
                                          });
                                        },
                                      ),
                                    ),  
                                  )
                                )
                              ),
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
                                              side: BorderSide(
                                                  color: HexColor('EC9361')),
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
                                          child:Container(
                                            width: 700,
                                            height: 40,
                                            child: SelectableText(result['raw_material'],scrollPhysics: NeverScrollableScrollPhysics()),
                                          )
                                      ),
                                      SizedBox(
                                        //アレルギードロップダウン
                                        width: 700,
                                        height: 40,
                                        child: ElevatedButton(
                                            child: const Text('アレルギー'),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              onPrimary: HexColor('EC9361'),
                                              side: BorderSide(
                                                  color: HexColor('EC9361')),
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
                                          child:Container(
                                            width: 700,
                                            height: 40,
                                            child: Row(children: [
                                              for (int i = 0;
                                                  i <
                                                      result['allergy_id']
                                                          .length;
                                                  i++)
                                                allergyName(
                                                    result['allergy_id'][i])
                                            ]),
                                          )
                                        ),
                                      SizedBox(
                                        //栄養成分ドロップダウン
                                        width: 700,
                                        height: 40,
                                        child: ElevatedButton(
                                            child: const Text('栄養成分'),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              onPrimary: HexColor('EC9361'),
                                              side: BorderSide(
                                                  color: HexColor('EC9361')),
                                            ),
                                            onPressed: () async {
                                              setState(() {
                                                _nutrition = !_nutrition;
                                              });
                                            }),
                                      ),
                                      Visibility(
                                        //押したとき表示
                                        visible: _nutrition,
                                        child:Container(
                                          width: 700,
                                          height: 40,
                                          child: SelectableText(
                                              '${result['nutritional_ingredients'][0]} / ${result['nutritional_ingredients'][1]} / ${result['nutritional_ingredients'][2]} / ${result['nutritional_ingredients'][3]} / ${result['nutritional_ingredients'][4]} / ${result['nutritional_ingredients'][5]}',scrollPhysics: NeverScrollableScrollPhysics())
                                              
                                        )
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
                                          SelectableText('この商品を「気になる」しているユーザーの年代',scrollPhysics: NeverScrollableScrollPhysics()),
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
                    }),
                //仕切り線
                const Divider(
                  height: 20,
                  thickness: 5,
                  indent: 0,
                  endIndent: 0,
                ),
                ReviewPage(productId),//レビュー
                ])
              ),
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
                    margin: EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 17),
                    width: 350,
                    height:65,
                    decoration: BoxDecoration(
                      color: HexColor('EC9361'),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            //レビューボタン
                            child: const Text('この商品をレビューする',style: TextStyle(fontWeight: FontWeight.w600)),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 30),
                              primary: Colors.white,
                              onPrimary: HexColor('EC9361'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ReviewPostPage(
                                        productId,
                                        product_name,
                                        image,
                                        maker,
                                        '商品詳細'),
                                  ));
                            },
                          ),
                          ElevatedButton(
                            //クリップボタン
                            child: Icon(
                              Icons.assignment_turned_in,size:30
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(20),
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
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ))),
        ],
      ),
      floatingActionButton: clipButton(),
    );
  }
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
