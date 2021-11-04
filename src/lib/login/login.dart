import 'dart:math';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:umy_foods/login/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:umy_foods/login/auth_complete.dart';
import 'package:umy_foods/header.dart';
import 'package:umy_foods/footer.dart';
import 'package:umy_foods/HexColor.dart';
import 'package:umy_foods/main.dart';

//firebase_auth
final FirebaseAuth auth = FirebaseAuth.instance;
//googleログイン
final GoogleSignIn googleSignIn = GoogleSignIn();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
  var _userpassword = TextEditingController();
  var address_error = '';
  var password_error = '';
  String errmsg = '';

  bool _flag = true;
  bool _showPassword = true;
  //firebase_auth
  final FirebaseAuth auth = FirebaseAuth.instance;
  //googleログイン
  final GoogleSignIn googleSignIn = GoogleSignIn();

//googleログイン用のクラス
  Future<User?> signInWithGoogle() async {
    await Firebase.initializeApp();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    //ログイン自体はここで完了

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
    final User? user = userCredential.user; //ログインしたユーザーの情報

    if (user != null) {
      // Checking if email and name is null
      assert(user.uid != null);
      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null); //トークンに保存（現状は放置）

      final User? currentUser = auth.currentUser;
      assert(user.uid == currentUser!.uid);
    }
    return user; //ユーザー情報を返す
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 700,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                    child: Column(
                      children: [
                        Container(
                          width: 400,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // メールアドレスでログイン
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    'メールアドレスでログイン',
                                    style: TextStyle(
                                      color: HexColor('8c6e63'),
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600, // 文字の太さ
                                    ),
                                  ),
                                ),
                              ),
                              // メールアドレス入力欄
                              TextField(
                                //focusNode: myFocusNode,
                                cursorColor: Colors.orange, // カーソルの色
                                controller: _useraddress, // 入力文字取得用
                                decoration: InputDecoration(
                                  // フォーカスされていないとき
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0), //角のまるさ
                                    // 枠線
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
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(
                                  password_error,
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
                                          // パスワード忘れ画面へ
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
                                      value: _flag, //チェックの有無(bool型)
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
                              // ログインボタン
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  width: 170,
                                  height: 40,
                                  child: //Column(children: [
                                      ElevatedButton(
                                    onPressed: () async {
                                      address_error = '';
                                      password_error = '';
                                      try {
                                        // メール/パスワードでログイン
                                        final result = await auth
                                            .signInWithEmailAndPassword(
                                          email: _useraddress.text,
                                          password: _userpassword.text,
                                        );
                                        // ログインに成功した場合
                                        // 遷移＋ログイン画面を破棄
                                        await Navigator.of(context)
                                            .pushReplacement(
                                          MaterialPageRoute(builder: (context) {
                                            return MyApp() //AuthComplete(result.user!)
                                                ;
                                          }),
                                        );
                                      } on FirebaseAuthException catch (e) {
                                        errmsg = e.code;
                                        if (errmsg == 'invalid-email') {
                                          setState(() {
                                            address_error =
                                                "正しいメールアドレスを入力してください。";
                                          });
                                        } else if (errmsg == 'wrong-password') {
                                          setState(() {
                                            password_error =
                                                "正しいパスワードを入力してください。";
                                          });
                                        }
                                        // ログインに失敗した場合
                                      }
                                    },
                                    /*{
                            // 確認用
                            setState(() {
                              _text = _useraddress.text;
                              _text += ':';
                              _text += _userpassword.text;
                            });
                          },*/
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
                                  //Text(errmsg),
                                  //]),
                                ),
                              ),
                              // 新規会員登録リンク
                              Container(
                                margin: EdgeInsets.only(top: 20, bottom: 20),
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
                                        // 新規登録画面へ
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Signup(),
                                              ));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 縦線
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          height: 3,
                          width: 700,
                          color: HexColor('ffdfc5'),
                        ),
                        // 他サービス欄
                        Container(
                          margin: EdgeInsets.only(top: 30, left: 8),
                          width: 400,
                          child: Column(
                            children: [
                              // 他サービスIDでログイン
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
                              // Google
                              Container(
                                width: 300,
                                height: 50,
                                // ボタン + icon
                                child: ElevatedButton.icon(
                                  icon: FaIcon(FontAwesomeIcons.google,
                                      color: Colors.red),
                                  label: Text('Google'),
                                  // ボタンのデザイン
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    onPrimary: Colors.black,
                                  ),
                                  onPressed: () async {
                                    await signInWithGoogle().then((result) {
                                      //googleログイン用のクラスを呼んで、ユーザー情報を取得
                                        FirebaseFirestore.instance
                                          .collection('account')
                                          .doc(result?.uid)
                                          .set({
                                        'user_id': result?.uid,
                                        'user_name': result?.displayName,
                                        'user_profile': '',
                                        'user_icon': '',
                                        'user_gender': '',
                                        'user_favorite': [''],
                                        'delete_flag': false,
                                        'user_birthday':
                                            FieldValue.serverTimestamp(),
                                        'delete_date':
                                            FieldValue.serverTimestamp(),
                                        'regist_date':
                                            FieldValue.serverTimestamp(),
                                      });
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          fullscreenDialog: true,
                                          builder: (context) =>
                                                MyApp() //GoogleAuthComplete(result), //auth_compleet.dartのGoogleAuthCompleteにresult(ユーザー情報)を送る
                                        ),
                                      );
                                    }).catchError((e) {
                                      print('ログインに失敗しました： $e');
                                    });
                                    // Googleでログイン処理
                                  },
                                ),
                              ),
                              // Twitter
                              /*Container(
                                width: 300,
                                height: 50,
                                margin: EdgeInsets.only(top: 20),
                                child: ElevatedButton.icon(
                                  // 青色部分
                                  icon: Ink(
                                    width: 30,
                                    decoration: ShapeDecoration(
                                      color: Colors.blue,
                                      shape: CircleBorder(),
                                    ),
                                    // アイコン部分
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
                              ),*/
                              // Facebook
                              /*Container(
                                width: 300,
                                height: 50,
                                margin: EdgeInsets.only(top: 20),
                                // ボタン + icon
                                child: ElevatedButton.icon(
                                  icon: FaIcon(FontAwesomeIcons.facebook,
                                      color: Colors.indigo),
                                  label: Text('Facebook'),
                                  // ボタンのデザイン
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
                  )),
              FooterCreate(),
            ],
          ),
        ));
  }
}

//googleログイン用のクラス
Future<User?> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
  //ログイン自体はここで完了

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential userCredential =
      await auth.signInWithCredential(credential);
  final User? user = userCredential.user; //ログインしたユーザーの情報

  if (user != null) {
    // Checking if email and name is null
    assert(user.uid != null);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null); //トークンに保存（現状は放置）

    final User? currentUser = auth.currentUser;
    assert(user.uid == currentUser!.uid);
  }
  return user; //ユーザー情報を返す
}
