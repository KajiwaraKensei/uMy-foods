import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  var _useraddress = TextEditingController();
  var _userpassword = TextEditingController();
  var _text = '';
  bool _flag = true;
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor('F5F3EF'),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(150, 30, 30, 30),
          child: Row(
            children: [
              Container(
                width: 400,
                child: Column(
                  children: [
                    // メールアドレスでログイン
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'メールアドレスでログイン',
                        style: TextStyle(
                          color: HexColor('8c6e63'),
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // メールアドレス入力欄
                    TextField(
                      focusNode: myFocusNode,
                      // カーソルの色
                      cursorColor: Colors.orange,
                      controller: _useraddress,
                      decoration: InputDecoration(
                        // フォーカスされていないとき
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
                        hintText: 'メールアドレスを入力',
                      ),
                    ),
                    // メールアドレスエラーメッセージ
                    Container(
                      margin: EdgeInsets.only(top: 3, bottom: 25),
                      child: Text('メールアドレスエラーメッセージ'),
                    ),
                    // パスワード入力欄
                    TextField(
                      cursorColor: Colors.orange,
                      obscureText: _showPassword, // 入力文字非表示
                      controller: _userpassword,
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
                          icon: Icon(_showPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey),
                          onPressed: () {
                            this.setState(() {
                              // 表示と非表示切り替え
                              _showPassword = !_showPassword;
                            });
                          },
                        ),
                        hintText: 'パスワードを入力',
                      ),
                    ),
                    // パスワードエラーメッセージ
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text('パスワードエラーメッセージ'),
                    ),
                    // パスワード忘れリンク
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('パスワードを忘れた方は'),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text('こちら'),
                          ),
                        ],
                      ),
                    ),
                    // ログイン状態保存チェックボックス
                    Container(
                      margin: EdgeInsets.only(top: 10, right: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            activeColor: Colors.blue,
                            value: _flag,
                            onChanged: (bool? value) {
                              setState(() {
                                _flag = value!;
                              });
                            },
                          ),
                          Text('ログイン状態を保存する'),
                        ],
                      ),
                    ),
                    // ログインボタン
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: 170,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _text = _useraddress.text;
                            _text += ':';
                            _text += _userpassword.text;
                          });
                        },
                        child: Text(
                          "ログイン",
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
                    // 新規会員登録リンク
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '新規会員登録は',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text(
                              'こちら',
                              style: TextStyle(
                                color: HexColor('f47c01'),
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //テストメッセージ
                    Text(_text),
                  ],
                ),
              ),
              // 縦線
              Container(
                margin: EdgeInsets.only(left: 100),
                height: 700,
                width: 3,
                color: HexColor('ffdfc5'),
              ),
              // 他サービス欄
              Container(
                margin: EdgeInsets.only(left: 100),
                width: 400,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        '他サービスIDでログイン',
                        style: TextStyle(
                          color: HexColor('8c6e63'),
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: FaIcon(FontAwesomeIcons.google, color: Colors.grey),
                        label: Text('Googleでログイン'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      margin: EdgeInsets.only(top: 20),
                      child: ElevatedButton.icon(
                        icon: FaIcon(FontAwesomeIcons.twitter, color: Colors.blue),
                        label: Text('トゥイッターでログイン'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      margin: EdgeInsets.only(top: 20),
                      child: ElevatedButton.icon(
                        icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.indigo),
                        label: Text('顔本でログイン'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      margin: EdgeInsets.only(top: 20),
                      child: ElevatedButton.icon(
                        icon: FaIcon(FontAwesomeIcons.line, color: Colors.greenAccent.shade700),
                        label: Text('LINEでログイン'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
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
