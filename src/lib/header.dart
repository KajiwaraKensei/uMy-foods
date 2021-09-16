import 'dart:html';

import 'package:flutter/material.dart';
import 'package:umy_foods/main.dart';
import 'package:umy_foods/login.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: CircleAvatar(
          backgroundImage: AssetImage('images/uMyFoods_icon.png'),
          backgroundColor: Colors.transparent, // 背景色
          radius: 90, // 表示したいサイズの半径を指定
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(),
              ));
        },
      ),
      leadingWidth: 80,
      // titleSpacing: 300,
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
                  onPressed: () {},
                  child: Text(
                    "投稿",
                    style: TextStyle(
                      color: HexColor('ffffff'),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: HexColor('EC9361'), //ボタンの背景色
                    side: BorderSide(
                      color: HexColor('ffffff'), //枠線
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              // マイページ
              Container(
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
                        radius: 20,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage("images/anotherUser.png"),
                      ))),
            ],
          ),
        ),
      ],
      backgroundColor: HexColor('F5F3EF'),
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
