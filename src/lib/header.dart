import 'dart:html';

import 'package:flutter/material.dart';
import 'package:umy_foods/main.dart';
import 'package:umy_foods/login/login.dart';
import 'package:umy_foods/HexColor.dart';
import 'package:umy_foods/review_post/product_selection.dart';
import 'package:umy_foods/list_page/brand.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(80.0);

  var _selectedValue = 'ログイン'; //初期にフォーカスされているもの
  var _usStates = ["マイページ", "ログアウト"]; //ポップアップのリスト(ログインあり)

  final TextEditingController _categoryNameController =
      new TextEditingController(text: '');

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
      //titleSpacing: 300,
      title: TextField(
        controller: _categoryNameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: "クチコミ・商品・ユーザを検索",
            // prefixIcon: Icon(Icons.search),
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
            suffixIcon: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.clear_sharp, color: Colors.black),
                      onPressed: () => _categoryNameController.clear(),
                    ),
                    IconButton(
                        icon: Icon(Icons.search, color: Colors.black),
                        onPressed: () {}),
                  ],
                ),
              ],
            )
            // border: InputBorder.none,
            ),
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      toolbarHeight: 150,
      actions: [
        Container(
          margin: EdgeInsets.only(right: 50, left: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 投稿ボタン
              Container(
                width: 80,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductselectionPage(),
                        ));
                  },
                  child: IconButton(
                    icon: Icon(Icons.mode, color: Colors.white),
                    onPressed: () => _categoryNameController.clear(),
                  ),
                  // child: Text(
                  //   "投稿",
                  //   style: TextStyle(
                  //     color: HexColor('ffffff'),
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
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
                child: Container(
                  margin: EdgeInsets.only(left: 50),
                  child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.orange,
                      backgroundImage: NetworkImage((UserImage == "")
                          ? 'images/anotherUser2.png'
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
                offset: Offset(30, 50),
              ),
              // Container(
              //     margin: EdgeInsets.only(left: 50),
              //     child: GestureDetector(
              //         onTap: () {
              //           Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => Login(),
              //               ));
              //         },
              //         child: CircleAvatar(
              //             radius: 30,
              //             backgroundColor: Colors.orange,
              //             backgroundImage: NetworkImage((UserImage == "")
              //                 ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/anotherUser2.png?alt=media&token=2c965f37-f6b3-4594-9998-24080a38073f'
              //                 : UserImage)))),
            ],
          ),
        ),
      ],
      backgroundColor: HexColor('F5F3EF'),
    );
  }
}
