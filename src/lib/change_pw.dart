import 'package:flutter/material.dart';
import 'package:umy_foods/header.dart';
import 'package:umy_foods/footer.dart';
import 'package:umy_foods/HexColor.dart';

class ChangePw extends StatefulWidget {
  @override
  _ChangePwState createState() => _ChangePwState();
}

class _ChangePwState extends State<ChangePw> {
  var _oldpassword = TextEditingController();
  var _newpassword = TextEditingController();
  var _newpasswordcon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FooterCreate(),
          ],
        ),
      ),
    );
  }
}
