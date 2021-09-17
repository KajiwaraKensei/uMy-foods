import 'dart:html';
import 'package:flutter/material.dart';
import 'package:umy_foods/comparison.dart';
import 'package:umy_foods/header.dart';
import 'package:umy_foods/footer.dart';
import 'package:umy_foods/details/details.dart';
import 'package:umy_foods/clipButton.dart';
import 'package:umy_foods/HexColor.dart';
import 'package:umy_foods/list_page/brand.dart';

void main() => runApp(MyApp());

String UserImage = "";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'uMyFoods',
        theme: ThemeData(primarySwatch: Colors.blue),
        debugShowCheckedModeBanner: false,
        home: Home());
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var media_width = MediaQuery.of(context).size.width;
    var media_height = MediaQuery.of(context).size.height;

    var testcategory = ['飲料水', '炭酸飲料', '炭酸水'];
    var test_ranknum = ['１', '２', '３'];

    final List<Map<String, dynamic>> ConcernRanking = [
      {
        'Text': 'きのこの山とたけのこの里 12袋',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1iSBzQche-bz05pN4oy14EFgCi7ha7a_xiw&usqp=CAU',
        'product_id': '0JEOwz9bBqm4p9HVuDz',
      },
      {
        'Text': 'ガルボチョコパウチ 76g',
        'image': 'https://livedoor.blogimg.jp/plankman/imgs/b/f/bfa6566c.jpg',
        'product_id': '3SofU80sVw4njBWKztW',
      },
      {
        'Text': '明治ホワイトチョコレート 40g',
        'image': 'https://livedoor.blogimg.jp/plankman/imgs/e/e/ee5945d2.jpg',
        'product_id': '3rRMgFVGkqIQGj2gCOC',
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
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1iSBzQche-bz05pN4oy14EFgCi7ha7a_xiw&usqp=CAU',
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
        'image':
            'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/anotherUser.png?alt=media&token=2dbc4946-c13b-4718-8fef-ba9e08c2e51f',
      },
      {
        'Text': 'ルーシー',
        'image':
            'http://petrichor.blue/wp-content/uploads/2018/11/46132564_570624860055194_808212540440969216_n.mp4_snapshot_00.34_2018.11.18_03.06.07-e1542478230568.jpg',
      },
      {
        'Text': 'John Doe',
        'image':
            'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/johnDoe.png?alt=media&token=07cbee0a-d3f0-45a7-8df7-fd03a6d5f980',
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
      {
        'Text': 'ガルボチョコパウチ 76g',
        'image': 'https://livedoor.blogimg.jp/plankman/imgs/b/f/bfa6566c.jpg',
        'date': '2021/08/30',
        'maker': '明治'
      },
      {
        'Text': 'ウィルキンソン',
        'image':
            'https://m.media-amazon.com/images/I/61KZUmru1sL._AC_SL1500_.jpg',
        'date': '2021/09/16',
        'maker': 'アサヒ飲料'
      },
    ];
    return Scaffold(
        appBar: Header(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Column(
                  children: [
                    Container(
                      width: media_width * 0.99,
                      height: media_height * 0.45,
                      child: Image.asset(
                        'images/headerwoman.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // ランキングボタン
                          Container(
                            width: 150,
                            height: 60,
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
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          scrollPhysics:
                                              NeverScrollableScrollPhysics(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // ランキングコンテナ
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: media_width * 0.6,
                                    height: media_height * 0.7,
                                    color: HexColor('F5F3EF'),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: media_width * 0.3,
                                          child: Column(
                                            children: [
                                              SelectableText(
                                                '気になるランキング',
                                                scrollPhysics:
                                                    NeverScrollableScrollPhysics(),
                                                style: TextStyle(
                                                  fontSize: 16.5,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              // ランキングのカテゴリ
                                              SelectableText(
                                                testcategory[0] +
                                                    '>' +
                                                    testcategory[1] +
                                                    '>' +
                                                    testcategory[2],
                                                scrollPhysics:
                                                    NeverScrollableScrollPhysics(),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: HexColor('616161'),
                                                ),
                                              ),
                                              // カード部分
                                              for (var i = 0;
                                                  i < 3;
                                                  i++) //ConcernRanking
                                                Card(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  child: new InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetailsPage(
                                                                    ConcernRanking[
                                                                            i][
                                                                        'product_id'],
                                                                    'TOP'),
                                                          ));
                                                    },
                                                    child: Container(
                                                      width: media_width * 0.28,
                                                      height:
                                                          media_height * 0.17,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    top: 5),
                                                            width: 28,
                                                            height: 35,
                                                            color: HexColor(
                                                                'FFDFC5'),
                                                            child: Center(
                                                              child: Text(
                                                                test_ranknum[i],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 25,
                                                                  color: HexColor(
                                                                      '616161'),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Center(
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 5),
                                                              width:
                                                                  media_width *
                                                                      0.1,
                                                              height:
                                                                  media_height *
                                                                      0.13,
                                                              child:
                                                                  Image.network(
                                                                (ConcernRanking[i]
                                                                            [
                                                                            'image'] ==
                                                                        "")
                                                                    ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf'
                                                                    : ConcernRanking[
                                                                            i][
                                                                        'image'],
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 5,
                                                                    left: 5),
                                                            child: Column(
                                                              // ベースラインに揃えて配置
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .baseline,

                                                              // ベースラインの指定
                                                              textBaseline:
                                                                  TextBaseline
                                                                      .alphabetic,
                                                              children: [
                                                                SelectableText(
                                                                  ConcernRanking[
                                                                          i]
                                                                      ['Text'],
                                                                  maxLines: 2,
                                                                  scrollPhysics:
                                                                      NeverScrollableScrollPhysics(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                // スターレーティング部分
                                                                Text(
                                                                  '★★★★★',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .yellow,
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .priority_high,
                                                                    ),
                                                                    Text('1'),
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              7),
                                                                      child: Icon(
                                                                          Icons
                                                                              .sync,
                                                                          color:
                                                                              Colors.blue),
                                                                    ),
                                                                    Text('100'),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: media_width * 0.3,
                                          child: Column(
                                            children: [
                                              SelectableText(
                                                'リピートランキング',
                                                scrollPhysics:
                                                    NeverScrollableScrollPhysics(),
                                                style: TextStyle(
                                                  fontSize: 16.5,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              // ランキングのカテゴリ
                                              SelectableText(
                                                testcategory[0] +
                                                    '>' +
                                                    testcategory[1] +
                                                    '>' +
                                                    testcategory[2],
                                                scrollPhysics:
                                                    NeverScrollableScrollPhysics(),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: HexColor('616161'),
                                                ),
                                              ),
                                              // リピートカード部分
                                              for (var i = 0; i < 3; i++)
                                                Card(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  child: new InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetailsPage(
                                                                    RepeatRanking[
                                                                            i][
                                                                        'product_id'],
                                                                    'TOP'),
                                                          ));
                                                    },
                                                    child: Container(
                                                      width: media_width * 0.28,
                                                      height:
                                                          media_height * 0.17,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    top: 5),
                                                            width: 28,
                                                            height: 35,
                                                            color: HexColor(
                                                                'FFDFC5'),
                                                            child: Center(
                                                              child: Text(
                                                                test_ranknum[i],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 25,
                                                                  color: HexColor(
                                                                      '616161'),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Center(
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 5),
                                                              width:
                                                                  media_width *
                                                                      0.1,
                                                              height:
                                                                  media_height *
                                                                      0.13,
                                                              child:
                                                                  Image.network(
                                                                (RepeatRanking[i]
                                                                            [
                                                                            'image'] ==
                                                                        "")
                                                                    ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf'
                                                                    : RepeatRanking[
                                                                            i][
                                                                        'image'],
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 5,
                                                                    left: 5),
                                                            child: Column(
                                                              // ベースラインに揃えて配置
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .baseline,

                                                              // ベースラインの指定
                                                              textBaseline:
                                                                  TextBaseline
                                                                      .alphabetic,
                                                              children: [
                                                                SelectableText(
                                                                  RepeatRanking[
                                                                          i]
                                                                      ['Text'],
                                                                  maxLines: 2,
                                                                  scrollPhysics:
                                                                      NeverScrollableScrollPhysics(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                // スターレーティング部分
                                                                Text(
                                                                  '★★★★★',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .yellow,
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .priority_high,
                                                                    ),
                                                                    Text('1'),
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              7),
                                                                      child: Icon(
                                                                          Icons
                                                                              .sync,
                                                                          color:
                                                                              Colors.blue),
                                                                    ),
                                                                    Text('100'),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ), // ランキング終わり

                                  // トレンドのタグ
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          scrollPhysics:
                                              NeverScrollableScrollPhysics(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // トレンドのタグコンテナ
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: media_width * 0.6,
                                    height: media_height * 0.4,
                                    color: HexColor('F5F3EF'),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        for (var i = 0; i < 3; i++)
                                          Card(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Container(
                                              width: media_width * 0.18,
                                              height: media_height * 0.37,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    height: media_height * 0.1,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: media_width *
                                                              0.04,
                                                          height: media_height *
                                                              0.06,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              '#',
                                                              style: TextStyle(
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: HexColor(
                                                                    '616161'),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          // ベースラインに揃えて配置
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .baseline,

                                                          // ベースラインの指定
                                                          textBaseline:
                                                              TextBaseline
                                                                  .alphabetic,
                                                          children: [
                                                            SelectableText(
                                                              '片手で食べれるお菓子',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            SelectableText(
                                                              'つくれぽ ' +
                                                                  '255' +
                                                                  '投稿',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: HexColor(
                                                                    '616161'),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 20),
                                                    width: media_width * 0.15,
                                                    height: media_height * 0.17,
                                                    color: HexColor('fffafa'),
                                                    child: Image.network(
                                                      'https://www.bourbon.co.jp/product_file/file/2151.jpg',
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
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          scrollPhysics:
                                              NeverScrollableScrollPhysics(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // 人気ユーザーコンテナ
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: media_width * 0.6,
                                    height: media_height * 0.4,
                                    color: HexColor('F5F3EF'),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        for (var i = 0; i < 4; i++)
                                          Card(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Container(
                                              width: media_width * 0.12,
                                              height: media_height * 0.34,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 10),
                                                    width: media_width * 0.15,
                                                    height: media_height * 0.15,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        fit: BoxFit.contain,
                                                        image: NetworkImage(
                                                          (user[i]['image'] ==
                                                                  "")
                                                              ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf'
                                                              : user[i]
                                                                  ['image'],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: SelectableText(
                                                        user[i]['Text']),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 20),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                '616161')),
                                                        children: [
                                                          WidgetSpan(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          5),
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
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 15,
                                                                      bottom:
                                                                          5),
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
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          scrollPhysics:
                                              NeverScrollableScrollPhysics(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // 新着レビューコンテナ
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: media_width * 0.6,
                                    height: media_height * 0.6,
                                    color: HexColor('F5F3EF'),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        for (var i = 0; i < 3; i++)
                                          Card(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Container(
                                              width: media_width * 0.18,
                                              height: media_height * 0.5,
                                              child: Column(
                                                // ベースラインに揃えて配置
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.baseline,

                                                // ベースラインの指定
                                                textBaseline:
                                                    TextBaseline.alphabetic,
                                                children: [
                                                  // 商品画面
                                                  Center(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      width: media_width * 0.16,
                                                      height:
                                                          media_height * 0.24,
                                                      //color: HexColor('ff2222'), // 範囲確認用
                                                      child: Image.network(
                                                        'https://cdn-ak.f.st-hatena.com/images/fotolife/d/drinkoon/20210125/20210125000127.jpg',
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Column(
                                                      // ベースラインに揃えて配置
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .baseline,
                                                      // ベースラインの指定
                                                      textBaseline: TextBaseline
                                                          .alphabetic,
                                                      children: [
                                                        // 投稿者
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 10),
                                                          child: SelectableText(
                                                              '高橋太郎' +
                                                                  '　' +
                                                                  '50代' +
                                                                  '・' +
                                                                  '男性'),
                                                        ),

                                                        // 商品名
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 7),
                                                          child: SelectableText(
                                                              '練乳いちごミルク',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              )),
                                                        ),
                                                        // スターレーティング　用改良
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 7),
                                                          child: SelectableText(
                                                              '総合評価：' +
                                                                  '★☆☆☆☆'),
                                                        ),
                                                        // レビュー本文
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 10),
                                                          child: SelectableText(
                                                            'この商品を詐欺罪で訴えます。理由は勿論、お分かりですね。あ…',
                                                            maxLines: 3,
                                                            scrollPhysics:
                                                                NeverScrollableScrollPhysics(),
                                                          ),
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
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            scrollPhysics:
                                                NeverScrollableScrollPhysics(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // コンテナ
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      width: media_width * 0.3,
                                      height: media_height * 0.6,
                                      color: HexColor('F5F3EF'),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            child: SelectableText(
                                              '食べるならどれ？',
                                              scrollPhysics:
                                                  NeverScrollableScrollPhysics(),
                                              style: TextStyle(
                                                color: HexColor('EC9361'),
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
                                                primary: HexColor(
                                                    'ffffff'), //ボタンの背景色
                                                side: BorderSide(
                                                  color:
                                                      HexColor('ec9361'), //枠線
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
                                                primary: HexColor(
                                                    'ffffff'), //ボタンの背景色
                                                side: BorderSide(
                                                  color:
                                                      HexColor('ec9361'), //枠線
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
                                                primary: HexColor(
                                                    'ffffff'), //ボタンの背景色
                                                side: BorderSide(
                                                  color:
                                                      HexColor('ec9361'), //枠線
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
                                                primary: HexColor(
                                                    'ffffff'), //ボタンの背景色
                                                side: BorderSide(
                                                  color:
                                                      HexColor('ec9361'), //枠線
                                                  width: 1.5,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // 残り日数　用改良
                                          Container(
                                            child:
                                                SelectableText('終了まであと' + '2日'),
                                          ),
                                        ],
                                      ),
                                    ), // ユーザーアンケート終わり

                                    // 広告
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      width: media_width * 0.3,
                                      height: media_height * 0.6,
                                      color: HexColor('87cefa'),
                                      child: Center(child: Text('広告')),
                                    ), // 広告終わり

                                    // 新商品
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            scrollPhysics:
                                                NeverScrollableScrollPhysics(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // 新商品コンテナ
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      width: media_width * 0.3,
                                      height: media_height * 0.6,
                                      color: HexColor('F5F3EF'),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          for (var i = 0; i < 3; i++)
                                            Card(
                                              child: Container(
                                                width: media_width * 0.28,
                                                height: media_height * 0.17,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 3),
                                                      width: media_width * 0.1,
                                                      height:
                                                          media_height * 0.16,
                                                      //color: Colors.red, //範囲確認用
                                                      child: Image.network(
                                                        new_item[i]['image'],
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        // ベースラインに揃えて配置
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .baseline,
                                                        // ベースラインの指定
                                                        textBaseline:
                                                            TextBaseline
                                                                .alphabetic,
                                                        children: [
                                                          SelectableText(
                                                              '発売日：' +
                                                                  new_item[i]
                                                                      ['date']),
                                                          SelectableText(
                                                              new_item[i]
                                                                  ['maker']),
                                                          SelectableText(
                                                            new_item[i]['Text'],
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
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
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      width: media_width * 0.30,
                                      height: media_height * 0.6,
                                      color: HexColor('87cefa'),
                                      child: Center(child: Text('広告')),
                                    ), // 広告終わり
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
