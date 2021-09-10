import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:umy_foods/auth_complete.dart';
import 'package:umy_foods/signup_confirm.dart';
import 'package:umy_foods/header.dart';
import 'package:umy_foods/footer.dart';

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

  var address_error = '';
  var username_error = '';
  var password_error = '';
  var passwordCon_error = '';

  var _text = '';
  bool _flag = true;
  bool _showPassword = true;
  bool _showPasswordCon = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.fromLTRB(150, 30, 30, 30),
            child: Container(
              height: 1000,
              child: Row(
                children: [
                  Container(
                    width: 400,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // メールアドレスで新規登録
                        Center(
                          child: Container(
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
                        ),
                        Container(
                          child: Text(
                            'すべてが必須項目です',
                            style: TextStyle(
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            'メールアドレス',
                            style: TextStyle(
                              color: HexColor('000000'),
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
                            address_error,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        // ユーザー名
                        Text(
                          'ユーザー名',
                          style: TextStyle(
                            color: HexColor('000000'),
                          ),
                        ),
                        // ユーザー名入力欄
                        TextField(
                          //focusNode: myFocusNode,
                          cursorColor: Colors.orange, // カーソルの色
                          controller: _username, // 入力文字取得するために多分必要
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
                            hintText: 'ユーザー名を入力',
                          ),
                        ),
                        // ユーザー名エラー
                        Container(
                          margin: EdgeInsets.only(top: 3, bottom: 25),
                          child: Text(
                            username_error,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Text(
                          'パスワード',
                          style: TextStyle(
                            color: HexColor('000000'),
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
                              icon: Icon(
                                  _showPassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Colors.grey),
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
                          margin: EdgeInsets.only(top: 3, bottom: 25),
                          child: Text(
                            password_error,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Text(
                          '確認のため、もう一度パスワードを入力してください',
                          style: TextStyle(
                            color: HexColor('000000'),
                          ),
                        ),
                        // パスワード再入力
                        TextField(
                          cursorColor: Colors.orange, // カーソルの色
                          obscureText: _showPasswordCon, // 入力文字非表示
                          controller: _passwordconfirm,
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
                              icon: Icon(
                                  _showPasswordCon
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Colors.grey),
                              onPressed: () {
                                this.setState(() {
                                  // 表示と非表示切り替え
                                  _showPasswordCon = !_showPasswordCon;
                                });
                              },
                            ),
                            hintText: 'パスワードを入力',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 20),
                          child: Text(
                            passwordCon_error,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        // 以下規約を確認
                        Center(
                          child: Text(
                            '以下規約をご確認いただき、同意の上でお手続きください。',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        // 利用規約
                        Center(
                          child: Container(
                            child: TextButton(
                              child: const Text('利用規約'),
                              style: TextButton.styleFrom(
                                primary: Colors.blue,
                              ),
                              onPressed: () {
                                //利用規約表示
                              },
                            ),
                          ),
                        ),

                        // 続行ボタン
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            width: 350,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  address_error = '';
                                  username_error = '';
                                  password_error = '';
                                  passwordCon_error = '';
                                  if (!validateEmail(_useraddress.text)) {
                                    address_error = 'メールアドレスが正しくありません。';
                                    _flag = false;
                                  }
                                  if (_username.text.length < 1) {
                                    username_error = 'ユーザー名を入力してください。';
                                    _flag = false;
                                  }
                                  if (_username.text.length > 15) {
                                    username_error = 'ユーザー名は15文字以内で入力してください。';
                                    _flag = false;
                                  }
                                  if (validatePassword(_userpassword.text)) {
                                    password_error = 'パスワードは半角6文字以上で入力してください。';
                                    _flag = false;
                                  } else if (_userpassword.text !=
                                      _passwordconfirm.text) {
                                    passwordCon_error = 'パスワードが正しくありません。';
                                    _flag = false;
                                  }

                                  if (_flag) {
                                    address_error = '';
                                    username_error = '';
                                    password_error = '';
                                    passwordCon_error = '';
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Signup_Confirm(
                                              address: _useraddress.text,
                                              username: _username.text),
                                        ));
                                  } else
                                    _flag = true;
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
                        ),
                        // すでにお持ちのかた
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('すでにお持ちの方は'),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                child: TextButton(
                                  child: const Text('ログイン'),
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
                            icon: FaIcon(FontAwesomeIcons.google,
                                color: Colors.red),
                            label: Text('Google'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.black,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        /*
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
                                child: FaIcon(FontAwesomeIcons.twitter,
                                    color: Colors.white, size: 19),
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
                            icon: FaIcon(FontAwesomeIcons.facebook,
                                color: Colors.indigo),
                            label: Text('Facebook'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.black,
                            ),
                            onPressed: () {},
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          FooterCreate(),
        ]),
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

// メールアドレスの正規表現チェック
bool validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}

// パスワードの文字数チェック
bool validatePassword(String value) {
  return (value.length >= 6) ? false : true;
}
