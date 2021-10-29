import 'dart:html';
import 'package:flutter/material.dart';
import 'package:umy_foods/SpaceBox.dart';
import 'package:umy_foods/header.dart';
import 'package:umy_foods/footer.dart';
import 'package:umy_foods/HexColor.dart';

class ChangePw extends StatefulWidget {
  @override
  _ChangePwState createState() => _ChangePwState();
}

class _ChangePwState extends State<ChangePw> {
  var _oldpassword = TextEditingController();
  var _newpassword = TextEditingController();
  var _newpasswordcon = TextEditingController();

  bool _showoldPassword = true;
  bool _shownewPassword = true;
  bool _shownewPasswordcon = true;

  var oldpassword_error = '';
  var newpassword_error = '';
  var newpasswordcon_error = '';

  @override
  Widget build(BuildContext context) {
    var media_width = MediaQuery.of(context).size.width;
    var media_height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //現在のパスワードを入力させる
            SpaceBox.height(30),
            Text(
              '現在のパスワードを入力してください',
              style: TextStyle(
                color: HexColor('000000'),
              ),
            ),
            // 現在のパスワード入力欄
            Container(
              width: media_width * 0.35,
              child: TextField(
                cursorColor: Colors.orange, // カーソルの色
                obscureText: _showoldPassword, // 入力文字非表示
                controller: _oldpassword,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: HexColor('ec9463'),
                      width: 1.5,
                    ),
                  ),
                  // フォーカスされているとき
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: HexColor('ec9463'),
                      width: 3.5,
                    ),
                  ),
                  // 表示マーク
                  suffixIcon: IconButton(
                    icon: Icon(_showoldPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey),
                    onPressed: () {
                      this.setState(() {
                        // 表示と非表示切り替え
                        _showoldPassword = !_showoldPassword;
                      });
                    },
                  ),
                  hintText: '現在のパスワードを入力',
                ),
              ),
            ),
            // 現在のパスワードエラーメッセージ
            Container(
              margin: EdgeInsets.only(top: 3, bottom: 25),
              child: Text(
                oldpassword_error,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),

            //新しいパスワードを入力させる
            Text(
              '新しいパスワードを入力してください',
              style: TextStyle(
                color: HexColor('000000'),
              ),
            ),
            // 新しいパスワード入力欄
            Container(
              width: media_width * 0.35,
              child: TextField(
                cursorColor: Colors.orange, // カーソルの色
                obscureText: _shownewPassword, // 入力文字非表示
                controller: _newpassword,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: HexColor('ec9463'),
                      width: 1.5,
                    ),
                  ),
                  // フォーカスされているとき
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: HexColor('ec9463'),
                      width: 3.5,
                    ),
                  ),
                  // 表示マーク
                  suffixIcon: IconButton(
                    icon: Icon(_shownewPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey),
                    onPressed: () {
                      this.setState(() {
                        // 表示と非表示切り替え
                        _shownewPassword = !_shownewPassword;
                      });
                    },
                  ),
                  hintText: '新しいパスワードを入力',
                ),
              ),
            ),
            // 新しいパスワードエラーメッセージ
            Container(
              margin: EdgeInsets.only(top: 3, bottom: 25),
              child: Text(
                newpassword_error,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),

            //新しいパスワード2回目
            Text(
              'もう一度新しいパスワードを入力してください',
              style: TextStyle(
                color: HexColor('000000'),
              ),
            ),
            // 新しいパスワード2回目入力欄
            Container(
              width: media_width * 0.35,
              child: TextField(
                cursorColor: Colors.orange, // カーソルの色
                obscureText: _shownewPasswordcon, // 入力文字非表示
                controller: _newpasswordcon,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: HexColor('ec9463'),
                      width: 1.5,
                    ),
                  ),
                  // フォーカスされているとき
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: HexColor('ec9463'),
                      width: 3.5,
                    ),
                  ),
                  // 表示マーク
                  suffixIcon: IconButton(
                    icon: Icon(_shownewPasswordcon ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey),
                    onPressed: () {
                      this.setState(() {
                        // 表示と非表示切り替え
                        _shownewPasswordcon = !_shownewPasswordcon;
                      });
                    },
                  ),
                  hintText: 'もう一度新しいパスワードを入力',
                ),
              ),
            ),
            // 新しいパスワード2回目エラーメッセージ
            Container(
              margin: EdgeInsets.only(top: 3, bottom: 10),
              child: Text(
                oldpassword_error,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),

            //変更するボタン
            Container(
              margin: EdgeInsets.only(bottom: 10),
              width: media_width * 0.1,
              height: media_height * 0.07,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "変更する",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: HexColor('ec9463'), //ボタンの背景色
                ),
              ),
            ),

            FooterCreate(),
          ],
        ),
      ),
    );
  }
}
