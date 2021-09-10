import 'package:flutter/material.dart';
import 'package:umy_foods/nextpage.dart';
import 'package:umy_foods/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterCreate extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      //フッター
      color: HexColor('F5F3EF'),
      child: Padding(
        padding: new EdgeInsets.all(10.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: 300,
            alignment: Alignment.center,
            child: Container(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                    width: 200,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ようこそ',
                            style: TextStyle(
                              fontSize: 25,
                              color: HexColor('8C6E63'),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WhatuMyFoods(),
                                    ));
                              },
                              child: Text('uMyFoodsとは'),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TermsOfService(),
                                    ));
                              },
                              child: Text('ご利用規約'),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PrivacyPolicy(),
                                    ));
                              },
                              child: Text('プライバシーポリシー'),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                              )),
                        ])),
                Container(
                    width: 200,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'サポート',
                            style: TextStyle(
                              fontSize: 25,
                              color: HexColor('8C6E63'),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FAQ(),
                                  ));
                            },
                            child: Text('よくある質問'),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Support(),
                                  ));
                            },
                            child: Text('サポート'),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                          ),
                        ])),
              ]),
            ),
          ),
          Container(
            width: 600,
            child: Column(children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      alignment: Alignment.center,
                      child: Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(
                              'コンテンツを見る',
                              style: TextStyle(
                                fontSize: 25,
                                color: HexColor('8C6E63'),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductRanking(),
                                    ));
                              },
                              child: Text('商品ランキングを見る'),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReviewRanking(),
                                    ));
                              },
                              child: Text('レビューランキングを見る'),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserRanking(),
                                    ));
                              },
                              child: Text('ユーザーランキングを見る'),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserQuestion(),
                                    ));
                              },
                              child: Text('ユーザーアンケートを見る'),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                              ),
                            ),
                          ])),
                    ),
                    Container(
                      width: 300,
                      alignment: Alignment.center,
                      child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '商品を探す',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: HexColor('8C6E63'),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SearchByCategory(),
                                      ));
                                },
                                child: Text('カテゴリーから探す'),
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SearchByMaker(),
                                      ));
                                },
                                child: Text('メーカーから探す'),
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SearchByNewProduct(),
                                      ));
                                },
                                child: Text('新商品から探す'),
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ]),
              Container(
                  height: 100,
                  child: ElevatedButton(
                      child: Image(
                        width: 100,
                        image: AssetImage('images/uMyFoods_icon.png'),
                        fit: BoxFit.contain,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: HexColor('F5F3EF'),
                        shape: const CircleBorder(),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyApp(),
                            ));
                      })),
            ]),
          ),
          Container(
            width: 300,
            alignment: Alignment.center,
            child: Container(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                    width: 200,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'レビューを見る',
                            style: TextStyle(
                              fontSize: 25,
                              color: HexColor('8C6E63'),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewPopularReviews(),
                                  ));
                            },
                            child: Text('人気のレビューを見る'),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewNewReviews(),
                                  ));
                            },
                            child: Text('新着のレビューを見る'),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                          ),
                        ])),
                Container(
                  height: 80,
                ),
                Container(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /*
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: HexColor('8C6E63'),
                          // アイコン部分
                          child: IconButton(
                              icon: Icon(Icons.email, color: Colors.white),
                              //tooltip: '',
                              // ボタンのデザイン
                              onPressed: () {}),
                        ),
                        */
                        Container(
                          height: 85,
                          alignment: Alignment.center,
                          child: Ink(
                            decoration: const ShapeDecoration(
                              color: Colors.lightBlue,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: FaIcon(FontAwesomeIcons.facebook,
                                  color: Colors.indigo, size: 40),
                              //tooltip: '',
                              // ボタンのデザイン
                              onPressed: () async {
                                if (await canLaunch(
                                    "https://www.facebook.com/UmyExe/")) {
                                  await launch(
                                      "https://www.facebook.com/UmyExe/");
                                }
                              },
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.blue,
                            // アイコン部分
                            child: IconButton(
                              //tooltip: 'Twitterへ',
                              icon: FaIcon(FontAwesomeIcons.twitter,
                                  color: Colors.white, size: 20),
                              onPressed: () async {
                                if (await canLaunch(
                                    "https://twitter.com/UmyExe")) {
                                  await launch("https://twitter.com/UmyExe");
                                }
                              },
                            ),
                          ),
                        ),
                      ]),
                ),
              ]),
            ),
          ),
        ]),
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
