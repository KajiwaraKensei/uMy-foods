import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:umy_foods/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

class GoogleAuthComplete extends StatelessWidget {
  // 引数からユーザー情報を受け取れるようにする
  GoogleAuthComplete(this.user);
  // ユーザー情報
  final User? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(/* --- 省略 --- */),
      body: Center(
          // ユーザー情報を表示
          child: Column(
        children: [
          Text('googleログイン情報：${user}'),
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
