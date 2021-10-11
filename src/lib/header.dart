import 'dart:html';

import 'package:flutter/material.dart';
import 'package:umy_foods/main.dart';
import 'package:umy_foods/login/login.dart';
import 'package:umy_foods/HexColor.dart';
import 'package:umy_foods/review_post/product_selection.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(90.0);

  var _selectedValue = 'ログイン'; //初期にフォーカスされているもの
  var _usStates = ["ログイン", "マイページ"]; //ポップアップのリスト

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(
        padding: EdgeInsets.only(top: 2, right: 2, bottom: 2, left: 50),
        child: OverflowBox(
          maxWidth: 110,
          child: Tooltip(
            message: 'トップページへ',
            child: GestureDetector(
              child: CircleAvatar(
          backgroundImage: AssetImage('images/uMyFoods_icon.png'),
          backgroundColor: Colors.transparent, // 背景色
          radius: 40, // 表示したいサイズの半径を指定
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(),
              ));
        },
      ),
          ),
        ),
      ),
      leadingWidth: 80,
      titleSpacing: 100,
      title: TextField(
        decoration: InputDecoration(
          // hintText: "クチコミ・商品・ユーザを検索",
          prefixIcon: Icon(Icons.search),
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.0),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.0),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          border: InputBorder.none,
        ),
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      toolbarHeight: 150,
      actions: [
        Container(
          margin: EdgeInsets.only(right: 50, left: 50),
          child: Row(
            children: [
              // 投稿ボタン
              Container(
                width: 100,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductselectionPage(),
              ));
                  },
                  child: Text(
                    "投稿",
                    style: TextStyle(
                      color: HexColor('ffffff'),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: HexColor('EC9361'), //ボタンの背景色
                    side: BorderSide(
                      color: HexColor('ffffff'), //枠線
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              // マイページ
              PopupMenuButton<String>(
                tooltip: 'ユーザーメニュー',
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: Container(
                  margin: EdgeInsets.only(left: 50),
                  child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.orange,
                      backgroundImage: NetworkImage((UserImage == "")
                          ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/anotherUser2.png?alt=media&token=2c965f37-f6b3-4594-9998-24080a38073f'
                          : UserImage)),
                ),
                initialValue: _selectedValue,
                onSelected: (String s) {
                  if (s == 'ログイン') {
                    //画面遷移
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ));
                  }
                  // setState(() {
                  //   _selectedValue = s;
                  // });
                },
                itemBuilder: (BuildContext context) {
                  return _usStates.map((String s) {
                    return PopupMenuItem(
                      //ポップアップに載せる物
                      child: Text(s),
                      value: s,
                    );
                  }).toList();
                },
              ),
              /*Tooltip(
                message: 'ログイン',
                child: Container(
                  margin: EdgeInsets.only(left: 50),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ));
                      },
                      child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.orange,
                          backgroundImage: NetworkImage((UserImage == "")
                              ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/anotherUser2.png?alt=media&token=2c965f37-f6b3-4594-9998-24080a38073f'
                              : UserImage)))),
              ),*/
            ],
          ),
        ),
      ],
      backgroundColor: HexColor('F5F3EF'),
    );
  }
}

