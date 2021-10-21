import 'dart:html';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:umy_foods/comparison.dart';
import 'package:umy_foods/header.dart';
import 'package:umy_foods/footer.dart';
import 'package:umy_foods/details/details.dart';
import 'package:umy_foods/clipButton.dart';
import 'package:umy_foods/HexColor.dart';
import 'package:umy_foods/star.dart';
import 'package:umy_foods/list_page/brand.dart';
import 'package:umy_foods/new_item/newitem.dart';
import 'package:umy_foods/carousel_list.dart';

// きになる　リピート　評価　カテゴリ毎(ランダム)

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch, // 通常のタッチ入力デバイス
        PointerDeviceKind.mouse, // これを追加！
      };
}

void main() => runApp(MyApp());

String UID = "";
String UserImage = "";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'uMyFoods',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: Home(),
      scrollBehavior: MyCustomScrollBehavior(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var media_width = MediaQuery.of(context).size.width;
    var media_height = MediaQuery.of(context).size.height;

    var testcategory = ['飲料水', '炭酸飲料', '炭酸水'];
    var rankicon = ['images/icon/first.png', 'images/icon/second.png', 'images/icon/third.png'];
    CarouselController buttonCarouselController = CarouselController();
    CarouselController reviewbuttonCarouselController = CarouselController();

    final List<Map<String, dynamic>> ConcernRanking = [
      {
        'Text': 'きのこの山とたけのこの里 12袋',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1iSBzQche-bz05pN4oy14EFgCi7ha7a_xiw&usqp=CAU',
        'product_id': 'ZVHwc73pOtwxEaUZJHh',
      },
      {
        'Text': 'ガルボチョコパウチ 76g',
        'image': 'https://livedoor.blogimg.jp/plankman/imgs/b/f/bfa6566c.jpg',
        'product_id': 'SqmSD7f4cQz6Zl2u73l',
      },
      {
        'Text': '明治ホワイトチョコレート 40g',
        'image': 'https://livedoor.blogimg.jp/plankman/imgs/e/e/ee5945d2.jpg',
        'product_id': 'XAVe9QfDTkKDJoUHnNZ',
      },
    ];
    final List<Map<String, dynamic>> RepeatRanking = [
      {
        'Text': '明治ホワイトチョコレート 40g',
        'image': 'https://livedoor.blogimg.jp/plankman/imgs/e/e/ee5945d2.jpg',
        'product_id': '3rRMgFVGkqIQGj2gCOC',
      },
      {
        'Text': 'きのこの山とたけのこの里 12袋',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1iSBzQche-bz05pN4oy14EFgCi7ha7a_xiw&usqp=CAU',
        'product_id': '0JEOwz9bBqm4p9HVuDz',
      },
      {
        'Text': 'マーブル 32g',
        'image': '',
        'product_id': '0uUyWU7Yfp1LxgcJhXN',
      },
    ];
    final List<Map<String, dynamic>> user = [
      {
        'Text': '田中実',
        'image': 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/anotherUser.png?alt=media&token=2dbc4946-c13b-4718-8fef-ba9e08c2e51f',
      },
      {
        'Text': 'ルーシー',
        'image': 'http://petrichor.blue/wp-content/uploads/2018/11/46132564_570624860055194_808212540440969216_n.mp4_snapshot_00.34_2018.11.18_03.06.07-e1542478230568.jpg',
      },
      {
        'Text': 'John Doe',
        'image': 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/johnDoe.png?alt=media&token=07cbee0a-d3f0-45a7-8df7-fd03a6d5f980',
      },
      {
        'Text': 'オオノ',
        'image': '',
      },
    ];
    final List<Map<String, dynamic>> new_item = [
      {
        'Text': 'Red Bull 250ml',
        'image': 'https://img07.shop-pro.jp/PA01350/082/product/137945030.jpg',
        'date': '2021/09/16',
        'maker': 'レッドブル・ジャパン',
      },
      {'Text': 'ガルボチョコパウチ 76g', 'image': 'https://livedoor.blogimg.jp/plankman/imgs/b/f/bfa6566c.jpg', 'date': '2021/08/30', 'maker': '明治'},
      {'Text': 'ウィルキンソン', 'image': 'https://m.media-amazon.com/images/I/61KZUmru1sL._AC_SL1500_.jpg', 'date': '2021/09/16', 'maker': 'アサヒ飲料'},
    ];
    final List<Map<String, dynamic>> review = [
      {
        'name': '田中実',
        'gender': '女性',
        'age': '20代',
        'product': 'ウィルキンソン',
        'star': 1,
        'Text': '思っていたより炭酸が強すぎて、炭酸が苦手でなくても飲みにくかった。',
        'image': 'https://m.media-amazon.com/images/I/61KZUmru1sL._AC_SL1500_.jpg',
      },
      {
        'name': '高橋太郎',
        'gender': '男性',
        'age': '50代',
        'product': '練乳いちごミルク',
        'star': 1,
        'Text': 'この商品を詐欺罪で訴えます。理由は勿論お分かりですね。あなたが皆をこんなパッケージで騙し、期待を破壊したからです！覚悟の準備をしておいてください。近いうちに訴えます。裁判も起こします。',
        'image': 'https://cdn-ak.f.st-hatena.com/images/fotolife/d/drinkoon/20210125/20210125000127.jpg',
      },
      {
        'name': 'ハナ',
        'gender': '女性',
        'age': '40代',
        'product': 'きのこの山とたけのこの里 12袋',
        'star': 5,
        'Text': 'たけこのきのこ戦争とは無意味だ。争いの果てになにが残る？争う必要はない。両方食べればいいのだ。なーんて言うと思ったかぁ！たけのこの里が一番に決まってんだろうがあああああ！！',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1iSBzQche-bz05pN4oy14EFgCi7ha7a_xiw&usqp=CAU',
      },
    ];
    final List<Map<String, dynamic>> tag = [
      {
        'Text': '片手で食べれるお菓子',
        'image': 'https://www.bourbon.co.jp/product_file/file/2151.jpg',
      },
      {
        'Text': 'エナジードリンク',
        'image': 'https://img07.shop-pro.jp/PA01350/082/product/137945030.jpg',
      },
      {
        'Text': '小腹がすいたら',
        'image': 'https://livedoor.blogimg.jp/plankman/imgs/b/f/bfa6566c.jpg',
      },
    ];

    // ランキングカルーセル用のリスト
    // 2個セットのRowのリスト
    List<Widget> rankingSliders = [
      rankingcarousel(
        context,
        media_width,
        media_height,
        rankicon,
        '気になる',
        ConcernRanking,
        testcategory,
        'リピート',
        RepeatRanking,
        testcategory,
      ),
      rankingcarousel(
        context,
        media_width,
        media_height,
        rankicon,
        '炭酸水',
        ConcernRanking,
        testcategory,
        '総合評価',
        RepeatRanking,
        testcategory,
      ),

      // Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Container(
      //       width: media_width * 0.26,
      //       child: Column(
      //         children: [
      //           SelectableText(
      //             '評価ランキング',
      //             scrollPhysics: NeverScrollableScrollPhysics(),
      //             style: TextStyle(
      //               fontSize: 16.5,
      //               fontWeight: FontWeight.w600,
      //             ),
      //           ),
      //           // ランキングのカテゴリ
      //           SelectableText(
      //             testcategory[0] + '>' + testcategory[1] + '>' + testcategory[2],
      //             scrollPhysics: NeverScrollableScrollPhysics(),
      //             style: TextStyle(
      //               fontSize: 12,
      //               color: HexColor('616161'),
      //             ),
      //           ),
      //           // リピートカード部分
      //           for (var i = 0; i < 3; i++)
      //             Card(
      //               margin: EdgeInsets.symmetric(vertical: 10),
      //               child: new InkWell(
      //                 onTap: () {
      //                   Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                         builder: (context) => DetailsPage(RepeatRanking[i]['product_id'], 'TOP'),
      //                       ));
      //                 },
      //                 child: Container(
      //                   width: media_width * 0.245,
      //                   height: media_height * 0.185,
      //                   child: Row(
      //                     // レイアウト追加　間隔均等配置
      //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Stack(
      //                         children: [
      //                           Center(
      //                             child: Container(
      //                               margin: EdgeInsets.only(left: 1),
      //                               width: media_width * 0.1,
      //                               height: media_height * 0.13,
      //                               child: Image.network(
      //                                 (RepeatRanking[i]['image'] == "")
      //                                     ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf'
      //                                     : RepeatRanking[i]['image'],
      //                                 fit: BoxFit.contain,
      //                               ),
      //                             ),
      //                           ),
      //                           Container(
      //                             margin: EdgeInsets.only(top: 5, left: 15),
      //                             width: media_width * 0.03,
      //                             height: media_height * 0.06,
      //                             child: Center(
      //                               child: Image.asset(
      //                                 rankicon[i],
      //                                 fit: BoxFit.contain,
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       Container(
      //                         width: media_width * 0.14,
      //                         margin: EdgeInsets.only(top: 5, left: 5),
      //                         child: Column(
      //                           // レイアウト追加 間隔均等配置
      //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                           // ベースラインに揃えて配置
      //                           crossAxisAlignment: CrossAxisAlignment.baseline,

      //                           // ベースラインの指定
      //                           textBaseline: TextBaseline.alphabetic,
      //                           children: [
      //                             SelectableText(
      //                               RepeatRanking[i]['Text'],
      //                               maxLines: 2,
      //                               scrollPhysics: NeverScrollableScrollPhysics(),
      //                               style: TextStyle(
      //                                 fontSize: 14,
      //                                 fontWeight: FontWeight.w600,
      //                               ),
      //                             ),
      //                             // スターレーティング部分
      //                             star(5, 20),
      //                             Row(
      //                               children: [
      //                                 Icon(
      //                                   Icons.priority_high,
      //                                 ),
      //                                 Text('1'),
      //                                 Container(
      //                                   margin: EdgeInsets.only(left: 7),
      //                                   child: Icon(Icons.sync, color: Colors.blue),
      //                                 ),
      //                                 Text('100'),
      //                                 // クリップボタン
      //                                 Container(
      //                                   margin: EdgeInsets.only(left: 20, bottom: 4),
      //                                   child: ElevatedButton(
      //                                     //クリップボタン
      //                                     child: Icon(
      //                                       Icons.assignment_turned_in,
      //                                     ),
      //                                     style: ElevatedButton.styleFrom(
      //                                       padding: EdgeInsets.all(12),
      //                                       primary: HexColor('EC9361'),
      //                                       onPrimary: Colors.white,
      //                                       shape: CircleBorder(
      //                                         side: BorderSide(
      //                                           color: Colors.transparent,
      //                                           width: 1,
      //                                           style: BorderStyle.solid,
      //                                         ),
      //                                       ),
      //                                     ),
      //                                     onPressed: () {},
      //                                   ),
      //                                 ),
      //                               ],
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //         ],
      //       ),
      //     ),
      //     Container(
      //       width: media_width * 0.26,
      //       child: Column(
      //         children: [
      //           SelectableText(
      //             '炭酸水ランキング',
      //             scrollPhysics: NeverScrollableScrollPhysics(),
      //             style: TextStyle(
      //               fontSize: 16.5,
      //               fontWeight: FontWeight.w600,
      //             ),
      //           ),
      //           // ランキングのカテゴリ
      //           SelectableText(
      //             testcategory[0] + '>' + testcategory[1] + '>' + testcategory[2],
      //             scrollPhysics: NeverScrollableScrollPhysics(),
      //             style: TextStyle(
      //               fontSize: 12,
      //               color: HexColor('616161'),
      //             ),
      //           ),
      //           // リピートカード部分
      //           for (var i = 0; i < 3; i++)
      //             Card(
      //               margin: EdgeInsets.symmetric(vertical: 10),
      //               child: new InkWell(
      //                 onTap: () {
      //                   Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                         builder: (context) => DetailsPage(RepeatRanking[i]['product_id'], 'TOP'),
      //                       ));
      //                 },
      //                 child: Container(
      //                   width: media_width * 0.245,
      //                   height: media_height * 0.185,
      //                   child: Row(
      //                     // レイアウト追加　間隔均等配置
      //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Stack(
      //                         children: [
      //                           Center(
      //                             child: Container(
      //                               margin: EdgeInsets.only(left: 1),
      //                               width: media_width * 0.1,
      //                               height: media_height * 0.13,
      //                               child: Image.network(
      //                                 (RepeatRanking[i]['image'] == "")
      //                                     ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf'
      //                                     : RepeatRanking[i]['image'],
      //                                 fit: BoxFit.contain,
      //                               ),
      //                             ),
      //                           ),
      //                           Container(
      //                             margin: EdgeInsets.only(top: 5, left: 15),
      //                             width: media_width * 0.03,
      //                             height: media_height * 0.06,
      //                             child: Center(
      //                               child: Image.asset(
      //                                 rankicon[i],
      //                                 fit: BoxFit.contain,
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       Container(
      //                         width: media_width * 0.14,
      //                         margin: EdgeInsets.only(top: 5, left: 5),
      //                         child: Column(
      //                           // レイアウト追加 間隔均等配置
      //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                           // ベースラインに揃えて配置
      //                           crossAxisAlignment: CrossAxisAlignment.baseline,

      //                           // ベースラインの指定
      //                           textBaseline: TextBaseline.alphabetic,
      //                           children: [
      //                             SelectableText(
      //                               RepeatRanking[i]['Text'],
      //                               maxLines: 2,
      //                               scrollPhysics: NeverScrollableScrollPhysics(),
      //                               style: TextStyle(
      //                                 fontSize: 14,
      //                                 fontWeight: FontWeight.w600,
      //                               ),
      //                             ),
      //                             // スターレーティング部分
      //                             star(5, 20),
      //                             Row(
      //                               children: [
      //                                 Icon(
      //                                   Icons.priority_high,
      //                                 ),
      //                                 Text('1'),
      //                                 Container(
      //                                   margin: EdgeInsets.only(left: 7),
      //                                   child: Icon(Icons.sync, color: Colors.blue),
      //                                 ),
      //                                 Text('100'),
      //                                 // クリップボタン
      //                                 Container(
      //                                   margin: EdgeInsets.only(left: 20, bottom: 4),
      //                                   child: ElevatedButton(
      //                                     //クリップボタン
      //                                     child: Icon(
      //                                       Icons.assignment_turned_in,
      //                                     ),
      //                                     style: ElevatedButton.styleFrom(
      //                                       padding: EdgeInsets.all(12),
      //                                       primary: HexColor('EC9361'),
      //                                       onPrimary: Colors.white,
      //                                       shape: CircleBorder(
      //                                         side: BorderSide(
      //                                           color: Colors.transparent,
      //                                           width: 1,
      //                                           style: BorderStyle.solid,
      //                                         ),
      //                                       ),
      //                                     ),
      //                                     onPressed: () {},
      //                                   ),
      //                                 ),
      //                               ],
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //         ],
      //       ),
      //     ),
      //   ], // Row2個目
      // ),
    ];

    List<Widget> newreviewSliders = [
      newreviewcarousel(media_width, media_height, review, 0),
      newreviewcarousel(media_width, media_height, review, 1),
      newreviewcarousel(media_width, media_height, review, 2),
    ];

    return Scaffold(
        appBar: Header(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: media_width * 0.995,
                          height: media_height * 0.35,
                          child: Image.asset(
                            'images/headerwoman.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // ランキングボタン
                          Container(
                            width: 140,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "ランキング",
                                style: TextStyle(
                                  color: HexColor('ec9361'),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: HexColor('ffffff'), //ボタンの背景色
                                side: BorderSide(
                                  color: HexColor('ec9361'), //枠線
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                          // カテゴリボタン
                          Container(
                            width: 140,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "カテゴリ",
                                style: TextStyle(
                                  color: HexColor('ec9361'),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: HexColor('ffffff'), //ボタンの背景色
                                side: BorderSide(
                                  color: HexColor('ec9361'), //枠線
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                          // メーカー
                          Container(
                            width: 140,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "メーカー",
                                style: TextStyle(
                                  color: HexColor('ec9361'),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: HexColor('ffffff'), //ボタンの背景色
                                side: BorderSide(
                                  color: HexColor('ec9361'), //枠線
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                          // ブランド
                          Container(
                            width: 140,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BrandListPage(),
                                    ));
                              },
                              child: Text(
                                "ブランド",
                                style: TextStyle(
                                  color: HexColor('ec9361'),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: HexColor('ffffff'), //ボタンの背景色
                                side: BorderSide(
                                  color: HexColor('ec9361'), //枠線
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // メイン部分
                    Container(
                        margin: EdgeInsets.only(top: 40),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 左側
                            Container(
                              margin: EdgeInsets.only(left: 40),
                              width: media_width * 0.6,
                              //color: HexColor('fdf5e6'),
                              child: Column(
                                children: [
                                  // アイコン + ランキング
                                  GestureDetector(
                                    onTap: () {
                                      // ランキング一覧に変える
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NewItemPage(),
                                          ));
                                    },
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            child: Image.asset(
                                              'images/podium.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SelectableText(
                                            'ランキング',
                                            style: TextStyle(
                                              color: HexColor('ec9361'),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            scrollPhysics: NeverScrollableScrollPhysics(),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => NewItemPage(),
                                                  ));
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // ランキングコンテナ
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: media_width * 0.6,
                                    height: media_height * 0.75,
                                    color: HexColor('F5F3EF'),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // 前のスライドに移動、 duration...スライド速度  curve...アニメーションの設定
                                            buttonCarouselController.previousPage(duration: Duration(milliseconds: 400), curve: Curves.linear);
                                          },
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                          ),
                                          //カルーセル
                                        ),
                                        Container(
                                          width: media_width * 0.54,
                                          height: media_height * 0.75,
                                          child: CarouselSlider(
                                            items: rankingSliders, // スライドさせるリスト
                                            carouselController: buttonCarouselController, // ボタンでスライドするためのコントローラー
                                            options: CarouselOptions(
                                              autoPlay: false, // 自動スライド オフ
                                              enlargeCenterPage: false, // 画像切り替えの時に中心の画像拡大、他縮小させるか
                                              viewportFraction: 1.0, // 各ページが占めるビューポートの割合
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // 次のスライドへ
                                            buttonCarouselController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.linear);
                                          },
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ), // ランキング終わり

                                  // トレンドのタグ
                                  GestureDetector(
                                    onTap: () {
                                      // タグに変える
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NewItemPage(),
                                          ));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            child: Image.asset(
                                              'images/trend.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SelectableText(
                                            'トレンドのタグ',
                                            style: TextStyle(
                                              color: HexColor('ec9361'),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            scrollPhysics: NeverScrollableScrollPhysics(),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => NewItemPage(),
                                                  ));
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // トレンドのタグコンテナ
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: media_width * 0.6,
                                    height: media_height * 0.4,
                                    color: HexColor('F5F3EF'),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        for (var i = 0; i < 3; i++)
                                          Card(
                                            margin: EdgeInsets.symmetric(horizontal: 8),
                                            child: Container(
                                              width: media_width * 0.18,
                                              height: media_height * 0.37,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Container(
                                                    //margin: EdgeInsets.only(top: 5),
                                                    height: media_height * 0.1,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          width: media_width * 0.04,
                                                          height: media_height * 0.06,
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.black),
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              '#',
                                                              style: TextStyle(
                                                                fontSize: 24,
                                                                fontWeight: FontWeight.w500,
                                                                color: HexColor('616161'),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          // ベースラインに揃えて配置
                                                          crossAxisAlignment: CrossAxisAlignment.baseline,

                                                          // ベースラインの指定
                                                          textBaseline: TextBaseline.alphabetic,
                                                          children: [
                                                            SelectableText(
                                                              tag[i]['Text'],
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                            SelectableText(
                                                              'つくれぽ ' + '255' + '投稿',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: HexColor('616161'),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    //margin: EdgeInsets.only(top: 20),
                                                    width: media_width * 0.15,
                                                    height: media_height * 0.17,
                                                    color: HexColor('fffafa'),
                                                    child: Image.network(
                                                      tag[i]['image'],
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ), // トレンドのタグ終わり

                                  // 人気ユーザー
                                  GestureDetector(
                                    onTap: () {
                                      // ユーザー一覧に変える
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NewItemPage(),
                                          ));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            child: Image.asset(
                                              'images/popular_user.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SelectableText(
                                            '人気のユーザー',
                                            style: TextStyle(
                                              color: HexColor('ec9361'),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            scrollPhysics: NeverScrollableScrollPhysics(),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => NewItemPage(),
                                                  ));
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // 人気ユーザーコンテナ
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: media_width * 0.6,
                                    height: media_height * 0.4,
                                    color: HexColor('F5F3EF'),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        for (var i = 0; i < 4; i++)
                                          Card(
                                            margin: EdgeInsets.symmetric(horizontal: 15),
                                            child: Container(
                                              width: media_width * 0.12,
                                              height: media_height * 0.34,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Container(
                                                    //margin: EdgeInsets.only(top: 10),
                                                    width: media_width * 0.15,
                                                    height: media_height * 0.15,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        fit: BoxFit.contain,
                                                        image: NetworkImage(
                                                          (user[i]['image'] == "")
                                                              ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf'
                                                              : user[i]['image'],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    //margin: EdgeInsets.only(top: 5),
                                                    child: SelectableText(user[i]['Text']),
                                                  ),
                                                  Container(
                                                    //margin: EdgeInsets.only(top: 20),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        style: TextStyle(color: HexColor('616161')),
                                                        children: [
                                                          WidgetSpan(
                                                            child: Padding(
                                                              padding: EdgeInsets.only(bottom: 5),
                                                              child: Icon(
                                                                Icons.favorite,
                                                                size: 12,
                                                              ),
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: '14623',
                                                          ),
                                                          WidgetSpan(
                                                            child: Padding(
                                                              padding: EdgeInsets.only(left: 15, bottom: 5),
                                                              child: Icon(
                                                                Icons.person,
                                                                size: 12,
                                                              ),
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: '14623',
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ), // 人気ユーザー終わり

                                  // 新着レビュー
                                  GestureDetector(
                                    onTap: () {
                                      // レビュー一覧に変える
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NewItemPage(),
                                          ));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          // レビューアイコン
                                          Container(
                                            width: 40,
                                            height: 40,
                                            child: Image.asset(
                                              'images/new_review.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SelectableText(
                                            '新着レビュー',
                                            style: TextStyle(
                                              color: HexColor('ec9361'),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            scrollPhysics: NeverScrollableScrollPhysics(),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => NewItemPage(),
                                                  ));
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // 新着レビューコンテナ
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: media_width * 0.6,
                                    height: media_height * 0.6,
                                    color: HexColor('F5F3EF'),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // 前のスライドに移動、 duration...スライド速度  curve...アニメーションの設定
                                            reviewbuttonCarouselController.previousPage(duration: Duration(milliseconds: 400), curve: Curves.linear);
                                          },
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                          ),
                                        ),
                                        Container(
                                          width: media_width * 0.52,
                                          height: media_height * 0.6,
                                          child: CarouselSlider(
                                            items: newreviewSliders, // スライドさせるリスト
                                            carouselController: reviewbuttonCarouselController, // ボタンでスライドするためのコントローラー
                                            options: CarouselOptions(
                                              autoPlay: true, // 自動スライド オン
                                              enlargeCenterPage: false, // 画像切り替えの時に中心の画像拡大、他縮小させるか
                                              viewportFraction: 0.48, // 各ページが占めるビューポートの割合
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // 前のスライドに移動、 duration...スライド速度  curve...アニメーションの設定
                                            reviewbuttonCarouselController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.linear);
                                          },
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: [
                                    //     for (var i = 0; i < 3; i++)
                                    //       Card(
                                    //         margin: EdgeInsets.symmetric(horizontal: 8),
                                    //         child: Container(
                                    //           //margin: EdgeInsets.only(left: 5),
                                    //           width: media_width * 0.18,
                                    //           height: media_height * 0.5,
                                    //           child: Column(
                                    //             // レイアウト追加　間隔均等配置
                                    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    //             // ベースラインに揃えて配置
                                    //             crossAxisAlignment: CrossAxisAlignment.baseline,

                                    //             // ベースラインの指定
                                    //             textBaseline: TextBaseline.alphabetic,
                                    //             children: [
                                    //               // 商品画面
                                    //               Center(
                                    //                 child: Container(
                                    //                   width: media_width * 0.16,
                                    //                   height: media_height * 0.24,
                                    //                   //color: HexColor('ff2222'), // 範囲確認用
                                    //                   child: Image.network(
                                    //                     review[i]['image'],
                                    //                     fit: BoxFit.contain,
                                    //                   ),
                                    //                 ),
                                    //               ),

                                    //               Container(
                                    //                 margin: EdgeInsets.only(left: 20),
                                    //                 height: media_height * 0.24,
                                    //                 child: Column(
                                    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                                    //                   children: [
                                    //                     // 投稿者
                                    //                     Container(
                                    //                       child: SelectableText(review[i]['name'] + '　' + review[i]['age'] + '・' + review[i]['gender']),
                                    //                     ),

                                    //                     // 商品名
                                    //                     Container(
                                    //                       child: SelectableText(review[i]['product'],
                                    //                           maxLines: 1,
                                    //                           style: TextStyle(
                                    //                             fontSize: 14,
                                    //                             fontWeight: FontWeight.w600,
                                    //                           )),
                                    //                     ),
                                    //                     // スターレーティング　用改良
                                    //                     Container(
                                    //                       child: star(review[i]['star'], 16),
                                    //                     ),
                                    //                     // レビュー本文
                                    //                     Container(
                                    //                       //height: media_height * 0.1,
                                    //                       width: media_width * 0.17,
                                    //                       child: SelectableText(
                                    //                         review[i]['Text'],
                                    //                         maxLines: 3,
                                    //                         scrollPhysics: NeverScrollableScrollPhysics(),
                                    //                       ),
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //   ],
                                    // ),
                                  ), // 新着レビュー終わり
                                ],
                              ),
                            ),
                            // 右側
                            Container(
                                margin: EdgeInsets.only(left: 40),
                                width: media_width * 0.3,
                                //height: 1400,
                                //color: HexColor('fdf5e6'),
                                child: Column(
                                  children: [
                                    //ユーザーアンケート
                                    GestureDetector(
                                      onTap: () {
                                        // ユーザーアンケート一覧に変える
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => NewItemPage(),
                                            ));
                                      },
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              child: Image.asset(
                                                'images/questionnaireicon.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SelectableText(
                                              'ユーザーアンケート',
                                              style: TextStyle(
                                                color: HexColor('ec9361'),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              scrollPhysics: NeverScrollableScrollPhysics(),
                                              onTap: () {
                                                // ユーザーアンケートに変える
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => NewItemPage(),
                                                    ));
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // コンテナ
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      width: media_width * 0.3,
                                      height: media_height * 0.6,
                                      color: HexColor('F5F3EF'),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            child: SelectableText(
                                              '食べるならどれ？',
                                              scrollPhysics: NeverScrollableScrollPhysics(),
                                              style: TextStyle(
                                                color: HexColor('616161'),
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: media_width * 0.20,
                                            height: media_height * 0.09,
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              child: SelectableText(
                                                "きのこの山",
                                                style: TextStyle(
                                                  color: HexColor('ec9361'),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                primary: HexColor('ffffff'), //ボタンの背景色
                                                side: BorderSide(
                                                  color: HexColor('ec9361'), //枠線
                                                  width: 1.5,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: media_width * 0.20,
                                            height: media_height * 0.09,
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              child: SelectableText(
                                                "たけのこの里",
                                                style: TextStyle(
                                                  color: HexColor('ec9361'),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                primary: HexColor('ffffff'), //ボタンの背景色
                                                side: BorderSide(
                                                  color: HexColor('ec9361'), //枠線
                                                  width: 1.5,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: media_width * 0.20,
                                            height: media_height * 0.09,
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              child: SelectableText(
                                                "カントリーマアム",
                                                style: TextStyle(
                                                  color: HexColor('ec9361'),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                primary: HexColor('ffffff'), //ボタンの背景色
                                                side: BorderSide(
                                                  color: HexColor('ec9361'), //枠線
                                                  width: 1.5,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: media_width * 0.20,
                                            height: media_height * 0.09,
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              child: SelectableText(
                                                "ルマンド",
                                                style: TextStyle(
                                                  color: HexColor('ec9361'),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                primary: HexColor('ffffff'), //ボタンの背景色
                                                side: BorderSide(
                                                  color: HexColor('ec9361'), //枠線
                                                  width: 1.5,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // 残り日数
                                          Container(
                                            // selectable + richtext
                                            child: SelectableText.rich(
                                              TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: '終了まであと ',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: '2日',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 22,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ), // ユーザーアンケート終わり

                                    // 広告
                                    // Container(
                                    //   margin: EdgeInsets.only(top: 20),
                                    //   width: media_width * 0.3,
                                    //   height: media_height * 0.6,
                                    //   color: HexColor('87cefa'),
                                    //   child: Center(child: Text('広告')),
                                    // ), // 広告終わり

                                    // 新商品
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => NewItemPage(),
                                            ));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              child: Image.asset(
                                                'images/new_goods.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SelectableText(
                                              '新商品',
                                              style: TextStyle(
                                                color: HexColor('ec9361'),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              scrollPhysics: NeverScrollableScrollPhysics(),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => NewItemPage(),
                                                    ));
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // 新商品コンテナ
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      width: media_width * 0.3,
                                      height: media_height * 0.7,
                                      color: HexColor('F5F3EF'),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          for (var i = 0; i < 3; i++)
                                            Card(
                                              child: Container(
                                                width: media_width * 0.28,
                                                height: media_height * 0.2,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(left: 3),
                                                      width: media_width * 0.1,
                                                      height: media_height * 0.16,
                                                      //color: Colors.red, //範囲確認用
                                                      child: Image.network(
                                                        new_item[i]['image'],
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(left: 10),
                                                      width: media_width * 0.115,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        // ベースラインに揃えて配置
                                                        crossAxisAlignment: CrossAxisAlignment.baseline,
                                                        // ベースラインの指定
                                                        textBaseline: TextBaseline.alphabetic,
                                                        children: [
                                                          SelectableText('発売日：' + new_item[i]['date']),
                                                          SelectableText(
                                                            new_item[i]['maker'],
                                                            maxLines: 1,
                                                          ),
                                                          SelectableText(
                                                            new_item[i]['Text'],
                                                            maxLines: 2,
                                                            scrollPhysics: NeverScrollableScrollPhysics(),
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // クリップボタン
                                                    Container(
                                                      margin: EdgeInsets.only(bottom: 10),
                                                      // 末尾に配置するためColumnを追加
                                                      child: Column(
                                                        // 末尾に配置
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          ElevatedButton(
                                                            //クリップボタン
                                                            child: Icon(
                                                              Icons.assignment_turned_in,
                                                            ),
                                                            style: ElevatedButton.styleFrom(
                                                              padding: EdgeInsets.all(12),
                                                              primary: HexColor('EC9361'),
                                                              onPrimary: Colors.white,
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
                                                  ],
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ), // 新商品終わり

                                    // 広告
                                    // Container(
                                    //   margin: EdgeInsets.only(top: 20),
                                    //   width: media_width * 0.30,
                                    //   height: media_height * 0.6,
                                    //   color: HexColor('87cefa'),
                                    //   child: Center(child: Text('広告')),
                                    // ), // 広告終わり
                                  ],
                                ))
                          ],
                        )),
                  ],
                ),
              ),
              /*Container(
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) =>
                                DetailsPage('0JEOwz9bBqm4p9HVuDz', 'TOP'),
                          ));
                    },
                  child: Text('詳細画面')),
            ),*/
              FooterCreate(),
            ],
          ),
        ),
        floatingActionButton: clipButton() //Comparison(),
        );
  }
}
