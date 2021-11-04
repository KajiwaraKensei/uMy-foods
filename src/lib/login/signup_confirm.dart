import 'package:flutter/material.dart';
import 'package:umy_foods/HexColor.dart';

class Signup_Confirm extends StatelessWidget {
  // 値を受け取る
  Signup_Confirm({
    Key? key,
    required this.address,
    required this.username,
    required this.newcreate,
    required this.uid,
  }) : super(key: key);

  final String address;
  final String username;
  final String newcreate;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('F5F3EF'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
          child: Center(
            child: Column(
              children: [
                Text(uid),
                Text(
                  '登録内容の確認',
                  style: TextStyle(
                    color: HexColor('8c6e63'),
                    fontSize: 25,
                    // 文字の太さ
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  width: 750,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: HexColor('EC9361'),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          '　メールアドレス　：　' + address,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          '　ユーザー名　　　：　' + username,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: 240,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "確認用メールを送信",
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
                Container(
                  margin: EdgeInsets.only(top: 40),
                  width: 80,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "戻る",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
