import 'package:flutter/material.dart';

// パッケージ
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart'; //パンくず
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; //font_awesome

// 外部ファイル
import 'package:umy_foods/HexColor.dart'; //16進数カラーコード
import 'package:umy_foods/SpaceBox.dart'; //空間
import 'package:umy_foods/star.dart'; //星評価
import 'package:umy_foods/profile/profile_edit.dart'; //プロフィール編集
import 'package:umy_foods/header.dart';
import 'package:umy_foods/footer.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ProfilePage(),
//     );
//   }
// }

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String display = 'レビュー'; //レビュー・気になる商品の表示判定
  bool follow = false; //フォローボタン判定

  Widget build(BuildContext context) {
    var media_width = MediaQuery.of(context).size.width; //学校販売PCの場合1280
    var media_height = MediaQuery.of(context).size.height; //学校販売PCの場合609

    var maker_name = ['明治', '越後製菓', '日清', '花王', 'トップバリュー', '日本ハム']; //テスト用メーカー名

    return Scaffold(
        appBar: Header(),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: media_height * 0.032,
                  horizontal: media_width * 0.031),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BreadCrumb(
                        //パンくずリスト
                        items: <BreadCrumbItem>[
                          BreadCrumbItem(
                            content: TextButton(
                              onPressed: () {},
                              child: SelectableText(
                                'TOP',
                                style: TextStyle(color: Colors.black),
                                scrollPhysics: NeverScrollableScrollPhysics(),
                              ),
                            ),
                          ),
                          BreadCrumbItem(
                            content: TextButton(
                              onPressed: () {},
                              child: SelectableText(
                                'プロフィール',
                                style: TextStyle(color: Colors.black),
                                scrollPhysics: NeverScrollableScrollPhysics(),
                              ),
                            ),
                          ),
                        ],
                        divider: Icon(Icons.chevron_right),
                      ),
                      Row(
                        children: [
                          IconButton(
                            //設定ボタン
                            onPressed: () {},
                            icon: Icon(
                              Icons.settings_outlined,
                            ),
                            tooltip: '設定',
                          ),
                          IconButton(
                            //プロフィール編集ボタン
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfileEditPage()));
                              });
                            },
                            icon: Icon(
                              Icons.edit_outlined,
                            ),
                            tooltip: 'プロフィール編集',
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    //プロフィール
                    margin: EdgeInsets.symmetric(vertical: media_height * 0.05),
                    padding:
                        EdgeInsets.symmetric(horizontal: media_width * 0.02),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          //アイコン・フォローボタン
                          children: [
                            Container(
                                //アイコン
                                height: media_height * 0.2052,
                                width: media_width * 0.0976,
                                decoration: new BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://images-na.ssl-images-amazon.com/images/I/71qJYwkBWwL._SX402_.jpg')))),
                            SpaceBox.height(media_height * 0.08),
                            SizedBox(
                              //フォローボタン
                              width: media_width * 0.1,
                              height: media_height * 0.059,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: follow == true
                                      ? HexColor('EC9361')
                                      : Colors.white,
                                  side: BorderSide(color: HexColor('EC9361')),
                                ),
                                child: Text(
                                  follow == true ? 'フォロー中' : 'フォローする',
                                  style: TextStyle(
                                      color: follow == true
                                          ? Colors.white
                                          : HexColor('EC9361')),
                                ),
                                onPressed: () {
                                  setState(() {
                                    follow = !follow;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SpaceBox.width(media_width * 0.05125),
                        Column(
                          //プロフィール情報
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectableText('れもん',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                                scrollPhysics: NeverScrollableScrollPhysics()),
                            SelectableText('20代 / 女性 / 甘党 / 薄味 / 派量派',
                                scrollPhysics: NeverScrollableScrollPhysics()),
                            Row(
                              //ランキング
                              children: [
                                FaIcon(FontAwesomeIcons.crown,
                                    color: HexColor('FFDF4C')),
                                SelectableText('今日のランキング1680位　',
                                    style: TextStyle(color: HexColor('EC9361')),
                                    scrollPhysics:
                                        NeverScrollableScrollPhysics()),
                                FaIcon(FontAwesomeIcons.crown,
                                    color: HexColor('FFDF4C')),
                                SelectableText('週間ランキング1680位　',
                                    style: TextStyle(color: HexColor('EC9361')),
                                    scrollPhysics:
                                        NeverScrollableScrollPhysics()),
                                FaIcon(FontAwesomeIcons.crown,
                                    color: HexColor('FFDF4C')),
                                SelectableText('月間ランキング1680位　',
                                    style: TextStyle(color: HexColor('EC9361')),
                                    scrollPhysics:
                                        NeverScrollableScrollPhysics()),
                              ],
                            ),
                            SpaceBox.height(media_height * 0.017),
                            SelectableText.rich(TextSpan(//投稿・フォロワーなどの数値
                                children: [
                              TextSpan(
                                  text: '72',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(text: 'フォロー　|　'),
                              TextSpan(
                                  text: '1728',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(text: 'フォロワー　|　'),
                              TextSpan(
                                  text: '482',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(text: 'いいね　|　'),
                              TextSpan(
                                  text: '50',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(text: '投稿'),
                            ])),
                            SpaceBox.height(media_height * 0.017),
                            SelectableText(
                                //自己紹介（改行→https://qiita.com/gkn/items/f031bab66899e5886ce0 ）
                                '９歳の娘ちゃんと猫ちゃん♀と暮らしてます。\n旦那は海外単身赴任中。\nまんまるころころかわいいもの大好き。\nチョコ、モンブラン、おこちゃまおやつ大好き。\n流行りにとらわれず、自分の好きなもの、食べたいものを口コミしていきます。\nのんびりのんびり(=^ェ^=)',
                                scrollPhysics: NeverScrollableScrollPhysics()
                                // ,minLines: 9,maxLines: 9,
                                )
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(
                    //仕切り線
                    height: 10,
                    thickness: 5,
                    indent: 0,
                    endIndent: 0,
                    color: HexColor('EC9361').withOpacity(0.3),
                  ),
                  Container(
                      //表示選択
                      margin:
                          EdgeInsets.symmetric(vertical: media_height * 0.05),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                                //左側
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      right: media_width * 0.03),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              //レビューバー
                                              width: media_width * 0.32,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                bottom: BorderSide(
                                                  color: display != 'レビュー'
                                                      ? HexColor('EC9361')
                                                          .withOpacity(0.3)
                                                      : HexColor('EC9361'),
                                                  width: 3,
                                                ),
                                              )),
                                              child: TextButton(
                                                style: ButtonStyle(
                                                    overlayColor:
                                                        MaterialStateProperty
                                                            .all(HexColor(
                                                                    'FFDFC5')
                                                                .withOpacity(
                                                                    0.3))),
                                                child: Text('レビュー(45)',
                                                    style: TextStyle(
                                                        color: display != 'レビュー'
                                                            ? HexColor('EC9361')
                                                                .withOpacity(
                                                                    0.3)
                                                            : HexColor(
                                                                'EC9361'),
                                                        fontSize: 20)),
                                                onPressed: () {
                                                  setState(() {
                                                    display = 'レビュー';
                                                  });
                                                },
                                              )),
                                          Container(
                                              //気になる食品バー
                                              width: media_width * 0.32,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                bottom: BorderSide(
                                                  color: display != '食品'
                                                      ? HexColor('EC9361')
                                                          .withOpacity(0.3)
                                                      : HexColor('EC9361'),
                                                  width: 3,
                                                ),
                                              )),
                                              child: TextButton(
                                                style: ButtonStyle(
                                                    overlayColor:
                                                        MaterialStateProperty
                                                            .all(HexColor(
                                                                    'FFDFC5')
                                                                .withOpacity(
                                                                    0.3))),
                                                child: Text('気になる食品(15)',
                                                    style: TextStyle(
                                                        color: display != '食品'
                                                            ? HexColor('EC9361')
                                                                .withOpacity(
                                                                    0.3)
                                                            : HexColor(
                                                                'EC9361'),
                                                        fontSize: 20)),
                                                onPressed: () {
                                                  setState(() {
                                                    display = '食品';
                                                  });
                                                },
                                              )),
                                        ],
                                      ),
                                      Visibility(
                                          //レビューの場合のみ表示
                                          visible: display == 'レビュー',
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      media_height * 0.08),
                                              child: Column(children: [
                                                for (int x = 0; x < 3; x++)
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      for (int i = 0 + (x * 4);
                                                          i < 4 * (x + 1);
                                                          i++)
                                                        Container(
                                                            child: Row(
                                                          children: [
                                                            SpaceBox.width(23),
                                                            Card(
                                                              //商品カード
                                                              child: InkWell(
                                                                onTap: () {
                                                                  setState(
                                                                      () {}); //商品詳細ページへ
                                                                },
                                                                child: Container(
                                                                    width: media_width * 0.1359,
                                                                    height: media_height * 0.3578,
                                                                    child: Padding(
                                                                        padding: EdgeInsets.all(10),
                                                                        child: Column(
                                                                          children: [
                                                                            Container(
                                                                              //商品画像
                                                                              height: media_height * 0.164,
                                                                              width: media_width * 0.078125,
                                                                              child: Align(
                                                                                  alignment: Alignment.center,
                                                                                  child: Image.network(
                                                                                    'https://m.media-amazon.com/images/I/51ntmtYKayL._AC_.jpg',
                                                                                    fit: BoxFit.contain,
                                                                                  )),
                                                                            ),
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text('クッピーラムネ'), //商品名
                                                                                Row(
                                                                                  //星評価
                                                                                  children: [
                                                                                    Text(
                                                                                      '総合評価：',
                                                                                      style: TextStyle(fontSize: 12),
                                                                                    ),
                                                                                    star(3, 15),
                                                                                  ],
                                                                                ),
                                                                                SpaceBox.height(5),
                                                                                Text(
                                                                                  //レビュー内容
                                                                                  '298円で販売されていて、いつもとは違う味を食べたくて冒険してみた。シンプルにボイルして食べてみたら、中からトロ〜っとチーズが溶けていつものシャウエッセンのお肉のジューシーなコクのある塩気とチーズの濃厚な味が',
                                                                                  style: TextStyle(fontSize: 11),
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  maxLines: 3,
                                                                                )
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ))),
                                                              ),
                                                            ),
                                                          ],
                                                        ))
                                                    ],
                                                  ),
                                                SpaceBox.height(
                                                    media_height * 0.03),
                                                Row(
                                                  //ページング
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      //数字ボタン
                                                      width:
                                                          media_width * 0.027,
                                                      height:
                                                          media_height * 0.082,
                                                      child: ElevatedButton(
                                                        child: Center(
                                                          child: Text(
                                                            '1',
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: HexColor(
                                                              'EC9361'),
                                                          onPrimary:
                                                              Colors.white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        onPressed: () {},
                                                      ),
                                                    ),
                                                    TextButton(
                                                      //＞ボタン
                                                      child: const Text(
                                                        '>',
                                                        style: TextStyle(
                                                            fontSize: 40),
                                                      ),
                                                      style:
                                                          TextButton.styleFrom(
                                                        primary: Colors.black,
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  ],
                                                )
                                              ]))),
                                      Visibility(
                                        //食品の場合のみ表示
                                        visible: display == '食品',
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: media_height * 0.08),
                                            child: Column(
                                              children: [
                                                for (int x = 0; x < 3; x++)
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      for (int i = 0 + (x * 4);
                                                          i < 4 * (x + 1);
                                                          i++)
                                                        Container(
                                                            child: Row(
                                                          children: [
                                                            SpaceBox.width(23),
                                                            Card(
                                                              //商品カード
                                                              child: InkWell(
                                                                onTap: () {
                                                                  setState(
                                                                      () {}); //商品詳細ページへ
                                                                },
                                                                child:
                                                                    Container(
                                                                  child: Stack(
                                                                    children: [
                                                                      Padding(
                                                                          padding: EdgeInsets.all(
                                                                              10),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Container(
                                                                                //商品画像
                                                                                height: media_height * 0.164,
                                                                                width: media_width * 0.078125,
                                                                                child: Align(
                                                                                  alignment: Alignment.center,
                                                                                  child: Image.network('https://images-na.ssl-images-amazon.com/images/I/71tcgatTdML._AC_SL1500_.jpg'),
                                                                                ),
                                                                              ),
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text('グリコ'), //メーカー
                                                                                  Text('つぶつぶいちごポッキー'), //商品名
                                                                                  Row(
                                                                                    //星評価
                                                                                    children: [
                                                                                      star(3, 25),
                                                                                      Text('500', style: TextStyle(color: HexColor('EC9361'), fontSize: 12))
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    children: [
                                                                                      Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          RichText(
                                                                                              //気になる数
                                                                                              text: TextSpan(style: TextStyle(color: Colors.black), children: [
                                                                                            TextSpan(text: '1', style: TextStyle(fontWeight: FontWeight.w800, color: HexColor('EC9361'))),
                                                                                            TextSpan(text: '気になる')
                                                                                          ])),
                                                                                          RichText(
                                                                                              //リピート数
                                                                                              text: TextSpan(style: TextStyle(color: Colors.black), children: [
                                                                                            TextSpan(text: '100', style: TextStyle(fontWeight: FontWeight.w800, color: HexColor('EC9361'))),
                                                                                            TextSpan(text: 'リピート')
                                                                                          ]))
                                                                                        ],
                                                                                      ),
                                                                                      SpaceBox.width(10),
                                                                                      ElevatedButton(
                                                                                        //クリップボタン
                                                                                        child: Icon(
                                                                                          Icons.assignment_turned_in,
                                                                                        ),
                                                                                        style: ElevatedButton.styleFrom(
                                                                                          padding: EdgeInsets.all(15),
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
                                                                                  )
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ))
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ))
                                                    ],
                                                  ),
                                                SpaceBox.height(
                                                    media_height * 0.03),
                                                Row(
                                                  //ページング
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      //数字ボタン
                                                      width:
                                                          media_width * 0.027,
                                                      height:
                                                          media_height * 0.082,
                                                      child: ElevatedButton(
                                                        child: Center(
                                                          child: Text(
                                                            '1',
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: HexColor(
                                                              'EC9361'),
                                                          onPrimary:
                                                              Colors.white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        onPressed: () {},
                                                      ),
                                                    ),
                                                    TextButton(
                                                      //＞ボタン
                                                      child: const Text(
                                                        '>',
                                                        style: TextStyle(
                                                            fontSize: 40),
                                                      ),
                                                      style:
                                                          TextButton.styleFrom(
                                                        primary: Colors.black,
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                              //右側
                              flex: 1,
                              child: Container(
                                child: Column(
                                  //お気に入りのメーカー・新商品
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        child: Column(children: [
                                      Container(
                                        //お気に入りのメーカー
                                        width: media_width * 0.32,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                            color: HexColor('EC9361'),
                                            width: 3,
                                          ),
                                        )),
                                        child: Row(
                                          //お気に入りのメーカータイトル
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('お気に入りのメーカー',
                                                style: TextStyle(
                                                    color: HexColor('EC9361'),
                                                    fontSize: 20)),
                                            SizedBox(
                                              height: media_height * 0.0525,
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.edit_outlined,
                                                ),
                                                tooltip: 'お気に入りのメーカーを編集',
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      for (int x = 0;
                                          x < maker_name.length;
                                          x++) //メーカー名表示
                                        ListTile(
                                          leading: Icon(
                                              Icons.arrow_forward_ios_outlined),
                                          title: Text(maker_name[x]),
                                          onTap: () {},
                                        )
                                    ])),
                                    SpaceBox.height(40),
                                    Container(
                                      //新商品
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            //新商品タイトル
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: media_width * 0.027,
                                                  child: Image.asset(
                                                      'images/icon/newgoods.png'),
                                                ),
                                                SpaceBox.width(10),
                                                Text(
                                                  '新商品',
                                                  style: TextStyle(
                                                      color: HexColor('EC9361'),
                                                      fontSize: 20.0),
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              setState(() {}); //新商品ページへ
                                            },
                                          ),
                                          Container(
                                            //新商品
                                            color: HexColor('F5F3EF'),
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20,
                                                    horizontal: 15),
                                                child: Column(
                                                  children: [
                                                    for (int cnt = 0;
                                                        cnt < 3;
                                                        cnt++)
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5),
                                                        child: Card(
                                                            child: InkWell(
                                                                onTap: () {
                                                                  setState(
                                                                      () {}); //商品詳細ページへ
                                                                },
                                                                child:
                                                                    Container(
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            GestureDetector(
                                                                          child:
                                                                              Container(
                                                                            //商品画像
                                                                            padding:
                                                                                EdgeInsets.all(5),
                                                                            height:
                                                                                media_height * 0.1477,
                                                                            width:
                                                                                media_width * 0.07,
                                                                            child:
                                                                                Image.network('https://m.media-amazon.com/images/I/71WkOSqGsWS._AC_SL1500_.jpg'),
                                                                          ),
                                                                          onTap:
                                                                              () {
                                                                            setState(() {}); //商品詳細ページへ
                                                                          },
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Text('発売日' + '2020/10/03'), //発売日
                                                                              SpaceBox.height(10),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                      flex: 3,
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          GestureDetector(
                                                                                            child: Text(
                                                                                              'ポッカサッポロ',
                                                                                              style: TextStyle(color: HexColor('616161'), fontSize: 10),
                                                                                            ),
                                                                                            onTap: () {
                                                                                              setState(() {}); //メーカーページへ
                                                                                            },
                                                                                          ),
                                                                                          SpaceBox.height(10),
                                                                                          GestureDetector(
                                                                                            child: Text('LEMON MADE'),
                                                                                            onTap: () {
                                                                                              setState(() {}); //商品詳細ページへ
                                                                                            },
                                                                                          ),
                                                                                        ],
                                                                                      )),
                                                                                  Expanded(
                                                                                    flex: 2,
                                                                                    child: ElevatedButton(
                                                                                      //クリップボタン
                                                                                      child: Icon(Icons.assignment_turned_in, size: 25),
                                                                                      style: ElevatedButton.styleFrom(
                                                                                        padding: EdgeInsets.all(15),
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
                                                                                  )
                                                                                ],
                                                                              )
                                                                            ],
                                                                          )),
                                                                    ],
                                                                  ),
                                                                ))),
                                                      )
                                                  ],
                                                )),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
            //フッター
            FooterCreate(),
          ],
        ));
  }
}
