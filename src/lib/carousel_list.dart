import 'package:flutter/material.dart';
import 'package:umy_foods/details/details.dart';
import 'package:umy_foods/clipButton.dart';
import 'package:umy_foods/star.dart';
import 'package:umy_foods/HexColor.dart';
import 'package:umy_foods/main.dart';
import 'package:umy_foods/login/login.dart';
import 'package:umy_foods/login/signup.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; //DB

rankingcarousel(
  var context,
  var mwidth,
  var mheight,
  var rankicon,
  String rankingtitle1,
  List<Map<String, dynamic>> Rankinglist1,
  List<String> category1,
  String rankingtitle2,
  List<Map<String, dynamic>> Rankinglist2,
  List<String> category2,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: mwidth * 0.26,
        child: Column(
          children: [
            SelectableText(
              rankingtitle1 + 'ランキング',
              scrollPhysics: NeverScrollableScrollPhysics(),
              style: TextStyle(
                fontSize: 16.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            // ランキングのカテゴリ
            SelectableText(
              category1[0] + '>' + category1[1] + '>' + category1[2],
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
                child: new InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsPage(Rankinglist1[i]['product_id'], 'TOP'),
                        ));
                  },
                  child: Container(
                    width: mwidth * 0.245,
                    height: mheight * 0.185,
                    child: Row(
                      // レイアウト追加　間隔均等配置
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            // 画像
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(left: 1),
                                width: mwidth * 0.1,
                                height: mheight * 0.13,
                                child: Image.network(
                                  (Rankinglist1[i]['image'] == "")
                                      ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf'
                                      : Rankinglist1[i]['image'],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            // ランキング順位
                            Container(
                              margin: EdgeInsets.only(top: 5, left: 15),
                              width: mwidth * 0.03,
                              height: mheight * 0.06,
                              child: Center(
                                child: Image.asset(
                                  rankicon[i],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // 商品名等
                        Container(
                          width: mwidth * 0.14,
                          margin: EdgeInsets.only(top: 5, left: 5),
                          child: Column(
                            // レイアウト追加 間隔均等配置
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // ベースラインに揃えて配置
                            crossAxisAlignment: CrossAxisAlignment.baseline,

                            // ベースラインの指定
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              SelectableText(
                                Rankinglist1[i]['Text'],
                                maxLines: 2,
                                scrollPhysics: NeverScrollableScrollPhysics(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // スターレーティング部分
                              star(5, 20),
                              // きになるリピートアイコン
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
                                  // クリップボタン
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 20, bottom: 4),
                                    child: StreamBuilder(
                                        stream: FirebaseAuth.instance
                                            .authStateChanges(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }

                                          if (snapshot.hasData) {
                                            final user = FirebaseAuth
                                                .instance.currentUser;
                                            final data = user?.uid;
                                            if (data != null) {
                                              String uid = data.toString();
                                              return ElevatedButton(
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
                                                onPressed: () async {
                                                  FirebaseFirestore.instance
                                                      .collection("/account/" +
                                                          uid +
                                                          "/clip_list")
                                                      .doc(Rankinglist1[i]
                                                          ['product_id'])
                                                      .set({
                                                    'product_name':
                                                        Rankinglist1[i]['Text'],
                                                    'image_url': Rankinglist1[i]
                                                        ['image'],
                                                    'product_id':
                                                        Rankinglist1[i]
                                                            ['product_id'],
                                                  });
                                                },
                                              );
                                            }
                                          }
                                          return ElevatedButton(
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
                                              onPressed: () async {
                                                final snapshot = FirebaseAuth
                                                    .instance.currentUser;
                                                if (snapshot == null) {
                                                  return showDialog<void>(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        content: Text(
                                                            'このサービスをご利用になるにはアカウントの登録、ログインが必要です。'),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            child: Text('戻る'),
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(),
                                                          ),
                                                          FlatButton(
                                                            child: Text('新規登録'),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Signup(),
                                                                  ));
                                                            },
                                                          ),
                                                          FlatButton(
                                                            child:
                                                                Text('ログイン画面へ'),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Login(),
                                                                  ));
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }
                                              });
                                        }),
                                  ),
                                ],
                              ),
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
        width: mwidth * 0.26,
        child: Column(
          children: [
            SelectableText(
              rankingtitle2 + 'ランキング',
              scrollPhysics: NeverScrollableScrollPhysics(),
              style: TextStyle(
                fontSize: 16.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            // ランキングのカテゴリ
            SelectableText(
              category2[0] + '>' + category2[1] + '>' + category2[2],
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
                child: new InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsPage(Rankinglist2[i]['product_id'], 'TOP'),
                        ));
                  },
                  child: Container(
                    width: mwidth * 0.245,
                    height: mheight * 0.185,
                    child: Row(
                      // レイアウト追加　間隔均等配置
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(left: 1),
                                width: mwidth * 0.1,
                                height: mheight * 0.13,
                                child: Image.network(
                                  (Rankinglist2[i]['image'] == "")
                                      ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf'
                                      : Rankinglist2[i]['image'],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, left: 15),
                              width: mwidth * 0.03,
                              height: mheight * 0.06,
                              child: Center(
                                child: Image.asset(
                                  rankicon[i],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: mwidth * 0.14,
                          margin: EdgeInsets.only(top: 5, left: 5),
                          child: Column(
                            // レイアウト追加 間隔均等配置
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // ベースラインに揃えて配置
                            crossAxisAlignment: CrossAxisAlignment.baseline,

                            // ベースラインの指定
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              SelectableText(
                                Rankinglist2[i]['Text'],
                                maxLines: 2,
                                scrollPhysics: NeverScrollableScrollPhysics(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // スターレーティング部分
                              star(5, 20),
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
                                  // クリップボタン
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 20, bottom: 4),
                                    child: StreamBuilder(
                                        stream: FirebaseAuth.instance
                                            .authStateChanges(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }

                                          if (snapshot.hasData) {
                                            final user = FirebaseAuth
                                                .instance.currentUser;
                                            final data = user?.uid;
                                            if (data != null) {
                                              String uid = data.toString();
                                              return ElevatedButton(
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
                                                onPressed: () async {
                                                  FirebaseFirestore.instance
                                                      .collection("/account/" +
                                                          uid +
                                                          "/clip_list")
                                                      .doc(Rankinglist2[i]
                                                          ['product_id'])
                                                      .set({
                                                    'product_name':
                                                        Rankinglist2[i]['Text'],
                                                    'image_url': Rankinglist2[i]
                                                        ['image'],
                                                    'product_id':
                                                        Rankinglist2[i]
                                                            ['product_id'],
                                                  });
                                                },
                                              );
                                            }
                                          }
                                          return ElevatedButton(
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
                                              onPressed: () async {
                                                final snapshot = FirebaseAuth
                                                    .instance.currentUser;
                                                if (snapshot == null) {
                                                  return showDialog<void>(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        content: Text(
                                                            'このサービスをご利用になるにはアカウントの登録、ログインが必要です。'),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            child: Text('戻る'),
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(),
                                                          ),
                                                          FlatButton(
                                                            child: Text('新規登録'),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Signup(),
                                                                  ));
                                                            },
                                                          ),
                                                          FlatButton(
                                                            child:
                                                                Text('ログイン画面へ'),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Login(),
                                                                  ));
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }
                                              });
                                        }),
                                  ),
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
  );
}

newreviewcarousel(
    var mwidth, var mheight, List<Map<String, dynamic>> review, int i) {
  return Container(
    child: Card(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        //margin: EdgeInsets.only(left: 5),
        width: mwidth * 0.18,
        height: mheight * 0.5,
        child: Column(
          // レイアウト追加　間隔均等配置
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // ベースラインに揃えて配置
          crossAxisAlignment: CrossAxisAlignment.baseline,

          // ベースラインの指定
          textBaseline: TextBaseline.alphabetic,
          children: [
            // 商品画面
            Center(
              child: Container(
                width: mwidth * 0.16,
                height: mheight * 0.24,
                //color: HexColor('ff2222'), // 範囲確認用
                child: Image.network(
                  review[i]['image'],
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 20),
              height: mheight * 0.24,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 投稿者
                  Container(
                    child: SelectableText(review[i]['name'] +
                        '　' +
                        review[i]['age'] +
                        '・' +
                        review[i]['gender']),
                  ),

                  // 商品名
                  Container(
                    child: SelectableText(review[i]['product'],
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  // スターレーティング　用改良
                  Container(
                    child: star(review[i]['star'], 16),
                  ),
                  // レビュー本文
                  Container(
                    //height: mheight * 0.1,
                    width: mwidth * 0.17,
                    child: SelectableText(
                      review[i]['Text'],
                      maxLines: 3,
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
  );
}
