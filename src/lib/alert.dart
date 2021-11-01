import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:umy_foods/HexColor.dart';
import 'package:umy_foods/login/signup.dart';
import 'package:umy_foods/login/login.dart';

class LoginAlert extends StatefulWidget {
  @override
  _LoginAlertState createState() => _LoginAlertState();
}

class _LoginAlertState extends State<LoginAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text('このサービスをご利用になるにはアカウントの登録、ログインが必要です。'),
      actions: <Widget>[
        FlatButton(
          child: Text('戻る'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text('新規登録'),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Signup(),
                ));
          },
        ),
        FlatButton(
          child: Text('ログイン画面へ'),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ));
          },
        ),
      ],
    );
  }
}
