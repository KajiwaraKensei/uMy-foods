import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:umy_foods/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:umy_foods/login.dart';

class AuthComplete extends StatelessWidget {
  // 引数からユーザー情報を受け取れるようにする
  AuthComplete(this.user);
  // ユーザー情報
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(/* --- 省略 --- */),
      body: Center(
          // ユーザー情報を表示
          child: Column(
        children: [
          Text('ログイン情報：${user.email}'),
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                // ログアウト処理
                // 内部で保持しているログイン情報等が初期化される
                // （現時点ではログアウト時はこの処理を呼び出せばOKと、思うぐらいで大丈夫です）
                await FirebaseAuth.instance.signOut();
                // ログイン画面に遷移＋チャット画面を破棄
                await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return Login();
                  }),
                );
              }),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          /*
          // 投稿画面に遷移
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return AddPostPage();
            }),
          );*/
        },
      ),
    );
  }
}

//googleログイン完了画面構築
class GoogleAuthComplete extends StatelessWidget {
  // 引数からユーザー情報を受け取れるようにする
  GoogleAuthComplete(this.user);
  // ユーザー情報
  final User? user;
  final FirebaseAuth auth = FirebaseAuth.instance;
  //ログアウト時に使う
  final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    if (user != null) {
      String? name = user?.displayName; //ユーザー名
      String? imageUrl = user?.photoURL; //アイコン画像
      String? email = user?.email; //email
      return Scaffold(
        appBar: AppBar(/* --- 省略 --- */),
        body: Center(
            // ユーザー情報を表示
            child: Column(
          children: [
            Text('ようこそ、${name}さん'),
            CircleAvatar(
              //アイコン
              radius: 15,
              backgroundImage:
                  imageUrl != null ? NetworkImage(imageUrl.toString()) : null,
              child: imageUrl == null
                  ? Icon(Icons.account_circle, size: 30)
                  : Container(),
            ),
            Text('email：${email}'),
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  // ログアウト処理
                  //uid = null;
                  name = null;
                  email = null;
                  imageUrl = null;
                  await googleSignIn.signOut();
                  await auth.signOut(); //ログアウト完了
                  await Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) {
                      return Login(); //ログイン画面に戻る
                    }),
                  );
                }),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            /*
          // 投稿画面に遷移
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return AddPostPage();
            }),
          );*/
          },
        ),
      );
    } else {
      return Scaffold(appBar: AppBar(/* --- 省略 --- */), body: Center());
    }
  }
}
