import 'dart:math';

import 'package:flutter/material.dart';
// パッケージ
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';    //パンくず
// 外部ファイル
import 'package:workspace/Filtering.dart';  //フィルタリングポップアップ
import 'package:workspace/HexColor.dart';   //16進数カラーコード
import 'package:workspace/SpaceBox.dart';   //空間
import 'package:workspace/star.dart';   //星評価


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Ranking_detailsPage(),
    );
  }
}

class Ranking_detailsPage extends StatefulWidget {
  @override
  _Ranking_detailsPageState createState() => _Ranking_detailsPageState();
}

class _Ranking_detailsPageState extends State<Ranking_detailsPage> {

  List image=['first','second','third'];

  bool switchBool = false;

  void _onPressedStart(){ //昇順降順の判定
    setState((){switchBool = !switchBool;});
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 40),
          child: ListView(
            children: [
              BreadCrumb(
                items: <BreadCrumbItem>[
                  BreadCrumbItem(
                    content: GestureDetector(
                      child: Text('パン'),
                      onTap: (){
                        setState(() {});
                      },
                    )
                  ),
                  BreadCrumbItem(
                    content: GestureDetector(
                      child: Text('くず'),
                      onTap: (){
                        setState(() {});
                      },
                    )
                  ),
                ],
                divider: Icon(Icons.chevron_right),
              ),
              SpaceBox.height(20),
              Row(
                children: [ 
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BreadCrumb(
                              items: <BreadCrumbItem>[
                                BreadCrumbItem(content: Text('飲料水',style: TextStyle(fontSize: 23))),
                                BreadCrumbItem(content: Text('炭酸飲料',style: TextStyle(fontSize: 23))),
                                BreadCrumbItem(content: Text('サイダー',style: TextStyle(fontSize: 23))),
                              ],
                              divider: Icon(Icons.chevron_right),
                            ),
                            Row(
                              children:[
                                ElevatedButton(
                                  child: const Text('絞り込み'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    onPrimary: HexColor('EC9361'),
                                    side:BorderSide(color: HexColor('EC9361')),
                                  ),
                                  onPressed: () async {
                                    setState(() {});
                                    return showDialog<void>(
                                      context: context,
                                      barrierDismissible: true, // user must tap button!
                                      builder: (BuildContext context) {
                                        return Details_FilteringDialog();
                                      }
                                    );
                                  }
                                ),
                                if (switchBool) 
                                  Container(
                                    child: Transform.rotate(
                                      child: TextButton(
                                        child: Icon(Icons.sort_outlined,color: HexColor('FFDFC5'),size: 50,),
                                        onPressed: _onPressedStart,
                                      ),
                                      angle: pi/1),
                                  )
                                else 
                                  TextButton(
                                    child: Icon(Icons.sort_outlined,color: HexColor('FFDFC5'),size: 50,),
                                    onPressed: _onPressedStart
                                  )
                              ]
                            )
                          ],
                        ),
                        for (int x = 0; x < 3; x++)
                          Row(
                            children: [
                              for (int i = 0 + (x * 4); i < 4 * (x + 1); i++)
                                Container(
                                  child:Row(
                                    children: [
                                      SpaceBox.width(23),
                                      Card(
                                        child:  InkWell(
                                          onTap:(){
                                            setState(() {});
                                          },
                                          child: Container(
                                            child: Stack(
                                              children: [
                                                if((i+x)<3)
                                                  Container(
                                                    height: 40,
                                                    width: 40,
                                                    child: Image.asset('images/icon/'+image[i]+'.png'),
                                                  )
                                                else 
                                                  Text((i+1).toString(),style: TextStyle(fontSize: 20 ,color: Colors.grey),),
                                                Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child:Column(
                                                    children: [
                                                      Container(
                                                        height: 100,
                                                        child: Align(alignment: Alignment.center,child: Image.network('https://images-na.ssl-images-amazon.com/images/I/71tcgatTdML._AC_SL1500_.jpg'),),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('グリコ'),
                                                          Text('つぶつぶいちごポッキー'),
                                                          Row(
                                                            children: [
                                                              star(3,25),
                                                              Text('500',style: TextStyle(color: HexColor('EC9361'),fontSize: 12))
                                                            ],
                                                          ),
                                                            Row(
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  RichText(
                                                                    text: TextSpan(style: TextStyle(color: Colors.black),
                                                                      children: [
                                                                        TextSpan( text: '1', style: TextStyle(fontWeight: FontWeight.w800,color: HexColor('EC9361'))),
                                                                        TextSpan(text: '気になる')
                                                                      ]
                                                                    )
                                                                  ),
                                                                  RichText(
                                                                    text: TextSpan(style: TextStyle(color: Colors.black),
                                                                      children: [
                                                                        TextSpan( text: '100', style: TextStyle(fontWeight: FontWeight.w800,color: HexColor('EC9361'))),
                                                                        TextSpan(text: 'リピート')
                                                                      ]
                                                                    )
                                                                  )
                                                                ],
                                                              ),
                                                              SpaceBox.width(10),
                                                              ElevatedButton(
                                                                child: Icon(Icons.assignment_turned_in,),
                                                                style: ElevatedButton.styleFrom(
                                                                  padding: EdgeInsets.all(15),
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
                                                                onPressed: () {},
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                )
                            ],
                          ),
                          SpaceBox.height(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 35,
                                height: 50,
                                child: ElevatedButton(
                                  child: Text('1',style: TextStyle(fontSize: 20),),
                                    style: ElevatedButton.styleFrom(
                                      primary: HexColor('EC9361'),
                                      onPrimary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {},
                                ),
                              ),
                              TextButton(
                                child: const Text('>',style: TextStyle(fontSize: 40),),
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          )
                      ],
                    )
                  ),
                  Expanded(
                    flex: 2,
                    child: Text('広告')
                  ),
                ]
              )
            ],
          )
        )
      ),
    );
  }
}