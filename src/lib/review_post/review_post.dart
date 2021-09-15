import 'package:flutter/material.dart';
// パッケージ
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';    //パンくず
// 外部ファイル
import 'package:workspace/HexColor.dart';   //16進数カラーコード
import 'package:workspace/SpaceBox.dart';   //空間

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
      home: ReviewPostPage(),
    );
  }
}

class ReviewPostPage extends StatefulWidget {
  @override
  _ReviewPostPageState createState() => _ReviewPostPageState();
}

class _ReviewPostPageState extends State<ReviewPostPage> {
  //表示非表示判定
  final List<int> _comprehensive = [];
  int comprehensive_star=3;

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 40),
          child: ListView(
            children: [
              BreadCrumb( //パンくずリスト
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10,bottom: 25),
                            child:Row(
                              children: [
                                Container(  //商品画像
                                  height: 100,
                                  child: Align(alignment: Alignment.center,child: Image.network('https://m.media-amazon.com/images/I/71ruN8P3IgL._AC_SL1500_.jpg'),),
                                ),
                                SpaceBox.width(100),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SelectableText('アサヒ飲料株式会社',style: TextStyle(fontSize: 16),scrollPhysics: NeverScrollableScrollPhysics()),
                                    SelectableText('ウィルキンソン タンサン 炭酸水 500ml×24本',style: TextStyle(fontSize: 22),scrollPhysics: NeverScrollableScrollPhysics())
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText('評価',style: TextStyle(fontSize: 16,color: HexColor('EC9361')),scrollPhysics: NeverScrollableScrollPhysics()),
                                SpaceBox.height(20),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: SelectableText('総合評価',style: TextStyle(fontSize: 16),scrollPhysics: NeverScrollableScrollPhysics()),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Row(
                                        children: [
                                          TextButton(
                                            child: Icon(
                                              Icons.star_outlined,
                                            ),
                                            style: TextButton.styleFrom(
                                              primary: _comprehensive.contains(1) ? Colors.yellow : Colors.grey,
                                            ),
                                            onPressed: (){
                                              setState(() {
                                                if (_comprehensive.contains(1)) {
                                                  _comprehensive.remove(1);
                                                } else {
                                                  // 選択されたらリストに追加する
                                                  comprehensive_star=1;
                                                  _comprehensive.add(1);
                                                }
                                              });
                                            },
                                          ),
                                            TextButton(
                                            child: Icon(
                                              Icons.star_outlined,
                                            ),
                                            style: TextButton.styleFrom(
                                              primary: _comprehensive.contains(2) ? Colors.yellow : Colors.grey,
                                            ),
                                            onPressed: (){
                                              setState(() {
                                                if (_comprehensive.contains(2)) {
                                                  _comprehensive.remove(2);
                                                } else {
                                                  // 選択されたらリストに追加する
                                                  comprehensive_star=2;
                                                  _comprehensive.add(2);
                                                }
                                              });
                                            },
                                          )
                                        ],
                                      )
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: SelectableText('コスパ',style: TextStyle(fontSize: 16),scrollPhysics: NeverScrollableScrollPhysics()),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child:Text('')
                                    ),
                                  ],
                                )
                              ],
                            )
                          )
                        ],
                      ),
                    )
                  ),
                  Expanded(flex: 2, child: Text('広告'))
                ]
              )
            ]
          )
        )
      ),
    );
  }
}