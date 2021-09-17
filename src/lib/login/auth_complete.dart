import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:umy_foods/login/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:umy_foods/login/login.dart';
import 'package:umy_foods/HexColor.dart';
import 'package:umy_foods/header.dart';
import 'package:umy_foods/footer.dart';
import 'package:umy_foods/main.dart';

class AuthComplete extends StatelessWidget {
  // 引数からユーザー情報を受け取れるようにする
  AuthComplete(this.user);
  // ユーザー情報
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(height: 100, child: UserWelcome(user.uid)),
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                // ログアウト処理
                // 内部で保持しているログイン情報等が初期化される
                // （現時点ではログアウト時はこの処理を呼び出せばOKと、思うぐらいで大丈夫です）
                await FirebaseAuth.instance.signOut();
                UserImage = "";
                // ログイン画面に遷移＋チャット画面を破棄
                await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return Login();
                  }),
                );
              }),
          FooterCreate(),
        ],
      )),
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
      UserImage = imageUrl.toString();
      String? email = user?.email; //email
      return Scaffold(
        appBar: Header(),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                height: 1000,
                child: Column(children: [
                  CircleAvatar(
                    //アイコン
                    radius: 15,
                    backgroundImage: imageUrl != null
                        ? NetworkImage(imageUrl.toString())
                        : null,
                    child: imageUrl == null
                        ? Icon(Icons.account_circle, size: 30)
                        : Container(),
                  ),
                  Text('ようこそ!${name}さん'),
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
                        UserImage = "";
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return Login(); //ログイン画面に戻る
                          }),
                        );
                      }),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyApp(),
                          ));
                    },
                    child: Text(
                      "トップページへ",
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
                ])),
            FooterCreate(),
          ],
        )),
      );
    } else {
      return Scaffold(appBar: AppBar(/* --- 省略 --- */), body: Center());
    }
  }
}

Widget UserWelcome(userId) {
  return StreamBuilder<QuerySnapshot>(

      //表示したいFiresotreの保存先を指定
      stream: UserData(userId),

      //streamが更新されるたびに呼ばれる
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //データが取れていない時の処理
        if (!snapshot.hasData) return const Text('Loading...');

        final result = snapshot.data!.docs[0];

        UserImage = result['user_icon'];

        return Container(
          // margin: EdgeInsets.only(right: 20),
          child: Column(children: [
            ElevatedButton(
              //ユーザーアイコン
              style: ElevatedButton.styleFrom(shape: CircleBorder()),
              child: ClipOval(
                  child: Image(
                width: 85,
                image: NetworkImage((result['user_icon'] == "")
                    ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf'
                    : result['user_icon']),
                fit: BoxFit.contain,
              )),
              onPressed: () {}, //ユーザーへ
            ),
            Text('ようこそ！${result['user_name']}さん'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ));
              },
              child: Text(
                "トップページへ",
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
          ]),
        );
      });
}

Stream<QuerySnapshot> UserData(String id) {
  return FirebaseFirestore.instance
      .collection('account')
      .where('user_id', isEqualTo: id)
      .snapshots();
}
