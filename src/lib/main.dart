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
        'Text': 'Red Bull 250ml',
        'image': 'https://img07.shop-pro.jp/PA01350/082/product/137945030.jpg',
        'date': '2021/09/16',
        'maker': 'レッドブル・ジャパン',
        'product_id': '',
      },
      {
        'Text': 'ガルボチョコパウチ 76g',
        'image': 'https://livedoor.blogimg.jp/plankman/imgs/b/f/bfa6566c.jpg',
        'date': '2021/08/30',
        'maker': '明治',
        'product_id': '',
      },
      {
        'Text': 'ウィルキンソン',
        'image':
            'https://m.media-amazon.com/images/I/61KZUmru1sL._AC_SL1500_.jpg',
        'date': '2021/09/16',
        'maker': 'アサヒ飲料',
        'product_id': '',
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
                              onPressed: () {},
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NewItemPage(),
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
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  NewItemPage(),
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
                                              onPressed: () {},
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
                                              onPressed: () {},
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
                                              onPressed: () {},
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
                                              onPressed: () {},
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
                                                                  ['image'],
                                                              new_item[i]
                                                                  ['image'])
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