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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List image=['first','second','third'];
  List title=['総合評価','お菓子'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container( 
                      padding: EdgeInsets.all(15),
                      child:Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BreadCrumb( //パンくずリスト
                                items: <BreadCrumbItem>[
                                  BreadCrumbItem(content: Text('Top')),
                                  BreadCrumbItem(content: Text('検索結果')),
                                  BreadCrumbItem(content: Text('商品詳細')),
                                ],
                                divider: Icon(Icons.chevron_right),
                              ),
                              ElevatedButton( //絞り込みボタン
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
                            ],
                          ),
                          for(int cnt=0;cnt<2;cnt++)
                          Container(  
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(title[cnt],style: TextStyle(fontSize: 23)),
                                    TextButton(//もっと見るボタン
                                      onPressed: (){},
                                      child: Text('もっと見る',style: TextStyle(color: Colors.black),)
                                    )
                                  ],
                                ),
                                SpaceBox.height(10),
                                Row(  
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    for(int cardcnt=0;cardcnt<3;cardcnt++)
                                    Card(
                                      child:  InkWell(  
                                        onTap:(){
                                          setState(() {});  //商品詳細ページへ
                                        },
                                        child: Container(
                                          child: Stack( //順位とカード内容を被せる
                                            children: [
                                              Container(  //順位画像
                                                height: 40, 
                                                width: 40,  
                                                child: Image.asset('images/icon/'+image[cardcnt]+'.png'),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(10),
                                                child:
                                                Column(
                                                  children: [
                                                    Container(  //商品画像
                                                      height: 100,
                                                      child: Align(alignment: Alignment.center,child: Image.network('https://images-na.ssl-images-amazon.com/images/I/71tcgatTdML._AC_SL1500_.jpg'),),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('グリコ'), //メーカー名
                                                        Text('つぶつぶいちごポッキー'), //商品名
                                                        Row(  //星評価
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
                                                                RichText( //気になる数
                                                                  text: TextSpan(style: TextStyle(color: Colors.black), 
                                                                    children: [
                                                                      TextSpan( text: '1', style: TextStyle(fontWeight: FontWeight.w800,color: HexColor('EC9361'))),
                                                                      TextSpan(text: '気になる')
                                                                    ]
                                                                  )
                                                                ),
                                                                RichText( //リピート数
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
                                                            ElevatedButton(   //クリップボタン
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
                              ],
                            ),
                          )
                        ],
                      )
                    )
                  ),
                  Expanded(flex: 2, child: Text('広告'))
                ],
              )
            ],
          )
        )
      )
    );
  }
}
