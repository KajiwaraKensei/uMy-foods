import 'package:flutter/material.dart';
import 'package:workspace/HexColor.dart';   //16進数カラーコード
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:workspace/SpaceBox.dart'; //年代別レビュー

//性別のフィルタリング表示
class Gender_FilteringDialog extends StatefulWidget {
  @override
  _Gender_FilteringDialogState createState() => _Gender_FilteringDialogState();
}

class _Gender_FilteringDialogState extends State<Gender_FilteringDialog> {

  bool male = false;
  bool woman = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('絞り込み',style: TextStyle(color: HexColor('EC9361'),fontWeight: FontWeight.w900 )),
      content: Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * .6,
        color: HexColor('f5f3ef'),
        child:Table(children: [
          TableRow(
            children: [
              CheckboxListTile(
                value: male,
                title: Text('男性'),
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    male = value!;
                  });
                },
              ),
              CheckboxListTile(
                value: woman,
                title: Text('女性',),
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    woman = value!;
                  });
                },
              ),
            ]),
          ],
        )
      ),
      actions: <Widget>[
        Center(
          child: OutlinedButton(
            child: const Text('OK'),
            style: TextButton.styleFrom(
              primary:HexColor('EC9361'),
              side: BorderSide(color: HexColor('EC9361')),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}

//メーカー、ブランド、カテゴリーのフィルタリング表示
class Details_FilteringDialog extends StatefulWidget {
  @override
  _Details_FilteringDialogState createState() => _Details_FilteringDialogState();
}

class _Details_FilteringDialogState extends State<Details_FilteringDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('絞り込み',style: TextStyle(color: HexColor('EC9361'),fontWeight: FontWeight.w900 )),
      content: Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * .6,
        color: HexColor('f5f3ef'),
        child: ContainedTabBarView(
          tabBarProperties: TabBarProperties(
            padding: const EdgeInsets.symmetric(
              vertical: 3.0,
            ),
            indicator: ContainerTabIndicator(
              radius: BorderRadius.circular(16.0),
              color: HexColor('FFDFC5'),
              borderWidth: 2.0,
              borderColor: HexColor('EC9361'),
            ),
            labelColor: HexColor('616161'),
            unselectedLabelColor: HexColor('EC9361'),
          ),
          tabs: [
            Container(child: Text('カテゴリー')),
            Container(child: Text('ブランド')),
            Container(child: Text('メーカー')),
          ],
          views: [
            Container(
              child: Category(),
            ),
            Container(
              child: Brand(),
            ),
            Container(
              child: Maker(),
            ),
          ],
          onChange: (index) => print(index),
        ),
      ),
      actions: <Widget>[
        Center(
          child: OutlinedButton(
            child: const Text('検索'),
            style: TextButton.styleFrom(
              primary:HexColor('EC9361'),
              side: BorderSide(color: HexColor('EC9361')),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        SpaceBox.height(10)
      ],
    );
  }
}
//カテゴリ一覧
class Category extends StatefulWidget {
  @override
  _Category createState() => _Category();
}
class _Category extends State<Category>{
  @override

  final List<List<String>> major_category = [
    ["メジャーカテゴリ1", "001"],
    ["メジャーカテゴリ2", "002"],
    ["メジャーカテゴリ3", "003"],
  ];

  final List<List<String>> category = [
    ["カテゴリ1", "001"],
    ["カテゴリ2", "002"],
    ["カテゴリ3", "003"],
    ["カテゴリ4", "004"],
    ["カテゴリ5", "005"],
    ["カテゴリ6", "006"],
  ];

  final List<List<String>> sub_category = [
    ["サブカテゴリ1", "001"],
    ["サブカテゴリ2", "002"],
    ["サブカテゴリ3", "003"],
    ["サブカテゴリ4", "004"],
    ["サブカテゴリ5", "005"],
    ["サブカテゴリ6", "006"],
    ["サブカテゴリ7", "007"],
    ["サブカテゴリ8", "008"],
    ["サブカテゴリ9", "009"],
    ["サブカテゴリ10", "010"],
    ["サブカテゴリ11", "011"],
    ["サブカテゴリ12", "012"],
  ];

  // 選択された要素のidを保管する
  final List<int> _majorkeep = [];
  final List<int> _childkeep = [];
  final List<int> _grandsonkeep = [];

  //表示非表示判定
  final List<int> _childvisibility = [];
  final List<int> _grandsonvisibility = [];

  //子、孫カテゴリの振り分け
  List category_stoplist=[0,2,4,6];
  List subcategory_stoplist=[0,2,4,6,8,10,12];

  void _majorCheckbox(int index,bool e) {
    setState(() {
      // 選択が解除されたらリストから消す
      if (_majorkeep.contains(index)) {
        _majorkeep.remove(index);
      } else {
        // 選択されたらリストに追加する
        _majorkeep.add(index);
      }
    });
  }

  void _childCheckbox(int index,bool e) {
    setState(() {
      // 選択が解除されたらリストから消す
      if (_childkeep.contains(index)) {
        _childkeep.remove(index);
      } else {
        // 選択されたらリストに追加する
        _childkeep.add(index);
      }
    });
  }
  void _grandsonCheckbox(int index,bool e) {
    setState(() {
      // 選択が解除されたらリストから消す
      if (_grandsonkeep.contains(index)) {
        _grandsonkeep.remove(index);
      } else {
        // 選択されたらリストに追加する
        _grandsonkeep.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: ListView(
      children: [
        GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.clear_outlined,),
              Text('選択を解除'),
              SpaceBox.width(10)
            ],
          ),
          onTap: () {
            setState(() {
              _majorkeep.removeRange(0,_majorkeep.length);
              _childkeep.removeRange(0,_childkeep.length);
              _grandsonkeep.removeRange(0,_grandsonkeep.length);
            });
          },
        ),
        for(int m_cnt=0;m_cnt<major_category.length;m_cnt++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Checkbox(
                    activeColor: Colors.blue,
                    value: _majorkeep.contains(int.parse(major_category[m_cnt][1])),
                    onChanged: (e) {
                        // Card 内のチェックボックスが選択されたら実行
                        _majorCheckbox(int.parse(major_category[m_cnt][1]),e!);
                    },
                  ),
                  GestureDetector(
                    child: Text(major_category[m_cnt][0],style: TextStyle(fontSize: 15),),
                    onTap: () {
                      setState(() {
                        if (_childvisibility.contains(m_cnt)) {
                          _childvisibility.remove(m_cnt);
                        } else {
                          // 選択されたらリストに追加する
                          _childvisibility.add(m_cnt);
                        }
                      });
                    },
                  ),
                ],
              ),
              Visibility(
                visible: !_childvisibility.contains(m_cnt),
                child: SpaceBox.height(15),
              ),
              Visibility(
                visible: _childvisibility.contains(m_cnt),
                child: Column(
                  children: [
                    for(int c_cnt=category_stoplist[m_cnt];c_cnt<category_stoplist[m_cnt+1];c_cnt++)
                      Column(
                        children: [
                          Row(
                            children: [
                              SpaceBox.width(23),
                              Checkbox(
                                activeColor: Colors.blue,
                                value: _childkeep.contains(int.parse(category[c_cnt][1])),
                                onChanged: (e) {
                                    // Card 内のチェックボックスが選択されたら実行
                                    _childCheckbox(int.parse(category[c_cnt][1]),e!);
                                },
                              ),
                              GestureDetector(
                                child: Text(category[c_cnt][0],style: TextStyle(fontSize: 15),),
                                onTap: () {
                                  setState(() {
                                    if (_grandsonvisibility.contains(c_cnt)) {
                                      _grandsonvisibility.remove(c_cnt);
                                    } else {
                                      // 選択されたらリストに追加する
                                      _grandsonvisibility.add(c_cnt);
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                          Visibility(
                            visible: _grandsonvisibility.contains(c_cnt),
                            child: Column(
                              children: [
                                for(int s_cnt=subcategory_stoplist[c_cnt];s_cnt<subcategory_stoplist[c_cnt+1];s_cnt++)
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          SpaceBox.width(46),
                                          Checkbox(
                                            activeColor: Colors.blue,
                                            value: _grandsonkeep.contains(int.parse(sub_category[s_cnt][1])),
                                            onChanged: (e) {
                                                // Card 内のチェックボックスが選択されたら実行
                                                _grandsonCheckbox(int.parse(sub_category[s_cnt][1]),e!);
                                            },
                                          ),
                                          GestureDetector(
                                            child: Text(sub_category[s_cnt][0],style: TextStyle(fontSize: 15),),
                                            onTap: () {
                                              setState(() {
                                                if (_grandsonvisibility.contains(s_cnt)) {
                                                  _grandsonvisibility.remove(s_cnt);
                                                } else {
                                                  // 選択されたらリストに追加する
                                                  _grandsonvisibility.add(s_cnt);
                                                }
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SpaceBox.height(15),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SpaceBox.height(15),
                ])
              ),
            ],
          )
      ],
    )
  );
  }
}
//ブランド一覧
class Brand extends StatefulWidget {
  @override
  _Brand createState() => _Brand();
}
class _Brand extends State<Brand>{
  final List<List<String>> brand = [
    ["ブランド1", "001"],
    ["ブランド2", "002"],
    ["ブランド3", "003"],
  ];

  // 選択された要素のidを保管する
  final List<int> _brandkeep = [];

  void _brandCheckbox(int index,bool e) {
    setState(() {
      // 選択が解除されたらリストから消す
      if (_brandkeep.contains(index)) {
        _brandkeep.remove(index);
      } else {
        // 選択されたらリストに追加する
        _brandkeep.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.clear_outlined,),
                Text('選択を解除'),
                SpaceBox.width(10)
              ],
            ),
            onTap: () {
              setState(() {
                _brandkeep.removeRange(0,_brandkeep.length);
              });
            },
          ),
          for(int m_cnt=0;m_cnt<brand.length;m_cnt++)
            CheckboxListTile(
              activeColor: Colors.blue,
              title: Text(brand[m_cnt][0]),
              controlAffinity: ListTileControlAffinity.leading,
              value: _brandkeep.contains(int.parse(brand[m_cnt][1])),
              onChanged: (e){
                _brandCheckbox(int.parse(brand[m_cnt][1]),e!);
              },
            ),
        ],
      )
    );
  }
}
//メーカー一覧
class Maker extends StatefulWidget {
  @override
  _Maker createState() => _Maker();
}
class _Maker extends State<Maker>{ 
  final List<List<String>> maker = [
    ["メーカー1", "001"],
    ["メーカー2", "002"],
    ["メーカー3", "003"],
  ];

  // 選択された要素のidを保管する
  final List<int> _makerkeep = [];

  void _brandCheckbox(int index,bool e) {
    setState(() {
      // 選択が解除されたらリストから消す
      if (_makerkeep.contains(index)) {
        _makerkeep.remove(index);
      } else {
        // 選択されたらリストに追加する
        _makerkeep.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      body: ListView(
        children: [
          GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.clear_outlined,),
                Text('選択を解除'),
                SpaceBox.width(10)
              ],
            ),
            onTap: () {
              setState(() {
                _makerkeep.removeRange(0,_makerkeep.length);
              });
            },
          ),
          for(int m_cnt=0;m_cnt<maker.length;m_cnt++)
            CheckboxListTile(
              activeColor: Colors.blue,
              title: Text(maker[m_cnt][0]),
              controlAffinity: ListTileControlAffinity.leading,
              value: _makerkeep.contains(int.parse(maker[m_cnt][1])),
              onChanged: (e){
                _brandCheckbox(int.parse(maker[m_cnt][1]),e!);
              },
            ),
        ],
      )
    );
  }
}


