import 'package:flutter/material.dart';
import 'package:umy_foods/nextpage.dart';
import 'package:umy_foods/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:umy_foods/HexColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';//レスポンシブ
import 'package:umy_foods/alert.dart';
import 'package:umy_foods/ranking/ranking.dart';

class FooterCreate extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      //フッター
      color: HexColor('F5F3EF'),
      child: Padding(
        padding: new EdgeInsets.all(10.0.sp),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround, //均等スペース
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(), //一番左を開ける
              Container(
                alignment: Alignment.center,
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(
                                'ようこそ',
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  color: HexColor('8C6E63'),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return BetaAlert();
                                      },
                                    );
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => WhatuMyFoods(),
                                    //     ));
                                  },
                                  child: Text('uMyFoodsとは',style: TextStyle(fontSize: 14.sp)),
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return BetaAlert();
                                      },
                                    );
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           TermsOfService(),
                                    //     ));
                                  },
                                  child: Text('ご利用規約',style: TextStyle(fontSize: 14.sp)),
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return BetaAlert();
                                      },
                                    );
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => PrivacyPolicy(),
                                    //     ));
                                  },
                                  child: Text('プライバシーポリシー',style: TextStyle(fontSize: 14.sp)),
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                  )),
                              Text(
                                '',
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  color: HexColor('8C6E63'),
                                ),
                              ),
                              Text(
                                'サポート',
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  color: HexColor('8C6E63'),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return BetaAlert();
                                    },
                                  );
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => FAQ(),
                                  //     ));
                                },
                                child: Text('よくある質問',style: TextStyle(fontSize: 14.sp)),
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return BetaAlert();
                                    },
                                  );
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => Support(),
                                  //     ));
                                },
                                child: Text('サポート',style: TextStyle(fontSize: 14.sp)),
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                ),
                              ),
                            ])),
                      ]),
                ),
              ),
              Container(), //ようこそ と コンテンツを見るの間をあける
              Container(
                child: Column(children: [
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text(
                                  'コンテンツを見る',
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    color: HexColor('8C6E63'),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return BetaAlert();
                                      },
                                    );
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           ProductRanking(),
                                    //     ));
                                  },
                                  child: Text('商品ランキングを見る',style: TextStyle(fontSize: 14.sp)),
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return BetaAlert();
                                      },
                                    );
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => ReviewRanking(),
                                    //     ));
                                  },
                                  child: Text('レビューランキングを見る',style: TextStyle(fontSize: 14.sp)),
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return BetaAlert();
                                      },
                                    );
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => UserRanking(),
                                    //     ));
                                  },
                                  child: Text('ユーザーランキングを見る',style: TextStyle(fontSize: 14.sp)),
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return BetaAlert();
                                      },
                                    );
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => UserQuestion(),
                                    //     ));
                                  },
                                  child: Text('ユーザーアンケートを見る',style: TextStyle(fontSize: 14.sp)),
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                  ),
                                ),
                              ])),
                        ),
                      ]),
                ]),
              ),
              Container(
                child: Column(children: [
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Container(
                              child: Column(children: [
                            Container(
                              height: 250.h,
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                        child: ElevatedButton(
                                            child: Image(
                                              width: 100.w,
                                              image: AssetImage(
                                                  'images/uMyFoods_icon.png'),
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
                                                    builder: (context) =>
                                                        MyApp(),
                                                  ));
                                            })),
                                  ]),
                            ),
                          ])),
                        ),
                      ]),
                ]),
              ),
              Container(
                alignment: Alignment.center,
                child: Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '商品を探す',
                          style: TextStyle(
                            fontSize: 25.sp,
                            color: HexColor('8C6E63'),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return BetaAlert();
                              },
                            );
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => SearchByCategory(),
                            //     ));
                          },
                          child: Text('カテゴリーから探す',style: TextStyle(fontSize: 14.sp)),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return BetaAlert();
                              },
                            );
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => SearchByMaker(),
                            //     ));
                          },
                          child: Text('メーカーから探す',style: TextStyle(fontSize: 14.sp)),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return BetaAlert();
                              },
                            );
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => SearchByNewProduct(),
                            //     ));
                          },
                          child: Text('新商品から探す',style: TextStyle(fontSize: 14.sp)),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                        ),
                      ]),
                ),
              ),
              Container(), //商品を探す と レビューを見るの間をあける
              Container(
                // width: 300,
                alignment: Alignment.center,
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(
                                'レビューを見る',
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  color: HexColor('8C6E63'),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return BetaAlert();
                                    },
                                  );
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           ViewPopularReviews(),
                                  //     ));
                                },
                                child: Text('人気のレビューを見る',style: TextStyle(fontSize: 14.sp)),
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return BetaAlert();
                                    },
                                  );
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => ViewNewReviews(),
                                  //     ));
                                },
                                child: Text('新着のレビューを見る',style: TextStyle(fontSize: 14.sp)),
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                ),
                              ),
                            ])),
                        Container(
                          height: 80.h,
                        ),
                        Container(
                          child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround, //均等スペース
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  height: 85.h,
                                  alignment: Alignment.center,
                                  child: Ink(
                                    decoration: const ShapeDecoration(
                                      color: Colors.lightBlue,
                                      shape: CircleBorder(),
                                    ),
                                    child: IconButton(
                                      icon: FaIcon(FontAwesomeIcons.facebook,
                                          color: Colors.indigo, size: 37.sp),
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
                                  height: 100.h,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: 10.w),
                                  child: CircleAvatar(
                                    radius: 20.sp,
                                    // backgroundColor: Colors.blue,
                                    // アイコン部分
                                    child: IconButton(
                                      //tooltip: 'Twitterへ',
                                      icon: FaIcon(FontAwesomeIcons.twitter,
                                          color: Colors.white, size: 20.sp),
                                      onPressed: () async {
                                        if (await canLaunch(
                                            "https://twitter.com/Umyfoods")) {
                                          await launch(
                                              "https://twitter.com/Umyfoods");
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 85.h,
                                  alignment: Alignment.center,
                                  child: Ink(
                                    decoration: const ShapeDecoration(
                                      color: Colors.lightBlue,
                                      shape: CircleBorder(),
                                    ),
                                    child: IconButton(
                                      icon: FaIcon(FontAwesomeIcons.instagram,
                                          color: Colors.orange, size: 37.sp),
                                      //tooltip: '',
                                      // ボタンのデザイン
                                      onPressed: () async {
                                        if (await canLaunch(
                                            "https://www.instagram.com/umy_foods/")) {
                                          await launch(
                                              "https://www.instagram.com/umy_foods/");
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                // Container(
                                //   height: 85,
                                //   alignment: Alignment.center,
                                //   child: Ink(
                                //     decoration: const ShapeDecoration(
                                //       color: Colors.lightBlue,
                                //       shape: CircleBorder(),
                                //     ),
                                //     child: IconButton(
                                //       icon: FaIcon(FontAwesomeIcons.line,
                                //           color: Colors.green, size: 40),
                                //       //tooltip: '',
                                //       // ボタンのデザイン
                                //       onPressed: () async {
                                //         if (await canLaunch(
                                //             "https://www.facebook.com/UmyExe/")) {
                                //           await launch(
                                //               "https://www.facebook.com/UmyExe/");
                                //         }
                                //       },
                                //     ),
                                //   ),
                                // ),
                              ]),
                        ),
                      ]),
                ),
              ),
              Container(), //一番左をあける
              Container(), //一番左をあける
              Container(), //一番左をあける
            ]),
      ),
    );
  }
}
