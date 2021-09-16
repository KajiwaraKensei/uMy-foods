import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class TopPage extends StatefulWidget {
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    var media_width = MediaQuery.of(context).size.width;
    var media_height = MediaQuery.of(context).size.height;

    var testcategory = ['飲料水', '炭酸飲料', '炭酸水'];
    var test_ranknum = ['１', '２', '３'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('F5F3EF'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: Column(
            children: [
              Container(
                width: media_width * 0.99,
                height: media_height * 0.5,
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
                        onPressed: () {},
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
                                        scrollPhysics: NeverScrollableScrollPhysics(),
                                        style: TextStyle(
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      // ランキングのカテゴリ
                                      SelectableText(
                                        testcategory[0] + '>' + testcategory[1] + '>' + testcategory[2],
                                        scrollPhysics: NeverScrollableScrollPhysics(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: HexColor('616161'),
                                        ),
                                      ),
                                      // カード部分
                                      for (var i = 0; i < 3; i++)
                                        Card(
                                          margin: EdgeInsets.symmetric(vertical: 10),
                                          child: Container(
                                            width: media_width * 0.28,
                                            height: media_height * 0.17,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(left: 10, top: 5),
                                                  width: 28,
                                                  height: 35,
                                                  color: HexColor('FFDFC5'),
                                                  child: Center(
                                                    child: Text(
                                                      test_ranknum[i],
                                                      style: TextStyle(
                                                        fontSize: 25,
                                                        color: HexColor('616161'),
                                                        fontWeight: FontWeight.w800,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    margin: EdgeInsets.only(left: 5),
                                                    width: media_width * 0.1,
                                                    height: media_height * 0.13,
                                                    child: Image.network(
                                                      'https://img1.esimg.jp/resize/240x180/image/product/00/00/14/56148.jpg?ts=1590373982130',
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(top: 5, left: 5),
                                                  child: Column(
                                                    // ベースラインに揃えて配置
                                                    crossAxisAlignment: CrossAxisAlignment.baseline,

                                                    // ベースラインの指定
                                                    textBaseline: TextBaseline.alphabetic,
                                                    children: [
                                                      SelectableText(
                                                        'ウィルキンソン',
                                                        maxLines: 2,
                                                        scrollPhysics: NeverScrollableScrollPhysics(),
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      // スターレーティング部分
                                                      Text(
                                                        '★★★★★',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.yellow,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.priority_high,
                                                          ),
                                                          Text('1'),
                                                          Container(
                                                            margin: EdgeInsets.only(left: 7),
                                                            child: Icon(Icons.sync, color: Colors.blue),
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
                                    ],
                                  ),
                                ),
                                Container(
                                  width: media_width * 0.3,
                                  child: Column(
                                    children: [
                                      SelectableText(
                                        'リピートランキング',
                                        scrollPhysics: NeverScrollableScrollPhysics(),
                                        style: TextStyle(
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      // ランキングのカテゴリ
                                      SelectableText(
                                        testcategory[0] + '>' + testcategory[1] + '>' + testcategory[2],
                                        scrollPhysics: NeverScrollableScrollPhysics(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: HexColor('616161'),
                                        ),
                                      ),
                                      // リピートカード部分
                                      for (var i = 0; i < 3; i++)
                                        Card(
                                          margin: EdgeInsets.symmetric(vertical: 10),
                                          child: Container(
                                            width: media_width * 0.28,
                                            height: media_height * 0.17,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(left: 10, top: 5),
                                                  width: 28,
                                                  height: 35,
                                                  color: HexColor('FFDFC5'),
                                                  child: Center(
                                                    child: Text(
                                                      test_ranknum[i],
                                                      style: TextStyle(
                                                        fontSize: 25,
                                                        color: HexColor('616161'),
                                                        fontWeight: FontWeight.w800,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    margin: EdgeInsets.only(left: 5),
                                                    width: media_width * 0.1,
                                                    height: media_height * 0.13,
                                                    child: Image.network(
                                                      'https://img1.esimg.jp/resize/240x180/image/product/00/00/14/56148.jpg?ts=1590373982130',
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(top: 5, left: 5),
                                                  child: Column(
                                                    // ベースラインに揃えて配置
                                                    crossAxisAlignment: CrossAxisAlignment.baseline,

                                                    // ベースラインの指定
                                                    textBaseline: TextBaseline.alphabetic,
                                                    children: [
                                                      SelectableText(
                                                        'ウィルキンソン',
                                                        maxLines: 2,
                                                        scrollPhysics: NeverScrollableScrollPhysics(),
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      // スターレーティング部分
                                                      Text(
                                                        '★★★★★',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.yellow,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.priority_high,
                                                          ),
                                                          Text('1'),
                                                          Container(
                                                            margin: EdgeInsets.only(left: 7),
                                                            child: Icon(Icons.sync, color: Colors.blue),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (var i = 0; i < 3; i++)
                                  Card(
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    child: Container(
                                      width: media_width * 0.18,
                                      height: media_height * 0.37,
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
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
                                                      '片手で食べれるお菓子',
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
                                            margin: EdgeInsets.only(top: 20),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (var i = 0; i < 4; i++)
                                  Card(
                                    margin: EdgeInsets.symmetric(horizontal: 15),
                                    child: Container(
                                      width: media_width * 0.12,
                                      height: media_height * 0.34,
                                      child: Column(
                                        children: [
                                          // ユーザー画像
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            width: media_width * 0.15,
                                            height: media_height * 0.15,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.contain,
                                                image: NetworkImage(
                                                    'http://petrichor.blue/wp-content/uploads/2018/11/46132564_570624860055194_808212540440969216_n.mp4_snapshot_00.34_2018.11.18_03.06.07-e1542478230568.jpg'),
                                              ),
                                            ),
                                          ),
                                          // ユーザー名
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: SelectableText('ルーシー'),
                                          ),
                                          // いいね・フォロワー数
                                          Container(
                                            margin: EdgeInsets.only(top: 20),
                                            child: RichText(
                                              text: TextSpan(
                                                style: TextStyle(color: HexColor('616161')),
                                                children: [
                                                  // いいねアイコン
                                                  WidgetSpan(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(bottom: 5),
                                                      child: Icon(
                                                        Icons.favorite,
                                                        size: 12,
                                                      ),
                                                    ),
                                                  ),
                                                  // いいね数
                                                  TextSpan(
                                                    text: '14623',
                                                  ),
                                                  // フォロワーアイコン
                                                  WidgetSpan(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(left: 15, bottom: 5),
                                                      child: Icon(
                                                        Icons.person,
                                                        size: 12,
                                                      ),
                                                    ),
                                                  ),
                                                  // フォロワー数
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (var i = 0; i < 3; i++)
                                  Card(
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    child: Container(
                                      width: media_width * 0.18,
                                      height: media_height * 0.5,
                                      child: Column(
                                        // ベースラインに揃えて配置
                                        crossAxisAlignment: CrossAxisAlignment.baseline,

                                        // ベースラインの指定
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          // 商品画面
                                          Center(
                                            child: Container(
                                              margin: EdgeInsets.only(top: 5),
                                              width: media_width * 0.16,
                                              height: media_height * 0.24,
                                              //color: HexColor('ff2222'), // 範囲確認用
                                              child: Image.network(
                                                'https://cdn-ak.f.st-hatena.com/images/fotolife/d/drinkoon/20210125/20210125000127.jpg',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Column(
                                              // ベースラインに揃えて配置
                                              crossAxisAlignment: CrossAxisAlignment.baseline,
                                              // ベースラインの指定
                                              textBaseline: TextBaseline.alphabetic,
                                              children: [
                                                // 投稿者
                                                Container(
                                                  margin: EdgeInsets.only(top: 10),
                                                  child: SelectableText('高橋太郎' + '　' + '50代' + '・' + '男性'),
                                                ),

                                                // 商品名
                                                Container(
                                                  margin: EdgeInsets.only(top: 7),
                                                  child: SelectableText('練乳いちごミルク',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                      )),
                                                ),
                                                // スターレーティング　用改良
                                                Container(
                                                  margin: EdgeInsets.only(top: 7),
                                                  child: SelectableText('総合評価：' + '★☆☆☆☆'),
                                                ),
                                                // レビュー本文
                                                Container(
                                                  margin: EdgeInsets.only(top: 10),
                                                  child: SelectableText(
                                                    'この商品を詐欺罪で訴えます。理由は勿論、お分かりですね。あ…',
                                                    maxLines: 2,
                                                    scrollPhysics: NeverScrollableScrollPhysics(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  child: SelectableText(
                                    '食べるならどれ？',
                                    scrollPhysics: NeverScrollableScrollPhysics(),
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
                                // 残り日数　用改良
                                Container(
                                  child: SelectableText('終了まであと' + '2日'),
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                for (var i = 0; i < 3; i++)
                                  Card(
                                    child: Container(
                                      width: media_width * 0.28,
                                      height: media_height * 0.17,
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 3),
                                            width: media_width * 0.1,
                                            height: media_height * 0.16,
                                            //color: Colors.red, //範囲確認用
                                            child: Image.network(
                                              'https://img07.shop-pro.jp/PA01350/082/product/137945030.jpg',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              // ベースラインに揃えて配置
                                              crossAxisAlignment: CrossAxisAlignment.baseline,
                                              // ベースラインの指定
                                              textBaseline: TextBaseline.alphabetic,
                                              children: [
                                                SelectableText('発売日：' + '2021/09/16'),
                                                SelectableText('サントリー'),
                                                SelectableText(
                                                  'Red Bull 250ml',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
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
                      ),
                    ),
                  ],
                ),
              ), // メイン部分終わり
            ],
          ),
        ),
      ),
    );
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
