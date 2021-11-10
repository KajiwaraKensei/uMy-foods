import 'dart:html';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:umy_foods/clipAddButton.dart';
import 'package:umy_foods/comparison.dart';
import 'package:umy_foods/header.dart';
import 'package:umy_foods/footer.dart';
import 'package:umy_foods/details/details.dart';
import 'package:umy_foods/clipButton.dart';
import 'package:umy_foods/HexColor.dart';
import 'package:umy_foods/star.dart';
import 'package:umy_foods/list_page/brand.dart';
import 'package:umy_foods/new_item/newitem.dart';
import 'package:umy_foods/ranking/ranking.dart';
import 'package:umy_foods/carousel_list.dart';
import 'package:umy_foods/alert.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; //DB

import 'package:flutter_screenutil/flutter_screenutil.dart';//レスポンシブ
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui show window;


void main() async {
  // 初期化処理を追加
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

//String UID = "";
String UserImage = "";
String Id = 'LCIkEagsi1WjzcNHQLC3kjG6Cuw2'; //仮置き
String UID = ''; //FirebaseAuth.instance.currentUser.toString();

double screen_width=ScreenUtil.getInstance().screenWidth;
double screen_height=ScreenUtil.getInstance().screenHeight;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(screen_width, screen_height),
      builder: () => MaterialApp(
        title: 'uMyFoods',
        theme: ThemeData(primarySwatch: Colors.blue),
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(), // これを追加！
        home: Home())
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
    var rankicon = [
      'images/icon/first.png',
      'images/icon/second.png',
      'images/icon/third.png'
    ];

    CarouselController buttonCarouselController = CarouselController();
    CarouselController reviewbuttonCarouselController = CarouselController();

    final List<Map<String, dynamic>> ConcernRanking = [
      {
        'Text': 'きのこの山とたけのこの里 12袋',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1iSBzQche-bz05pN4oy14EFgCi7ha7a_xiw&usqp=CAU',
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
        'product_id': 'XAVe9QfDTkKDJoUHnNZ',
      },
      {
        'Text': 'きのこの山とたけのこの里 12袋',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1iSBzQche-bz05pN4oy14EFgCi7ha7a_xiw&usqp=CAU',
        'product_id': 'ZVHwc73pOtwxEaUZJHh',
      },
      {
        'Text': 'マーブル 32g',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/8/89/Meiji_Marble_Chocolate.jpg',
        'product_id': 'FeCbGMxsQd3OwE6dlQc',
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
        'Text': 'メルティーキッス くちどけブランデー＆オレンジピール',
        'image':
            'https://m.media-amazon.com/images/I/71nmdI2ZVuL._AC_SX679_PIbundle-10,TopRight,0,0_SH20_.jpg',
        'date': '2021/09/16',
        'maker': '明治',
        'product_id': 'RwBbBy9OWVy99lcWOcz',
      },
      {
        'Text': '明治ストロベリーチョコレートスティックパック',
        'image':
            'https://www.meiji.co.jp/products/chocolate/assets/img/04825.jpg',
        'date': '2021/08/30',
        'maker': '明治',
        'product_id': 'YoPNvXANuVslPJRNzcY',
      },
      {
        'Text': 'チョコレート効果 カカオ72％26枚入り',
        'image':
            'data:image/jpeg;base64,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',
        'date': '2021/09/16',
        'maker': '明治',
        'product_id': 'VYemANsOhBiAs0Mjctk',
      },
    ];
    final List<Map<String, dynamic>> review = [
      {
        'name': '田中実',
        'gender': '女性',
        'age': '20代',
        'product': 'ウィルキンソン',
        'star': 1,
        'Text': '思っていたより炭酸が強すぎて、炭酸が苦手でなくても飲みにくかった。',
        'image':
            'https://m.media-amazon.com/images/I/61KZUmru1sL._AC_SL1500_.jpg',
      },
      {
        'name': '高橋太郎',
        'gender': '男性',
        'age': '50代',
        'product': '練乳いちごミルク',
        'star': 1,
        'Text':
            'この商品を詐欺罪で訴えます。理由は勿論お分かりですね。あなたが皆をこんなパッケージで騙し、期待を破壊したからです！覚悟の準備をしておいてください。近いうちに訴えます。裁判も起こします。',
        'image':
            'https://cdn-ak.f.st-hatena.com/images/fotolife/d/drinkoon/20210125/20210125000127.jpg',
      },
      {
        'name': 'ハナ',
        'gender': '女性',
        'age': '40代',
        'product': 'きのこの山とたけのこの里 12袋',
        'star': 5,
        'Text':
            'たけこのきのこ戦争とは無意味だ。争いの果てになにが残る？争う必要はない。両方食べればいいのだ。なーんて言うと思ったかぁ！たけのこの里が一番に決まってんだろうがあああああ！！',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1iSBzQche-bz05pN4oy14EFgCi7ha7a_xiw&usqp=CAU',
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
    ];
    // List<Widget> newreviewSliders = [
    //   newreviewcarousel(media_width, media_height, review, 0),
    //   newreviewcarousel(media_width, media_height, review, 1),
    //   newreviewcarousel(media_width, media_height, review, 2),
    // ];

    return Scaffold(
        appBar: Header(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 30.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: media_width * 1.0,
                          height: media_height * 0.4,
                          child: Image.asset(
                            'images/headerwoman.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    // StreamBuilder(//ログイン確認用
                    //   stream: FirebaseAuth.instance.authStateChanges(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState ==
                    //         ConnectionState.waiting) {
                    //       return Center(child: CircularProgressIndicator());
                    //     }

                    //     if (snapshot.hasData) {
                    //       final user = FirebaseAuth.instance.currentUser;
                    //       final data = user?.uid;
                    //       if (data != null) {
                    //         return Text(data.toString());
                    //       } else
                    //         return Text('ログイン中');
                    //     }
                    //     return Text('');
                    //   },
                    // ),
                    Container(
                      margin: EdgeInsets.only(top: 20.h, right: 30.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // ランキングボタン
                          Container(
                            width: 140.w,
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RankingPage(),
                                    ));
                              },
                              child: Text(
                                "ランキング",
                                style: TextStyle(
                                  color: HexColor('ec9361'),
                                  fontSize: 16.sp,
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
                            width: 140.w,
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BetaAlert();
                                  },
                                );
                              },
                              child: Text(
                                "カテゴリ",
                                style: TextStyle(
                                  color: HexColor('ec9361'),
                                  fontSize: 16.sp,
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
                            width: 140.w,
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {});
                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BetaAlert();
                                  },
                                );
                              },
                              child: Text(
                                "メーカー",
                                style: TextStyle(
                                  color: HexColor('ec9361'),
                                  fontSize: 16.sp,
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
                          // 新商品ボタン
                          Container(
                            width: 140.w,
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewItemPage(),
                                    ));
                              },
                              child: Text(
                                "新商品",
                                style: TextStyle(
                                  color: HexColor('ec9361'),
                                  fontSize: 16.sp,
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
                        margin: EdgeInsets.only(top: 40.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 左側
                            Container(
                              margin: EdgeInsets.only(left: 40.w),
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
                                            builder: (context) => RankingPage(),
                                          ));
                                    },
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 40.w,
                                            height: 40.h,
                                            child: Image.asset(
                                              'images/podium.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SelectableText(
                                            'ランキング',
                                            style: TextStyle(
                                              color: HexColor('ec9361'),
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            scrollPhysics:
                                                NeverScrollableScrollPhysics(),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        RankingPage(),
                                                  ));
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // ランキングコンテナ
                                  Container(
                                    margin: EdgeInsets.only(top: 10.h),
                                    width: media_width * 0.6,
                                    height: media_height * 0.75,
                                    color: HexColor('F5F3EF'),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // 前のスライドに移動、 duration...スライド速度  curve...アニメーションの設定
                                            buttonCarouselController
                                                .previousPage(
                                                    duration: Duration(
                                                        milliseconds: 400),
                                                    curve: Curves.linear);
                                          },
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                            size:24.sp
                                          ),
                                          //カルーセル
                                        ),
                                        Container(
                                          width: media_width * 0.54,
                                          height: media_height * 0.75,
                                          child: CarouselSlider(
                                            items: rankingSliders, // スライドさせるリスト
                                            carouselController:
                                                buttonCarouselController, // ボタンでスライドするためのコントローラー
                                            options: CarouselOptions(
                                              autoPlay: false, // 自動スライド オフ
                                              enlargeCenterPage:
                                                  false, // 画像切り替えの時に中心の画像拡大、他縮小させるか
                                              viewportFraction:
                                                  1.0, // 各ページが占めるビューポートの割合
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // 次のスライドへ
                                            buttonCarouselController.nextPage(
                                                duration:
                                                    Duration(milliseconds: 400),
                                                curve: Curves.linear);
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
                                      showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return BetaAlert();
                                        },
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 40.w,
                                            height: 40.h,
                                            child: Image.asset(
                                              'images/trend.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SelectableText(
                                            'トレンドのタグ',
                                            style: TextStyle(
                                              color: HexColor('ec9361'),
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            scrollPhysics:
                                                NeverScrollableScrollPhysics(),
                                            onTap: () {
                                              showDialog<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return BetaAlert();
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // トレンドのタグコンテナ
                                  Container(
                                    margin: EdgeInsets.only(top: 10.h),
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
                                            child: new InkWell(
                                              onTap: () {
                                                showDialog<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return BetaAlert();
                                                  },
                                                );
                                              },
                                              child: Container(
                                              width: media_width * 0.18,
                                              height: media_height * 0.37,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    //margin: EdgeInsets.only(top: 5),
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
                                                                fontSize: 24.sp,
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
                                                              tag[i]['Text'],
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
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
                                                                fontSize: 12.sp,
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
                                          ),
                                      ],
                                    ),
                                  ), // トレンドのタグ終わり

                                  // 人気ユーザー
                                  GestureDetector(
                                    onTap: () {
                                      // ユーザー一覧に変える
                                      showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return BetaAlert();
                                        },
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 40.w,
                                            height: 40.h,
                                            child: Image.asset(
                                              'images/popular_user.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SelectableText(
                                            '人気のユーザー',
                                            style: TextStyle(
                                              color: HexColor('ec9361'),
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            scrollPhysics:
                                                NeverScrollableScrollPhysics(),
                                            onTap: () {
                                              showDialog<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return BetaAlert();
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // 人気ユーザーコンテナ
                                  Container(
                                    margin: EdgeInsets.only(top: 10.h),
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
                                                horizontal: 15.w),
                                            child: new InkWell(
                                              onTap: () {
                                                showDialog<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return BetaAlert();
                                                  },
                                                );
                                              },
                                              child: Container(
                                              width: media_width * 0.12,
                                              height: media_height * 0.34,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
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
                                                    //margin: EdgeInsets.only(top: 5),
                                                    child: SelectableText(
                                                        user[i]['Text'],style: TextStyle(fontSize: 14.sp)),
                                                  ),
                                                  Container(
                                                    //margin: EdgeInsets.only(top: 20),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
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
                                                                size: 12.sp,
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
                                                                      left: 15.w,
                                                                      bottom:
                                                                          5.h),
                                                              child: Icon(
                                                                Icons.person,
                                                                size: 12.sp,
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
                                          ),
                                      ],
                                    ),
                                  ), // 人気ユーザー終わり

                                  // 新着レビュー
                                  GestureDetector(
                                    onTap: () {
                                      // レビュー一覧に変える
                                      showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return BetaAlert();
                                        },
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // レビューアイコン
                                          Container(
                                            width: 40.w,
                                            height: 40.h,
                                            child: Image.asset(
                                              'images/new_review.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SelectableText(
                                            '新着レビュー',
                                            style: TextStyle(
                                              color: HexColor('ec9361'),
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            scrollPhysics:
                                                NeverScrollableScrollPhysics(),
                                            onTap: () {
                                              showDialog<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return BetaAlert();
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // 新着レビューコンテナ
                                  Container(
                                    margin: EdgeInsets.only(top: 10.h),
                                    width: media_width * 0.6,
                                    height: media_height * 0.6,
                                    color: HexColor('F5F3EF'),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // 前のスライドに移動、 duration...スライド速度  curve...アニメーションの設定
                                            reviewbuttonCarouselController
                                                .previousPage(
                                                    duration: Duration(
                                                        milliseconds: 400),
                                                    curve: Curves.linear);
                                          },
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                          ),
                                        ),
                                        Container(
                                          width: media_width * 0.52,
                                          height: media_height * 0.6,
                                          child: StreamBuilder<QuerySnapshot>(

                                              //表示したいFiresotreの保存先を指定
                                              stream: FirebaseFirestore.instance
                                                  .collection('review')
                                                  .orderBy('review_postdate',
                                                      descending: true)
                                                  .limit(3)
                                                  .snapshots(),

                                              //streamが更新されるたびに呼ばれる
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<QuerySnapshot>
                                                      snapshot) {
                                                //データが取れていない時の処理
                                                if (!snapshot.hasData)
                                                  return const Text(
                                                      'Loading...');
                                                final result =
                                                    snapshot.data!.docs;
                                                return CarouselSlider(
                                                  items: [
                                                    for (int i = 0; i < 3; i++)
                                                      newreviewcarousel(
                                                          media_width,
                                                          media_height,
                                                          result[i]),
                                                  ],
                                                  //newreviewSliders, // スライドさせるリスト
                                                  carouselController:
                                                      reviewbuttonCarouselController, // ボタンでスライドするためのコントローラー
                                                  options: CarouselOptions(
                                                    autoPlay: true, // 自動スライド オン
                                                    enlargeCenterPage:
                                                        false, // 画像切り替えの時に中心の画像拡大、他縮小させるか
                                                    viewportFraction:
                                                        0.48, // 各ページが占めるビューポートの割合
                                                  ),
                                                );
                                              }),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // 前のスライドに移動、 duration...スライド速度  curve...アニメーションの設定
                                            reviewbuttonCarouselController
                                                .nextPage(
                                                    duration: Duration(
                                                        milliseconds: 400),
                                                    curve: Curves.linear);
                                          },
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size:24.sp
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
                                    GestureDetector(
                                      onTap: () {
                                        // ユーザーアンケート一覧に変える
                                        showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return BetaAlert();
                                          },
                                        );
                                      },
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 40.w,
                                              height: 40.h,
                                              child: Image.asset(
                                                'images/questionnaireicon.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SelectableText(
                                              'ユーザーアンケート',
                                              style: TextStyle(
                                                color: HexColor('ec9361'),
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              scrollPhysics:
                                                  NeverScrollableScrollPhysics(),
                                              onTap: () {
                                                // ユーザーアンケートに変える
                                                showDialog<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return BetaAlert();
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // コンテナ
                                    Container(
                                      margin: EdgeInsets.only(top: 10.h),
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
                                                color: HexColor('616161'),
                                                fontSize: 24.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: media_width * 0.20,
                                            height: media_height * 0.09,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                showDialog<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return BetaAlert();
                                                  },
                                                );
                                              },
                                              child: SelectableText(
                                                "きのこの山",
                                                style: TextStyle(
                                                  color: HexColor('ec9361'),
                                                  fontSize: 16.sp,
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
                                              onPressed: () {
                                                showDialog<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return BetaAlert();
                                                  },
                                                );
                                              },
                                              child: SelectableText(
                                                "たけのこの里",
                                                style: TextStyle(
                                                  color: HexColor('ec9361'),
                                                  fontSize: 16.sp,
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
                                              onPressed: () {
                                                showDialog<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return BetaAlert();
                                                  },
                                                );
                                              },
                                              child: SelectableText(
                                                "カントリーマアム",
                                                style: TextStyle(
                                                  color: HexColor('ec9361'),
                                                  fontSize: 16.sp,
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
                                              onPressed: () {
                                                showDialog<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return BetaAlert();
                                                  },
                                                );
                                              },
                                              child: SelectableText(
                                                "ルマンド",
                                                style: TextStyle(
                                                  color: HexColor('ec9361'),
                                                  fontSize: 16.sp,
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
                                          // 残り日数
                                          Container(
                                            // selectable + richtext
                                            child: SelectableText.rich(
                                              TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: '終了まであと ',
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: '2日',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 22.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
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
                                              builder: (context) =>
                                                  NewItemPage(),
                                            ));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 40.w,
                                              height: 40.h,
                                              child: Image.asset(
                                                'images/new_goods.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SelectableText(
                                              '新商品',
                                              style: TextStyle(
                                                color: HexColor('ec9361'),
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              scrollPhysics:
                                                  NeverScrollableScrollPhysics(),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          NewItemPage(),
                                                    ));
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // 新商品コンテナ
                                    Container(
                                      margin: EdgeInsets.only(top: 10.h),
                                      width: media_width * 0.3,
                                      height: media_height * 0.7,
                                      color: HexColor('F5F3EF'),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          for (var i = 0; i < 3; i++)
                                            Card(
                                              child: new InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailsPage(
                                                                new_item[i][
                                                                    'product_id'],
                                                                'TOP'),
                                                      ));
                                                },
                                                child: Container(
                                                width: media_width * 0.28,
                                                height: media_height * 0.2,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 3.w),
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
                                                          left: 10.w),
                                                      width:
                                                          media_width * 0.115,
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
                                                                      ['date'],
                                                            style: TextStyle(fontSize: 14.sp)
                                                          ),
                                                          SelectableText(
                                                            new_item[i]
                                                                ['maker'],
                                                            style: TextStyle(fontSize: 14.sp),
                                                            maxLines: 1,
                                                          ),
                                                          SelectableText(
                                                            new_item[i]['Text'],
                                                            maxLines: 2,
                                                            scrollPhysics:
                                                                NeverScrollableScrollPhysics(),
                                                            style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // クリップボタン
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 10.h),
                                                      // 末尾に配置するためColumnを追加
                                                      child: Column(
                                                        // 末尾に配置
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          defaultClipAddButton(
                                                              new_item[i][
                                                                  'product_id'],
                                                              new_item[i]
                                                                  ['text'],
                                                              new_item[i]
                                                                  ['image'])
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
        floatingActionButton: clipButton('TOP') //Comparison(),
        );
  }
}

//マウスドラッグ許可
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch, // 通常のタッチ入力デバイス
        PointerDeviceKind.mouse, // これを追加！
      };
}

//以下起動時に画面サイズを取得
/**
 * @Author: Sky24n
 * @GitHub: https://github.com/Sky24n
 * @Email: sky24no@gmail.com
 * @Description: Screen Util.
 * @Date: 2018/9/8
 */

///默认设计稿尺寸（单位 dp or pt）
double _designW = 360.0;
double _designH = 640.0;
double _designD = 3.0;

/**
 * 配置设计稿尺寸（单位 dp or pt）
 * w 宽
 * h 高
 * density 像素密度
 */

/// 配置设计稿尺寸 屏幕 宽，高，密度。
/// Configuration design draft size  screen width, height, density.
void setDesignWHD(double? w, double? h, {double? density = 3.0}) {
  _designW = w ?? _designW;
  _designH = h ?? _designH;
  _designD = density ?? _designD;
}

/// Screen Util.
class ScreenUtil {
  double _screenWidth = 0.0;
  double _screenHeight = 0.0;
  double _screenDensity = 0.0;
  double _statusBarHeight = 0.0;
  double _bottomBarHeight = 0.0;
  double _appBarHeight = 0.0;
  MediaQueryData? _mediaQueryData;

  static final ScreenUtil _singleton = ScreenUtil();

  static ScreenUtil getInstance() {
    _singleton._init();
    return _singleton;
  }

  _init() {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    if (_mediaQueryData != mediaQuery) {
      _mediaQueryData = mediaQuery;
      _screenWidth = mediaQuery.size.width;
      _screenHeight = mediaQuery.size.height;
      _screenDensity = mediaQuery.devicePixelRatio;
      _statusBarHeight = mediaQuery.padding.top;
      _bottomBarHeight = mediaQuery.padding.bottom;
      _appBarHeight = kToolbarHeight;
    }
  }

  /// screen width
  /// 屏幕 宽
  double get screenWidth => _screenWidth;

  /// screen height
  /// 屏幕 高
  double get screenHeight => _screenHeight;

  /// appBar height
  /// appBar 高
  double get appBarHeight => _appBarHeight;

  /// screen density
  /// 屏幕 像素密度
  double get screenDensity => _screenDensity;

  /// status bar Height
  /// 状态栏高度
  double get statusBarHeight => _statusBarHeight;

  /// bottom bar Height
  double get bottomBarHeight => _bottomBarHeight;

  /// media Query Data
  MediaQueryData? get mediaQueryData => _mediaQueryData;

  /// screen width
  /// 当前屏幕 宽
  static double getScreenW(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.width;
  }

  /// screen height
  /// 当前屏幕 高
  static double getScreenH(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.height;
  }

  /// screen density
  /// 当前屏幕 像素密度
  static double getScreenDensity(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.devicePixelRatio;
  }

  /// status bar Height
  /// 当前状态栏高度
  static double getStatusBarH(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.padding.top;
  }

  /// status bar Height
  /// 当前BottomBar高度
  static double getBottomBarH(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.padding.bottom;
  }

  /// 当前MediaQueryData
  static MediaQueryData getMediaQueryData(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery;
  }

  /// 仅支持纵屏。
  /// returns the size after adaptation according to the screen width.(unit dp or pt)
  /// 返回根据屏幕宽适配后尺寸（单位 dp or pt）
  /// size 单位 dp or pt
  static double getScaleW(BuildContext context, double size) {
    if (getScreenW(context) == 0.0) return size;
    return size * getScreenW(context) / _designW;
  }

  /// 仅支持纵屏。
  /// returns the size after adaptation according to the screen height.(unit dp or pt)
  /// 返回根据屏幕高适配后尺寸 （单位 dp or pt）
  /// size unit dp or pt
  static double getScaleH(BuildContext context, double size) {
    if (getScreenH(context) == 0.0) return size;
    return size * getScreenH(context) / _designH;
  }

  /// 仅支持纵屏。
  /// returns the font size after adaptation according to the screen density.
  /// 返回根据屏幕宽适配后字体尺寸
  /// fontSize 字体尺寸
  static double getScaleSp(BuildContext context, double fontSize) {
    if (getScreenW(context) == 0.0) return fontSize;
    return fontSize * getScreenW(context) / _designW;
  }

  /// Orientation
  /// 设备方向(portrait, landscape)
  static Orientation getOrientation(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.orientation;
  }

  /// 仅支持纵屏。
  /// returns the size after adaptation according to the screen width.(unit dp or pt)
  /// 返回根据屏幕宽适配后尺寸（单位 dp or pt）
  /// size 单位 dp or pt
  double getWidth(double size) {
    return _screenWidth == 0.0 ? size : (size * _screenWidth / _designW);
  }

  /// 仅支持纵屏。
  /// returns the size after adaptation according to the screen height.(unit dp or pt)
  /// 返回根据屏幕高适配后尺寸（单位 dp or pt）
  /// size unit dp or pt
  double getHeight(double size) {
    return _screenHeight == 0.0 ? size : (size * _screenHeight / _designH);
  }

  /// 仅支持纵屏
  /// returns the size after adaptation according to the screen width.(unit dp or pt)
  /// 返回根据屏幕宽适配后尺寸（单位 dp or pt）
  /// sizePx unit px
  double getWidthPx(double sizePx) {
    return _screenWidth == 0.0
        ? (sizePx / _designD)
        : (sizePx * _screenWidth / (_designW * _designD));
  }

  /// 仅支持纵屏。
  /// returns the size after adaptation according to the screen height.(unit dp or pt)
  /// 返回根据屏幕高适配后尺寸（单位 dp or pt）
  /// sizePx unit px
  double getHeightPx(double sizePx) {
    return _screenHeight == 0.0
        ? (sizePx / _designD)
        : (sizePx * _screenHeight / (_designH * _designD));
  }

  /// 仅支持纵屏。
  /// returns the font size after adaptation according to the screen density.
  /// 返回根据屏幕宽适配后字体尺寸
  /// fontSize 字体尺寸
  double getSp(double fontSize) {
    if (_screenDensity == 0.0) return fontSize;
    return fontSize * _screenWidth / _designW;
  }

  /// 兼容横/纵屏。
  /// 获取适配后的尺寸，兼容横/纵屏切换，可用于宽，高，字体尺寸适配。
  /// Get the appropriate size, compatible with horizontal/vertical screen switching, can be used for wide, high, font size adaptation.
  double getAdapterSize(double dp) {
    if (_screenWidth == 0 || _screenHeight == 0) return dp;
    return getRatio() * dp;
  }

  /// 适配比率。
  /// Ratio.
  double getRatio() {
    return (_screenWidth > _screenHeight ? _screenHeight : _screenWidth) /
        _designW;
  }

  /// 兼容横/纵屏。
  /// 获取适配后的尺寸，兼容横/纵屏切换，适应宽，高，字体尺寸。
  /// Get the appropriate size, compatible with horizontal/vertical screen switching, can be used for wide, high, font size adaptation.
  static double getAdapterSizeCtx(BuildContext context, double dp) {
    Size size = MediaQuery.of(context).size;
    if (size == Size.zero) return dp;
    return getRatioCtx(context) * dp;
  }

  /// 适配比率。
  /// Ratio.
  static double getRatioCtx(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return (size.width > size.height ? size.height : size.width) / _designW;
  }
}