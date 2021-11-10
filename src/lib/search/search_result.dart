import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';
// パッケージ
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart'; //パンくず
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; //font_awesome
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; //DB

// 外部ファイル
import 'package:umy_foods/HexColor.dart'; //16進数カラーコード
import 'package:umy_foods/SpaceBox.dart'; //空間
import 'package:umy_foods/star.dart'; //星評価
import 'package:umy_foods/Filtering.dart'; //フィルタリングポップアップ
import 'package:umy_foods/sort.dart'; //ソートポップアップ
import 'package:umy_foods/header.dart';
import 'package:umy_foods/footer.dart';
import 'package:umy_foods/details/details.dart';
import 'package:umy_foods/clipButton.dart';
import 'package:umy_foods/clipAddButton.dart';
import 'package:umy_foods/alert.dart';

class SearchResultsPage extends StatefulWidget {
  SearchResultsPage(String this.searchWord, String this.kind);
  String searchWord;
  String kind;
  @override
  _SearchResultsPageState createState() =>
      _SearchResultsPageState(searchWord, kind);
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  _SearchResultsPageState(this.searchWord, this.kind);
  String searchWord;
  String kind;
  bool switchBool = false; //昇順降順切り替え

  void _onPressedStart() {
    //昇順降順の判定
    setState(() {
      switchBool = !switchBool;
    });
  }

  String display = 'ユーザー'; //レビュー・商品・ユーザーの表示判定

  //入力された並び替え
  String sort = '';

  //入力された絞り込み
  String age = ''; //年齢
  String gender = ''; //性別

  String major_category = ''; //親カテゴリ
  String category = ''; //子カテゴリ
  String sub_category = ''; //孫カテゴリ
  String brand = ''; //ブランド
  String maker = ''; //メーカー

  Widget build(BuildContext context) {
    var media_width = MediaQuery.of(context).size.width; //学校販売PCの場合1280
    var media_height = MediaQuery.of(context).size.height; //学校販売PCの場合609

    if (kind == 'one') {
      display = '商品';
    } else if (kind == 'two') {
      display = 'ユーザー';
    } else if (kind == 'three') {
      display = 'レビュー';
    }

    return Scaffold(
      appBar: Header(),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: media_height * 0.032,
                horizontal: media_width * 0.031),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //フィルター値取得テスト用
                // Text('年代'+age+'　性別'+gender),
                // Text('　親'+major_category+'　子'+category+'　孫'+sub_category+'　ブランド'+brand+' メーカー'+maker),
                // Text('ソート'+sort),
                BreadCrumb(
                  //パンくずリスト
                  items: <BreadCrumbItem>[
                    BreadCrumbItem(
                      content: TextButton(
                        onPressed: () {Navigator.pop(context);},
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
                          '検索結果',
                          style: TextStyle(color: Colors.black),
                          scrollPhysics: NeverScrollableScrollPhysics(),
                        ),
                      ),
                    ),
                  ],
                  divider: Icon(Icons.chevron_right),
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: media_height * 0.05),
                    child: Row(
                      children: [
                        Expanded(
                          //左
                          flex: 3,
                          child: Container(
                            margin: EdgeInsets.only(right: media_width * 0.03),
                            child: Column(
                              children: [
                                Container(
                                  //検索ワード・該当数
                                  child: Column(
                                    children: [
                                      SelectableText(
                                        '「' + searchWord + '」',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 25),
                                      ),
                                      SelectableText('の検索結果を表示しています',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 25)),
                                    ],
                                  ),
                                ),
                                StreamBuilder<QuerySnapshot>(

                                    //表示したいFiresotreの保存先を指定
                                    stream: (() {
                                  // 即時関数を使う
                                  if (kind == 'one') {
                                    return product(searchWord);
                                  } else if (kind == 'two') {
                                    return User(searchWord);
                                  } else if (kind == 'three') {
                                    return review(searchWord);
                                  }
                                })(),

                                    //streamが更新されるたびに呼ばれる
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                  //データが取れていない時の処理
                                  if (!snapshot.hasData)
                                    return const Text('Loading...');

                                  final sum = snapshot.data!.docs;
                                  return Column(children: [
                                    SelectableText(
                                        '該当：' + sum.length.toString() + '件',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 17)),
                                    Container(
                                      //結果内容
                                      margin: EdgeInsets.symmetric(
                                          vertical: media_height * 0.0585),
                                      child: Column(
                                        children: [
                                          Row(
                                            //表示順・絞り込み・降順昇順
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              if (display !=
                                                  'ユーザー') //ユーザー以外の場合表示順表示
                                                SizedBox(
                                                  width: media_width * 0.07,
                                                  height:
                                                      media_height * 0.06568,
                                                  child: ElevatedButton(
                                                      child: const Text('表示順'),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors.white,
                                                        onPrimary:
                                                            HexColor('EC9361'),
                                                        side: BorderSide(
                                                            color: HexColor(
                                                                'EC9361')),
                                                      ),
                                                      onPressed: () async {
                                                        showDialog<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return BetaAlert();
                                                },
                                              );
                                                        // var selected;
                                                        // if (display == '商品') {
                                                        //   //商品の場合
                                                        //   selected = await showDialog<
                                                        //           String>(
                                                        //       context: context,
                                                        //       barrierDismissible:
                                                        //           true, // user must tap button!
                                                        //       builder:
                                                        //           (BuildContext
                                                        //               context) {
                                                        //         return SearchResultsSortDialog();
                                                        //       });
                                                        // } else if (display ==
                                                        //     'レビュー') {
                                                        //   //レビューの場合
                                                        //   selected = await showDialog<
                                                        //           String>(
                                                        //       context: context,
                                                        //       barrierDismissible:
                                                        //           true, // user must tap button!
                                                        //       builder:
                                                        //           (BuildContext
                                                        //               context) {
                                                        //         return SortDialog();
                                                        //       });
                                                        // }
                                                        // setState(() {
                                                        //   if (selected !=
                                                        //       null) {
                                                        //     //何も押さず閉じた場合nullになる
                                                        //     sort = ''; //初期化
                                                        //     sort = selected
                                                        //         .toString(); //選択したものを代入
                                                        //   }
                                                        // });
                                                      }),
                                                ),
                                              SpaceBox.width(20),
                                              SizedBox(
                                                //各絞り込みを表示
                                                width: media_width * 0.078,
                                                height: media_height * 0.06568,
                                                child: ElevatedButton(
                                                    child: Text('絞り込み'),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: Colors.white,
                                                      onPrimary:
                                                          HexColor('EC9361'),
                                                      side: BorderSide(
                                                          color: HexColor(
                                                              'EC9361')),
                                                    ),
                                                    onPressed: () async {
                                                      showDialog<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return BetaAlert();
                                                },
                                              );
                                                      // var selected;
                                                      // if (display == 'ユーザー' ||
                                                      //     display == 'レビュー') {
                                                      //   selected = await showDialog<
                                                      //           List<String>>(
                                                      //       //[年代,性別]
                                                      //       context: context,
                                                      //       barrierDismissible:
                                                      //           true,
                                                      //       builder:
                                                      //           (BuildContext
                                                      //               context) {
                                                      //         return GenderAge_FilteringDialog();
                                                      //       });
                                                      //   setState(() {
                                                      //     if (selected !=
                                                      //         null) {
                                                      //       //何も押さず閉じた場合nullになる
                                                      //       //初期化
                                                      //       age = '';
                                                      //       gender = '';
                                                      //       if (selected[0]
                                                      //               .length >
                                                      //           1) {
                                                      //         //年代
                                                      //         age = selected[0];
                                                      //       }
                                                      //       if (selected[1]
                                                      //               .length >
                                                      //           1) {
                                                      //         //性別
                                                      //         gender =
                                                      //             selected[1];
                                                      //       }
                                                      //     }
                                                      //   });
                                                      // } else if (display ==
                                                      //     '商品') {
                                                      //   selected = await showDialog<
                                                      //           List<String>>(
                                                      //       //[カテゴリ、ブランド、メーカー]
                                                      //       context: context,
                                                      //       barrierDismissible:
                                                      //           true, // user must tap button!
                                                      //       builder:
                                                      //           (BuildContext
                                                      //               context) {
                                                      //         return Details_FilteringDialog();
                                                      //       });
                                                      //   setState(() {
                                                      //     if (selected !=
                                                      //         null) {
                                                      //       //何も押さず閉じた場合nullになる
                                                      //       //代入
                                                      //       major_category =
                                                      //           selected[
                                                      //               0]; //親カテゴリ
                                                      //       category = selected[
                                                      //           1]; //子カテゴリ
                                                      //       sub_category =
                                                      //           selected[
                                                      //               2]; //孫カテゴリ
                                                      //       brand = selected[
                                                      //           3]; //ブランド
                                                      //       maker = selected[
                                                      //           4]; //メーカー
                                                      //     }
                                                      //   });
                                                      // }
                                                    }),
                                              ),
                                              if (switchBool) //昇順降順ボタン
                                                Container(
                                                  child: Transform.rotate(
                                                      child: TextButton(
                                                        child: Icon(
                                                          Icons.sort_outlined,
                                                          color: HexColor(
                                                              'FFDFC5'),
                                                          size: 50,
                                                        ),
                                                        onPressed:
                                                            _onPressedStart,
                                                      ),
                                                      angle: pi / 1),
                                                )
                                              else
                                                TextButton(
                                                    child: Icon(
                                                      Icons.sort_outlined,
                                                      color: HexColor('FFDFC5'),
                                                      size: 50,
                                                    ),
                                                    onPressed: _onPressedStart)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                        //ユーザーの場合表示
                                        visible: display == 'ユーザー',
                                        child: StreamBuilder<QuerySnapshot>(

                                            //表示したいFiresotreの保存先を指定
                                            stream: User(searchWord),

                                            //streamが更新されるたびに呼ばれる
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              //データが取れていない時の処理
                                              if (!snapshot.hasData)
                                                return const Text('Loading...');

                                              final result =
                                                  snapshot.data!.docs;
                                              return Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    //     for (int x = 0; x < 3; x++) //３行
                                                    //       Row(
                                                    //           mainAxisAlignment:
                                                    //               MainAxisAlignment
                                                    //                   .spaceAround,
                                                    //           children: [
                                                    //             for (int i =
                                                    //                     0 + (x * 4);
                                                    //                 i < 4 * (x + 1);
                                                    //                 i++) //4列
                                                    SizedBox(
                                                      height: media_height *
                                                          0.9, // constrain height
                                                      child: GridView.count(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4),
                                                          crossAxisCount: 4,
                                                          childAspectRatio:
                                                              0.75,
                                                          children: [
                                                            for (int i = 0;
                                                                i <
                                                                    result
                                                                        .length;
                                                                i++)
                                                              // Container(
                                                              //   child: Row(
                                                              //     children: [
                                                              Card(
                                                                  //ユーザーカード
                                                                  child:
                                                                      InkWell(
                                                                onTap: () {
                                                                  setState(
                                                                      () {}); //プロフィール画面へ
                                                                },
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      media_width *
                                                                          0.1359,
                                                                  height:
                                                                      media_height *
                                                                          0.3578,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10),
                                                                  child:
                                                                      Flexible(
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Container(
                                                                            //アイコン
                                                                            height: media_height *
                                                                                0.2052,
                                                                            width: media_width *
                                                                                0.0976,
                                                                            decoration: new BoxDecoration(
                                                                                border: Border.all(color: Colors.grey),
                                                                                shape: BoxShape.circle,
                                                                                image: new DecorationImage(fit: BoxFit.cover, image: NetworkImage((result[i]['user_icon'] == "") ? 'images/anotherUser2.png' : result[i]['user_icon'])))),
                                                                        Text(result[i]
                                                                            [
                                                                            'user_name']), //ユーザーネーム
                                                                        Container(
                                                                          //margin: EdgeInsets.only(top: 20),
                                                                          child:
                                                                              RichText(
                                                                            text:
                                                                                TextSpan(
                                                                              style: TextStyle(color: HexColor('616161')),
                                                                              children: [
                                                                                WidgetSpan(
                                                                                  //いいね
                                                                                  child: Padding(
                                                                                    padding: EdgeInsets.only(bottom: 5),
                                                                                    child: Icon(
                                                                                      Icons.favorite,
                                                                                      size: 12,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                TextSpan(
                                                                                  text: '0',
                                                                                ),
                                                                                WidgetSpan(
                                                                                  //フォロワー
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
                                                              ))
                                                            //   ],
                                                            // ),
                                                            //)
                                                          ]),
                                                    ),
                                                    //       ]),
                                                    // SpaceBox.height(
                                                    //     media_height * 0.03),
                                                    Row(
                                                      //ページング
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          //数字ボタン
                                                          width: media_width *
                                                              0.027,
                                                          height: media_height *
                                                              0.082,
                                                          child: ElevatedButton(
                                                            child: Center(
                                                              child: Text(
                                                                '1',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            ),
                                                            style:
                                                                ElevatedButton
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
                                                          style: TextButton
                                                              .styleFrom(
                                                            primary:
                                                                Colors.black,
                                                          ),
                                                          onPressed: () {},
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            })), //ユーザー表示終了
                                    Visibility(
                                        //商品の場合表示
                                        visible: display == '商品',
                                        child: StreamBuilder<QuerySnapshot>(

                                            //表示したいFiresotreの保存先を指定
                                            stream: product(searchWord),

                                            //streamが更新されるたびに呼ばれる
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              //データが取れていない時の処理
                                              if (!snapshot.hasData)
                                                return const Text('Loading...');

                                              final result =
                                                  snapshot.data!.docs;
                                              return Container(
                                                child: Column(
                                                  children: [
                                                    // for (int x = 0; x < 3; x++) //3行
                                                    //   Row(
                                                    //     mainAxisAlignment:
                                                    //         MainAxisAlignment
                                                    //             .spaceAround,
                                                    //     children: [
                                                    //       for (int i = 0 + (x * 4);
                                                    //           i < 4 * (x + 1);
                                                    //           i++) //4列
                                                    //         Container(
                                                    //             child: Row(
                                                    //           children: [
                                                    //             SpaceBox.width(23),
                                                    SizedBox(
                                                        height: media_height *
                                                            0.9, // constrain height
                                                        child: GridView.count(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4),
                                                            crossAxisCount: 4,
                                                            childAspectRatio:
                                                                0.75,
                                                            children: [
                                                              for (int i = 0;
                                                                  i <
                                                                      result
                                                                          .length;
                                                                  i++)
                                                                Card(
                                                                  //商品カード
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {});
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                DetailsPage(result[i]['product_id'], '検索'),
                                                                          )); //商品詳細ページへ
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          Padding(
                                                                              padding: EdgeInsets.all(10),
                                                                              child: Column(
                                                                                children: [
                                                                                  Container(
                                                                                    //商品画像
                                                                                    height: media_height * 0.164,
                                                                                    width: media_width * 0.078125,
                                                                                    child: Align(
                                                                                      alignment: Alignment.center,
                                                                                      child: Image.network((result[i]['images'][0] == '') ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf' : result[i]['images'][0]),
                                                                                    ),
                                                                                  ),
                                                                                  Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(result[i]['maker_id']), //メーカー
                                                                                      Text(result[i]['product_name']), //商品名
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
                                                                                          defaultClipAddButton(result[i]['product_id'], result[i]['product_name'], result[i]['images'][0]),
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
                                                            ])),
                                                    //         ],
                                                    //       ))
                                                    //   ],
                                                    // ),
                                                    SpaceBox.height(
                                                        media_height * 0.03),
                                                    Row(
                                                      //ページング
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          //数字ボタン
                                                          width: media_width *
                                                              0.027,
                                                          height: media_height *
                                                              0.082,
                                                          child: ElevatedButton(
                                                            child: Center(
                                                              child: Text(
                                                                '1',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            ),
                                                            style:
                                                                ElevatedButton
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
                                                          style: TextButton
                                                              .styleFrom(
                                                            primary:
                                                                Colors.black,
                                                          ),
                                                          onPressed: () {},
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            })), //商品表示終了
                                    Visibility(
                                      //レビューの場合表示
                                      visible: display == 'レビュー',
                                      child: StreamBuilder<QuerySnapshot>(

                                          //表示したいFiresotreの保存先を指定
                                          stream: review(searchWord),

                                          //streamが更新されるたびに呼ばれる
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            //データが取れていない時の処理
                                            if (!snapshot.hasData)
                                              return const Text('Loading...');

                                            final result = snapshot.data!.docs;
                                            return Container(
                                              child: Column(
                                                children: [
                                                  // for (int x = 0;
                                                  //     x < 3;
                                                  //     x++) //3行
                                                  //   Row(
                                                  //     children: [
                                                  // for (int i = 0 + (x * 4);
                                                  //     i < 4 * (x + 1);
                                                  //     i++) //4列
                                                  //   Container(
                                                  //       child: Row(
                                                  //     children: [
                                                  //       SpaceBox.width(23),
                                                  SizedBox(
                                                      height: media_height *
                                                          0.9, // constrain height
                                                      child: GridView.count(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4),
                                                          crossAxisCount: 4,
                                                          childAspectRatio:
                                                              0.75,
                                                          children: [
                                                            for (int i = 0;
                                                                i <
                                                                    result
                                                                        .length;
                                                                i++)
                                                              Card(
                                                                //レビューカード
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {}); //レビュー詳細ページへ
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
                                                                                      //'https://m.media-amazon.com/images/I/51ntmtYKayL._AC_.jpg'
                                                                                      (result[i]['url'] == '') ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf' : result[i]['url'],
                                                                                      fit: BoxFit.contain,
                                                                                    )),
                                                                              ),
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(result[i]['product_name']), //商品名
                                                                                  Row(
                                                                                    //星評価
                                                                                    children: [
                                                                                      Text(
                                                                                        '総合評価：',
                                                                                        style: TextStyle(fontSize: 12),
                                                                                      ),
                                                                                      star(result[i]['review_evaluation'], 15),
                                                                                    ],
                                                                                  ),
                                                                                  SpaceBox.height(5),
                                                                                  Text(
                                                                                    //レビュー内容
                                                                                    result[i]['review_comment'] //'298円で販売されていて、いつもとは違う味を食べたくて冒険してみた。シンプルにボイルして食べてみたら、中からトロ〜っとチーズが溶けていつものシャウエッセンのお肉のジューシーなコクのある塩気とチーズの濃厚な味が'
                                                                                    ,
                                                                                    style: TextStyle(fontSize: 11),
                                                                                    maxLines: 4,
                                                                                  )
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ))),
                                                                ),
                                                              ),
                                                          ])),
                                                  //         ],
                                                  //       ))
                                                  SpaceBox.height(
                                                      media_height * 0.03),
                                                  Row(
                                                    //ページング
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        //数字ボタン
                                                        width:
                                                            media_width * 0.027,
                                                        height: media_height *
                                                            0.082,
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
                                                        style: TextButton
                                                            .styleFrom(
                                                          primary: Colors.black,
                                                        ),
                                                        onPressed: () {},
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                          }),
                                    ) //レビュー表示終了
                                  ]);
                                }),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          //右側（広告）
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(right: media_width * 0.03),
                            child: Column(
                              children: [
                                //広告スペース
                                //以下テスト用
                                // TextButton(
                                //   child: Text('レビュー'),
                                //   onPressed: () {
                                //     setState(() {
                                //       display = 'レビュー';
                                //     });
                                //   },
                                // ),
                                // TextButton(
                                //   child: Text('ユーザー'),
                                //   onPressed: () {
                                //     setState(() {
                                //       display = 'ユーザー';
                                //     });
                                //   },
                                // ),
                                // TextButton(
                                //   child: Text('商品'),
                                //   onPressed: () {
                                //     setState(() {
                                //       display = '商品';
                                //     });
                                //   },
                                // )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
          FooterCreate()
          //フッター
        ],
      ),
      floatingActionButton: clipButton('検索結果'),
    );
  }

  Stream<QuerySnapshot> review(String searchWord) {
    return FirebaseFirestore.instance
        .collection('review')
        //.where('product_name', isEqualTo: searchWord)
        .orderBy("product_name")
        .startAt([searchWord]).endAt([searchWord + '\uf8ff']).snapshots();
  }

  Stream<QuerySnapshot> product(String searchWord) {
    return FirebaseFirestore.instance
        .collection('product')
        //.where('product_name', isEqualTo: searchWord)
        .orderBy("product_name")
        .startAt([searchWord]).endAt([searchWord + '\uf8ff']).snapshots();
  }

  Stream<QuerySnapshot> User(String searchWord) {
    return FirebaseFirestore.instance
        .collection('account')
        //.where('user_name', isEqualTo: searchWord)
        .orderBy("user_name")
        .startAt([searchWord]).endAt([searchWord + '\uf8ff']).snapshots();
  }
}
