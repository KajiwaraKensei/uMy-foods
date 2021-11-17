import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:umy_foods/HexColor.dart';
import 'package:umy_foods/alert.dart';
import 'package:umy_foods/comparison.dart';
import 'package:umy_foods/login/signup.dart';
import 'package:umy_foods/main.dart';
import 'package:umy_foods/alert.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; //レスポンシブ

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; //DB

defaultClipAddButton(String product_id, String product_name, String image_url) {
  return Tooltip(
      message: '比較リストに保存します',
      child: ElevatedButton(
        //クリップボタン
        child: Icon(Icons.assignment_turned_in, size: 24.sp),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(12.sp),
          primary: HexColor('EC9361'),
          onPrimary: Colors.white,
          shape: CircleBorder(
            side: BorderSide(
              color: Colors.transparent,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
        ),
        onPressed: () async {
          final user = await FirebaseAuth.instance.currentUser;
          final userId = user?.uid.toString();

          if (user != null) {
            FirebaseFirestore.instance
                .collection("/account/" + userId! + "/clip_list")
                .doc(product_id)
                .set({
              'product_name': product_name,
              'image_url': image_url,
              'product_id': product_id,
            });
          } else {
            // return showDialog<void>(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return LoginAlert();
            //   },
            // );
          }
        },
      ));


}
