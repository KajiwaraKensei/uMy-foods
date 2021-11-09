import 'package:flutter/material.dart';
import 'package:umy_foods/HexColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';//レスポンシブ

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
          padding: EdgeInsets.fromLTRB(30.h, 30.w, 30.h, 30.w),
          child: Center(
            child: Column(
              children: [
                Text(uid),
                Text(
                  '登録内容の確認',
                  style: TextStyle(
                    color: HexColor('8c6e63'),
                    fontSize: 25.sp,
                    // 文字の太さ
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  width: 750.w,
                  height: 200.h,
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
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          '　メールアドレス　：　' + address,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          '　ユーザー名　　　：　' + username,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  width: 240.w,
                  height: 40.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "確認用メールを送信",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: HexColor('ec9463'), //ボタンの背景色
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40.h),
                  width: 80.w,
                  height: 30.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "戻る",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
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
