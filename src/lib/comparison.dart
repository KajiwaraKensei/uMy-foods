import 'package:flutter/material.dart';
import 'package:multi_charts/multi_charts.dart';

class Comparison extends StatelessWidget {
  bool darkMode = false;
  bool useSides = false;
  double numberOfFeatures = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('images/logo.png',width: 50,height: 50,),
        backgroundColor: HexColor('F5F3EF'),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child:
      ListView( 
        children: [
          Padding(padding: EdgeInsets.only(bottom: 10) ,child: Text('トップ＞比較'),),
          SingleChildScrollView( // SingleChildScrollViewで子ウィジェットをラップ
            scrollDirection: Axis.horizontal, // スクロールの向きを水平方向に指定
            child:Row(
                children: [
                  myContainer(color: Colors.blue, text: 'list'),
                  for (var ccnt = 0; ccnt < 5; ccnt++) 
                    myContainer(color: Colors.orange,text: 'contents'),
                ],
              ),
          ),
        ]),
      )
    );
  }

  Widget myContainer({double size = 300, required Color color, String text = ''}) {
    var slist = ["商品名", "商品画像", "総合評価", "ランキング","リピートしたい",
    "気になる","コスパ","味覚","原材料","アレルギー","栄養成分表示","メーカー",
    "参考価格","内容量","ブランド","発売日"]; 

    return Container(
      color: color,
      width: size,
      height: 630,
      child: Column(
        children: [ 
          Table(
          border: TableBorder.all(),
          children: [
          for (var rcnt = 0; rcnt  < 16; rcnt ++)
            TableRow(children: [  //height通常20
              if(text=='list')
                if(rcnt==1)
                  Container(
                    child: Center(child: Text(slist[rcnt ],style: TextStyle(color: HexColor('616161')))),
                    color: HexColor('ffdfc5'),
                    height: 150,
                  )
                else if(rcnt==7)
                  Container(
                    child: Center(child: Text(slist[rcnt ],style: TextStyle(color: HexColor('616161')))),
                    color: HexColor('ffdfc5'),
                    height: 200,
                  )
                else
                    Container(
                      child: Center(child: Text(slist[rcnt ],style: TextStyle(color: HexColor('616161')))),
                      color: HexColor('ffdfc5'),
                  )
              else if(text=='contents')
                if (rcnt==1)  //商品画像
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Center(
                        child:Image.network('https://images-na.ssl-images-amazon.com/images/I/81h8Q1-sEKL._AC_SL1500_.jpg')
                      ) 
                    ),
                    height: 150,
                    width: 200,
                    color: Colors.white,
                  )
                  else if (rcnt==7) //レーダーチャート
                    Container(
                      width: 200,
                      height: 200,
                      color: Colors.white,
                      //Radar Chart
                      child: RadarChart(
                        values: [1, 2, 4, 7, 9, 0, 6],
                        labels: [
                          "甘味",
                          "酸味",
                          "塩味",
                          "苦味",
                          "辛味",
                          "刺激",
                          "うま味",
                        ],
                        maxValue: 10,
                        fillColor: Colors.blue,
                        chartRadiusFactor: 0.7,
                      ),
                    )
                  else
                    Container(
                      child: Center(child: Text('テキスト',style: TextStyle( color: Colors.black))),
                      color: Colors.white,
                    )
            ])
        ],),
        // child: Text(
        //   text,
        //   style: TextStyle(
        //       fontSize: 48,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.white
        //   ),
        // ),
      ]),
    );
  }
}

//16進数カラーコード
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
