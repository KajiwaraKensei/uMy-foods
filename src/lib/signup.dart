import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  /*late FocusNode myFocusNode;

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
  }*/

  var _useraddress = TextEditingController();
  var _username = TextEditingController();
  var _userpassword = TextEditingController();
  var _passwordconfirm = TextEditingController();
  var _text = '';
  bool _flag = true;
  bool _showPassword = true;
  bool _showPasswordCon = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('F5F3EF'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(150, 30, 30, 30),
          child: Container(
            height: 1000,
            child: Row(
              children: [
                Container(
                  width: 400,
                  child: Column(
                    children: [
                      // メールアドレスで新規登録
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'メールアドレスで新規登録',
                          style: TextStyle(
                            color: HexColor('8c6e63'),
                            fontSize: 25,
                            // 文字の太さ
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      // メールアドレス入力欄
                      TextField(
                        //focusNode: myFocusNode,

                        cursorColor: Colors.orange, // カーソルの色
                        controller: _useraddress, // 入力文字取得するために多分必要
                        decoration: InputDecoration(
                          // フォーカスされていないとき
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0), //角のまるさ
                            // 枠線の設定
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
                        child: Text(
                          'メールアドレスエラーメッセージ',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      // パスワード入力欄
                      TextField(
                        cursorColor: Colors.orange, // カーソルの色
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
                        child: Text(
                          'パスワードエラーメッセージ',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
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
                              child: TextButton(
                                child: const Text('こちら'),
                                style: TextButton.styleFrom(
                                  primary: Colors.blue,
                                ),
                                onPressed: () {
                                  //パスワード忘れ画面へ
                                },
                              ),
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
                              value: _flag, // チェックの有無
                              onChanged: (bool? value) {
                                setState(() {
                                  _flag = value!; // 反転させる
                                });
                              },
                            ),
                            Text('ログイン状態を保存する'),
                          ],
                        ),
                      ),
                      // 続行ボタン
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        width: 350,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _text = _useraddress.text; // 確認用
                              _text += ':'; //確認用
                              _text += _userpassword.text; //確認用
                            });
                          },
                          child: Text(
                            "利用規約に同意して確認画面へ",
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
                              child: TextButton(
                                child: const Text(
                                  'こちら',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  primary: HexColor('f47c01'),
                                ),
                                onPressed: () {},
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
                          '他サービスIDで新規登録',
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
                          icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
                          label: Text('Google'),
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
                          icon: Ink(
                            width: 30,
                            decoration: ShapeDecoration(
                              color: Colors.blue,
                              shape: CircleBorder(),
                            ),
                            child: Center(
                              child: FaIcon(FontAwesomeIcons.twitter, color: Colors.white, size: 19),
                            ),
                          ),
                          label: Text('Twitter'),
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
                          label: Text('Facebook'),
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
          ),
        ),
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
