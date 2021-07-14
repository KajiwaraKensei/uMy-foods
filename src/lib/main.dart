import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://www.ministop.co.jp/syohin/js/recommend.json'));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  final String title;
  // final String Dnt;
  final String region;
  final String link;
  // final bool syohin;
  // final String release;
  // final String price;
  // final String title;
  // final String image;

  Album({
    required this.title,
    required this.region,
    required this.link,
    // required this.syohin,
    // required this.release,
    // required this.price,
    // required this.title,
    // required this.image,
  });

  factory Album.fromJson(List<dynamic> json) {
    return Album(
        title: json[0]['title'],
        region: json[0]['region'],
        link: json[0]['link']
        // syohin: json['new'],
        // release: json['release'],
        // price: json['price'],
        // title: json['title'],
        // image: json['image'],
        );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APIデータ表示',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('APIデータ表示'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data!);
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                print("tetstsaateat");
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
