import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'uMy Foods',
      home: const MyHomePage(title: 'Flutter デモページ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, String this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Widget buildTaskList(String path) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection(path)
        .orderBy('review_postdate', descending: true) //投稿日時を降順
        .limit(4) //取得件数
        .snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) {
        return const Center(
          child: const CircularProgressIndicator(),
        );
      }
      if (snapshot.hasError) {
        return const Text('Something went wrong');
      }
      return ListView(
        children: snapshot.data.docs.map((DocumentSnapshot document) {
          final data = document.data() as Map<String, dynamic>;
          return Card(
            child: ListTile(
              title: Text(' ${data['review_comment']}'),
            ),
          );
        }).toList(),
      );
    },
  );
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Row(children: [])),
        body: Center(
          child: Column(
            children: <Widget>[
              Flexible(
                child: buildTaskList('review/'),
              ),
            ],
          ),
        ));
  }
}
