import 'package:flutter/material.dart';
import 'package:umy_foods/clipAddButton.dart';
import 'package:umy_foods/details/details.dart';
import 'package:umy_foods/clipButton.dart';
import 'package:umy_foods/star.dart';
import 'package:umy_foods/HexColor.dart';
import 'package:umy_foods/main.dart';
import 'package:umy_foods/login/login.dart';
import 'package:umy_foods/login/signup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';//レスポンシブ

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
                fontSize: 16.5.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            // ランキングのカテゴリ
            SelectableText(
              category1[0] + '>' + category1[1] + '>' + category1[2],
              scrollPhysics: NeverScrollableScrollPhysics(),
              style: TextStyle(
                fontSize: 12.sp,
                color: HexColor('616161'),
              ),
            ),
            // カード部分
            for (var i = 0; i < 3; i++)
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.h),
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
                                margin: EdgeInsets.only(left: 1.w),
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
                              margin: EdgeInsets.only(top: 5.h, left: 15.w),
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
                          margin: EdgeInsets.only(top: 5.h, left: 5.w),
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
                                  fontSize: 14.sp,
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
                                    size:24.sp
                                  ),
                                  Text('1',style: TextStyle(fontSize: 14.sp)),
                                  Container(
                                    margin: EdgeInsets.only(left: 7.w),
                                    child: Icon(Icons.sync, color: Colors.blue,size:24.sp),
                                  ),
                                  Text('100',style: TextStyle(fontSize: 14.sp)),
                                  // クリップボタン
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 20.w, bottom: 4.h),
                                      child: defaultClipAddButton(
                                          Rankinglist1[i]['product_id'],
                                          Rankinglist1[i]['Text'],
                                          Rankinglist1[i]['image'])),
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
                fontSize: 16.5.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            // ランキングのカテゴリ
            SelectableText(
              category2[0] + '>' + category2[1] + '>' + category2[2],
              scrollPhysics: NeverScrollableScrollPhysics(),
              style: TextStyle(
                fontSize: 12.sp,
                color: HexColor('616161'),
              ),
            ),
            // リピートカード部分
            for (var i = 0; i < 3; i++)
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.h),
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
                                margin: EdgeInsets.only(left: 1.w),
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
                              margin: EdgeInsets.only(top: 5.h, left: 15.w),
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
                          margin: EdgeInsets.only(top: 5.h, left: 5.w),
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
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // スターレーティング部分
                              star(5, 20),
                              Row(children: [
                                Icon(
                                  Icons.priority_high,
                                  size:24.sp
                                ),
                                Text('1',style: TextStyle(fontSize: 14.sp)),
                                Container(
                                  margin: EdgeInsets.only(left: 7.w),
                                  child: Icon(Icons.sync, color: Colors.blue,size:24.sp),
                                ),
                                Text('100',style: TextStyle(fontSize: 14.sp)),
                                // クリップボタン
                                Container(
                                  margin: EdgeInsets.only(left: 20.w, bottom: 4.h),
                                  child: defaultClipAddButton(
                                      Rankinglist2[i]['product_id'],
                                      Rankinglist2[i]['Text'],
                                      Rankinglist2[i]['image']),
                                ),
                              ])
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

newreviewcarousel(var mwidth, var mheight, review) {
  //編集時ユーザー名、商品名も変更する。
  String age = '';
  final now = DateTime.now();

  final old = now.difference(review['user_birthday'].toDate()).inDays;

  if (old < 7300) {
    age = '～10代';
  } else if (old >= 7300 && old < 10950) {
    age = '20代';
  } else if (old >= 10950 && old < 14600) {
    age = '30代';
  } else {
    age = '40代～';
  }

  String gender = "";
  if (review['user_gender'] == "male") {
    gender = '男性';
  } else if (review['user_gender'] == 'female') {
    gender = '女性';
  } else {
    gender = '秘密';
  }
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
                child: (review['url'] == "")
                    ? Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf',
                        fit: BoxFit.contain,
                      )
                    : Image.network(
                        review['url'],
                        fit: BoxFit.contain,
                      ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 20.w),
              height: mheight * 0.24,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 投稿者
                  Container(
                    child: SelectableText(
                        review['user_name'] +
                        '　' +
                        age +
                        '・' +
                        gender),
                  ),

                  // 商品名
                  Container(
                    child: SelectableText(review['product_name'],
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  // スターレーティング　用改良
                  Container(
                    child: star(review['review_evaluation'], 16),
                  ),
                  // レビュー本文
                  Container(
                    //height: mheight * 0.1,
                    width: mwidth * 0.17,
                    child: SelectableText(
                      review['review_comment'],
                      maxLines: 3,
                      style: TextStyle(fontSize: 14.sp),
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
