import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';  //font_awesome
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';    //パンくず
import 'package:workspace/HexColor.dart';   //16進数カラーコード
import 'package:percent_indicator/percent_indicator.dart';  //割合棒グラフ

//色変わるボタン
class Details extends StatefulWidget {
  @override
  _DetailspState createState() => _DetailspState();
}

class _DetailspState extends State<Details> {
  
  var star=['★☆☆☆☆','★★☆☆☆','★★★☆☆','★★★★☆','★★★★★'];
  var plist=['商品名','メーカ名','ブランド名','発売日','内容量'];
  var pinfo=['三ツ矢サイダー レモラ','アサヒ飲料','三ツ矢サイダー','2021/04/11','500ml、1.5L'];

  List<bool> _selections = List.generate(1, (_) => false);
  List<bool> _selections1 = List.generate(1, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('images/logo.png',width: 50,height: 50,),
        backgroundColor: HexColor('F5F3EF'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ListView(children: [
            //詳細情報
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              height: constraints.maxHeight *2,
              width: MediaQuery.of(context).size.width ,
              // color: Colors.indigo,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child:BreadCrumb(
                      items: <BreadCrumbItem>[
                        BreadCrumbItem(content: Text('Top')),
                        BreadCrumbItem(content: Text('検索結果')),
                        BreadCrumbItem(content: Text('商品詳細')),
                      ],
                      divider: Icon(Icons.chevron_right),
                    ),
                  ),
                  SpaceBox.height(16),
                  Row(
                    children: [
        // 左
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: constraints.maxHeight*1.8,
                          padding: EdgeInsets.all(5),
                          // color: Colors.pink,
                          child: Column(
                            children: [
                              //商品名　リピート・レビュー数
                              Container(
                                height: 74,
                                // color: Colors.white,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child:Container(
                                        child: Text('三ツ矢サイダー レモラ',style: TextStyle(fontSize: 27.0,)),
                                        // color: Colors.grey,
                                      )
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child:Container(
                                        child: Row(
                                          children: [
                                            SpaceBox.width(5),
                                            Icon(FontAwesomeIcons.sync,color: Colors.grey,size: 20,),
                                            Text('100',style: TextStyle(color: HexColor('#EC9361'),fontWeight: FontWeight.w900,) ),
                                            SpaceBox.width(20),
                                            Icon(Icons.rate_review,color: Colors.grey,size: 30),
                                            Text('100',style: TextStyle(color: HexColor('#EC9361'),fontWeight: FontWeight.w900,) ),
                                          ],
                                        ),
                                      )
                                    ),
                                ],),
                              ),
                              //商品画像
                              Container(
                                height: 454,
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 330,
                                      child: Image.network('https://images-na.ssl-images-amazon.com/images/I/81h8Q1-sEKL._AC_SL1500_.jpg'),
                                    ),
                                    Container(
                                      height: 104,
                                    )
                                  ],
                                ),
                              ),
                              //気になるボタン
                              Container(
                                height: 70,
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.zero,
                                    decoration: BoxDecoration(
                                      color: HexColor('FFDFC5'),
                                      border: Border.all(color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    ),
                                    child: ToggleButtons(
                                      color: HexColor('616161'),  //文字色
                                      selectedColor: Colors.white,     //押したときの文字色
                                      selectedBorderColor: HexColor('EC9361'),    //押したときの枠
                                      fillColor: HexColor('EC9361'), //押したときの背景
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                          child: Row(
                                            children: [
                                              Icon(FontAwesomeIcons.exclamation,size: 15,),
                                              SpaceBox.width(15),
                                              Text('気になる (435)') 
                                            ],
                                          )
                                        )
                                      ],
                                      isSelected: _selections,
                                      onPressed: (int index) {
                                        setState(() {
                                          _selections[index] = !_selections[index];
                                        });
                                      },
                                    ),
                                  )
                                  
                                ),
                              ),


                          ],)
                        ,)
                      ),
          //右
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: constraints.maxHeight*1.8,
                          padding: EdgeInsets.all(5),
                          // color: Colors.purple,
                          child: Column(
                            children: [
                              //SNS、スパナ
                              Container(
                                height: 74,
                                // color: Colors.amber,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: const Icon(FontAwesomeIcons.wrench,color: Colors.grey,size: 20,),
                                          onPressed: () {},
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        // color: Colors.cyan,
                                        child: Row(
                                          children: [
                                            SpaceBox.width(20),
                                            Ink(
                                              decoration: const ShapeDecoration(
                                                color: Colors.lightBlue,
                                                shape: CircleBorder(),
                                              ),
                                              child: IconButton(
                                                icon: const Icon(FontAwesomeIcons.twitter,color: Colors.white,size: 20,),
                                                color: Colors.white,
                                                onPressed: () {},
                                              ),
                                            ),
                                            SpaceBox.width(5),
                                            Ink(
                                              decoration: const ShapeDecoration(
                                                color: Colors.brown,
                                                shape: CircleBorder(),
                                              ),
                                              child: IconButton(
                                                icon: const Icon(FontAwesomeIcons.instagram,color: Colors.white,size: 20,),
                                                color: Colors.white,
                                                onPressed: () {},
                                              ),
                                            ),
                                            SpaceBox.width(5),
                                            Ink(
                                              decoration: const ShapeDecoration(
                                                color: Colors.indigo,
                                                shape: CircleBorder(),
                                              ),
                                              child: IconButton(
                                                icon: const Icon(FontAwesomeIcons.facebook,color: Colors.white,size: 20,),
                                                color: Colors.white,
                                                onPressed: () {},
                                              ),
                                            ),
                                          ],),
                                      )
                                    ),
                                  ],
                                ),
                              ),
                              //総合評価
                              Container(
                                height: 74,
                                // color: Colors.white,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child:Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child:Text('総合評価')
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child:Text(star[4],style: TextStyle(color: HexColor('ffe14c'),fontSize: 30))
                                          )
                                      ],)
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child:Text('コスト')
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child:Text(star[2],style: TextStyle(color: HexColor('ffe14c'),fontSize: 30))
                                          )
                                      ],)
                                    ),
                                  ],
                                ),
                              ),
                              // 商品情報
                              Container(
                                // color: Colors.orange,
                                height: 200,
                                child:Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child:Text('商品情報',style: TextStyle(fontSize: 20),),
                                    ),
                                    SpaceBox.height(10),
                                    Table(
                                      columnWidths: const <int, TableColumnWidth>{
                                        0: FlexColumnWidth(0.6),
                                        1: FlexColumnWidth(1.0),
                                      },
                                      children: [
                                        for(int i=0;i<5;i++)
                                          TableRow(
                                            children: [
                                            Text(plist[i]),
                                            Text(pinfo[i]),
                                            SpaceBox.height(30),
                                          ]),
                                      ],
                                    )
                                ],) 
                              ),
                              // 購入情報
                              Container(
                                height: 180,
                                color: HexColor('E0E0E0'),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child:Container(
                                        child: Text('購入情報'),
                                      )
                                    ),
                                ],),
                              ),

                              //リピートボタン
                              Container(
                                height: 70,
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.zero,
                                    decoration: BoxDecoration(
                                      color: HexColor('FFDFC5'),
                                      border: Border.all(color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    ),
                                    child: ToggleButtons(
                                      color: HexColor('616161'),  //文字色
                                      selectedColor: Colors.white,     //押したときの文字色
                                      selectedBorderColor: HexColor('EC9361'),    //押したときの枠
                                      fillColor: HexColor('EC9361'), //押したときの背景
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                          child: Row(
                                            children: [
                                              Icon(FontAwesomeIcons.sync,size: 15,),
                                              SpaceBox.width(15),
                                              Text('リピート (435)') 
                                            ],
                                          )
                                        )
                                      ],
                                      isSelected: _selections1,
                                      onPressed: (int index) {
                                        setState(() {
                                          _selections1[index] = !_selections1[index];
                                        });
                                      },
                                    ),
                                  )
                                ),
                              ),
                              //気になる・リピートの年代割合

                              Container(
                                height: 300,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                // color: Colors.white,
                                child: Center(
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('この商品を「気になる」しているユーザーの年代'),
                                      ),
                                      Table(
                                        children: [
                                          TableRow(
                                            children: [
                                              percent_indicator(0.4,'10代'),
                                              percent_indicator(0.5,'20代'),
                                            ]
                                          ),
                                          TableRow(
                                            children: [
                                              percent_indicator(0.2,'30代'),
                                              percent_indicator(0.8,'40代'),
                                            ]
                                          )
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('この商品を「リピート」しているユーザーの年代'),
                                      ),
                                      Table(
                                        children: [
                                          TableRow(
                                            children: [
                                              percent_indicator(0.1,'10代'),
                                              percent_indicator(0.2,'20代'),
                                            ]
                                          ),
                                          TableRow(
                                            children: [
                                              percent_indicator(0.9,'30代'),
                                              percent_indicator(0.2,'40代'),
                                            ]
                                          )
                                        ],
                                      ),
                                      
                                    ],
                                  )
                                    
                                    
                                
                                )
                              )


                          ],),
                        )
                      )
                  ],)
                ],
              ),
            ),
            //仕切り線
            const Divider(
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 20,
            ),
            //レビュー部分
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              height: constraints.maxHeight ,
              width: MediaQuery.of(context).size.width ,
              color: Colors.blue,
              child: Text('review部分'),
            )
          ],);
        },
      ),
    );
  }

  Widget percent_indicator(double persent,String age) {
    double persentsub=persent*100; //パーセントを100表示
    String persenttext=persentsub.toString(); //パーセントを文字化

    return Padding(
      padding: EdgeInsets.all(15.0),
      child: new LinearPercentIndicator(
        width: 140.0,
        lineHeight: 14.0,
        percent: persent,
        center: Text(
          persenttext+'%',
          style: new TextStyle(fontSize: 12.0),
        ),
        leading: Text(age),
        linearStrokeCap: LinearStrokeCap.roundAll,
        backgroundColor: HexColor('E0E0E0'),
        progressColor: HexColor('FFDF4C'),
      ),
    );
  }
}

class SpaceBox extends SizedBox {
  SpaceBox({double width = 8, double height = 8})
      : super(width: width, height: height);

  SpaceBox.width([double value = 8]) : super(width: value);
  SpaceBox.height([double value = 8]) : super(height: value);
}