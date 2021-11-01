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

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; //DB

defaultClipAddButton(String product_id, String product_name, String image_url) {
  return Tooltip(
    message: 'クリップボードに保存します',
    child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final user = FirebaseAuth.instance.currentUser;
            final data = user?.uid;
            if (data != null) {
              String uid = data.toString();
              return ElevatedButton(
                //クリップボタン
                child: Icon(
                  Icons.assignment_turned_in,
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(12),
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
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("/account/" + uid + "/clip_list")
                      .doc(product_id)
                      .set({
                    'product_name': product_name,
                    'image_url': image_url,
                    'product_id': product_id,
                  });
                },
              );
            }
          }
          return ElevatedButton(
              //クリップボタン
              child: Icon(
                Icons.assignment_turned_in,
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(12),
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
                final snapshot = FirebaseAuth.instance.currentUser;
                if (snapshot == null) {
                  return showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return LoginAlert();
                    },
                  );
                }
              });
        }),
  );
}
