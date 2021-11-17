import 'package:flutter/material.dart';
import 'package:umy_foods/HexColor.dart'; //16進数カラーコード
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart'; //切り替え
import 'package:umy_foods/SpaceBox.dart';

import 'HexColor.dart';
import 'SpaceBox.dart'; //空間

bool male = false;
bool woman = false;
//性別のフィルタリング表示
class Gender_FilteringDialog extends StatefulWidget {
  @override
  _Gender_FilteringDialogState createState() => _Gender_FilteringDialogState();
}

class _Gender_FilteringDialogState extends State<Gender_FilteringDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('絞り込み',
          style: TextStyle(
              color: HexColor('EC9361'), fontWeight: FontWeight.w900)),
      content: Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * .6,
        color: HexColor('f5f3ef'),
        child: Table(
            children: [
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
                title: Text(
                    '女性',
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) {
                    setState(() {
                      woman = value!;
                  });
                },
              ),
              ]),
            ],
        )),
      actions: <Widget>[
        Center(
          child: OutlinedButton(
            child: const Text('OK'),
            style: TextButton.styleFrom(
              primary: HexColor('EC9361'),
              side: BorderSide(color: HexColor('EC9361')),
            ),
            onPressed: () {
              String select = '';
              if (woman == true && male == true) {
                select = '男性,女性';
              } else if (woman == true) {
                select = '女性';
              } else if (male == true) {
                select = '男性';
              }
              Navigator.of(context).pop(select);
            },
          ),
        ),
      ],
    );
  }
}

//メーカー一覧
class Maker_FilteringDialog extends StatefulWidget {
  @override
  Maker_FilteringDialogState createState() => Maker_FilteringDialogState();
}

class Maker_FilteringDialogState extends State<Maker_FilteringDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('メーカー一覧',
          style: TextStyle(
              color: HexColor('EC9361'), fontWeight: FontWeight.w900)),
      content: Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * .6,
        color: HexColor('f5f3ef'),
        child: Maker(),
      ),
      actions: <Widget>[
        Center(
          child: OutlinedButton(
            child: const Text('OK'),
            style: TextButton.styleFrom(
              primary: HexColor('EC9361'),
              side: BorderSide(color: HexColor('EC9361')),
            ),
            onPressed: () {
              Navigator.of(context).pop(_makerkeep); //like_maker（メーカー名を取得）
            },
          ),
        ),
      ],
    );
  }
}


//メーカー、ブランド、カテゴリー（詳細・ランキング）
class Details_FilteringDialog extends StatefulWidget {
  @override
  _Details_FilteringDialogState createState() =>
      _Details_FilteringDialogState();
}

class _Details_FilteringDialogState extends State<Details_FilteringDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('絞り込み',
          style: TextStyle(
              color: HexColor('EC9361'), fontWeight: FontWeight.w900)),
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
            child: Text('検索'),
            style: TextButton.styleFrom(
              primary: HexColor('EC9361'),
              side: BorderSide(color: HexColor('EC9361')),
            ),
            onPressed: () {
              List<String> selected = [];
              String major_category = ' '; //親カテゴリ
              String category = ' '; //子カテゴリ
              String sub_category = ' '; //孫カテゴリ
              String brand = ' '; //ブランド
              String maker = ' '; //メーカー

              //選択された各値を文字列化
              for (int x = 0; x < _majorkeep.length; x++) {
                major_category += _majorkeep[x] + ',';
              }
              selected
                  .add(major_category.substring(0, major_category.length - 1));

              for (int x = 0; x < _childkeep.length; x++) {
                category += _childkeep[x] + ',';
              }
              selected.add(category.substring(0, category.length - 1));

              for (int x = 0; x < _grandsonkeep.length; x++) {
                sub_category += _grandsonkeep[x] + ',';
              }
              selected.add(sub_category.substring(0, sub_category.length - 1));
              for (int x = 0; x < _brandkeep.length; x++) {
                brand += _brandkeep[x] + ',';
              }
              selected.add(brand.substring(0, brand.length - 1));

              for (int x = 0; x < _makerkeep.length; x++) {
                maker += _makerkeep[x] + ',';
              }
              selected.add(maker.substring(0, maker.length - 1));

              Navigator.of(context).pop(selected);
            },
          ),
        ),
        SpaceBox.height(10)
      ],
    );
  }
}

// カテゴリの選択された要素のidを保管する
final List<String> _majorkeep = [];
final List<String> _childkeep = [];
final List<String> _grandsonkeep = [];

class Category extends StatefulWidget {
  @override
  _Category createState() => _Category();
}
class _Category extends State<Category> {

  final List<String> major_category = ['メジャーカテゴリ1'];
  final List<String> category = ['カテゴリ1'];
  final List<String> sub_category = ['サブカテゴリ1'];

  //表示非表示判定
  final List<String> _childvisibility = [];
  final List<String> _grandsonvisibility = [];

  //子、孫カテゴリの振り分け
  List category_stoplist = [0, 2, 4, 6];
  List subcategory_stoplist = [0, 2, 4, 6, 8, 10, 12];

  void _majorCheckbox(String index, bool e) {
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

  void _childCheckbox(String index, bool e) {
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
  void _grandsonCheckbox(String index, bool e) {
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
              Icon(
                Icons.clear_outlined,
              ),
              Text('選択を解除'),
              SpaceBox.width(10)
            ],
          ),
          onTap: () {
            setState(() {
              _majorkeep.removeRange(0, _majorkeep.length);
              _childkeep.removeRange(0, _childkeep.length);
              _grandsonkeep.removeRange(0, _grandsonkeep.length);
            });
          },
        ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Checkbox(
                    activeColor: Colors.blue,
                    value: _majorkeep.contains(major_category[0]),
                    onChanged: (e) {
                        // Card 内のチェックボックスが選択されたら実行
                        _majorCheckbox(major_category[0], e!);
                    },
                  ),
                  GestureDetector(
                    child: Text(
                    major_category[0],
                    style: TextStyle(fontSize: 15),
                  ),
                    onTap: () {
                      setState(() {
                        if (_childvisibility.contains(major_category[0])) {
                        _childvisibility.remove(major_category[0]);
                        } else {
                          // 選択されたらリストに追加する
                          _childvisibility.add(major_category[0]);
                        }
                      });
                    },
                  ),
                ],
              ),
              Visibility(
                visible: !_childvisibility.contains(major_category[0]),
                child: SpaceBox.height(15),
              ),
              Visibility(
                visible: _childvisibility.contains(major_category[0]),
                child: Column(children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              SpaceBox.width(23),
                              Checkbox(
                                activeColor: Colors.blue,
                                value: _childkeep.contains(category[0]),
                                onChanged: (e) {
                                    // Card 内のチェックボックスが選択されたら実行
                                    _childCheckbox(category[0], e!);
                                },
                              ),
                              GestureDetector(
                                child: Text(
                              category[0],
                              style: TextStyle(fontSize: 15),
                            ),
                                onTap: () {
                                  setState(() {
                                    if (_grandsonvisibility.contains(category[0])) {
                                  _grandsonvisibility.remove(category[0]);
                                    } else {
                                      // 選択されたらリストに追加する
                                      _grandsonvisibility.add(category[0]);
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                          Visibility(
                            visible: _grandsonvisibility.contains(category[0]),
                            child: Column(
                              children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          SpaceBox.width(46),
                                          Checkbox(
                                            activeColor: Colors.blue,
                                            value: _grandsonkeep
                                          .contains(sub_category[0]),
                                            onChanged: (e) {
                                                // Card 内のチェックボックスが選択されたら実行
                                                _grandsonCheckbox(sub_category[0], e!);
                                            },
                                          ),
                                          GestureDetector(
                                            child: Text(
                                        sub_category[0],
                                        style: TextStyle(fontSize: 15),
                                      ),
                                            onTap: () {
                                              setState(() {
                                                if (_grandsonvisibility
                                              .contains(sub_category[0])) {
                                            _grandsonvisibility
                                                .remove(sub_category[0]);
                                                } else {
                                                  // 選択されたらリストに追加する
                                                  _grandsonvisibility
                                                .add(sub_category[0]);
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
                ])),
            ],
          )
      ],
    ));
  }
}

// ブランドの選択された要素のidを保管する
final List<String> _brandkeep = [];
class Brand extends StatefulWidget {
  @override
  _Brand createState() => _Brand();
}
class _Brand extends State<Brand> {
  final List<String> brand = [
    'ブランド1',
    'ブランド2',
    'ブランド3',
  ];

  void _brandCheckbox(String index, bool e) {
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
                Icon(
                Icons.clear_outlined,
              ),
              Text('選択を解除'),
              SpaceBox.width(10)
            ],
          ),
          onTap: () {
            setState(() {
                _brandkeep.removeRange(0, _brandkeep.length);
            });
          },
        ),
          for (int m_cnt = 0; m_cnt < brand.length; m_cnt++)
          CheckboxListTile(
            activeColor: Colors.blue,
              title: Text(brand[m_cnt]),
            controlAffinity: ListTileControlAffinity.leading,
              value: _brandkeep.contains(brand[m_cnt]),
            onChanged: (e) {
              _brandCheckbox(brand[m_cnt], e!);
            },
          ),
      ],
      ));
  }
}

// メーカーの選択された要素のidを保管する
final List<String> _makerkeep = [];
class Maker extends StatefulWidget {
  @override
  _Maker createState() => _Maker();
}
class _Maker extends State<Maker> {
  final List<String> maker = [
    'メーカー1',
    'メーカー2',
    'メーカー3',
  ];

  bool test = true;

  void _makerCheckbox(String index, bool e) {
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
                Icon(
                Icons.clear_outlined,
              ),
              Text('選択を解除'),
              SpaceBox.width(10)
            ],
          ),
          onTap: () {
            setState(() {
                _makerkeep.removeRange(0, _makerkeep.length);
            });
          },
        ),
          for (int m_cnt = 0; m_cnt < maker.length; m_cnt++)
          CheckboxListTile(
            activeColor: Colors.blue,
              title: Text(maker[m_cnt]),
            controlAffinity: ListTileControlAffinity.leading,
              value: _makerkeep.contains(maker[m_cnt]),
            onChanged: (e) {
              _makerCheckbox(maker[m_cnt], e!);
            },
          ),
          // for(int c=0;c<_makerkeep.length;c++)
          //   Text(_makerkeep[c].toString()),
        // for(int c=0;c<like_maker.length;c++)
        //   Text(like_maker[c])
        ],
      ));
  }
}

//年代・性別
final List _genderkeep = []; // 選択された要素の性別を保管する
final List _agekeep = []; // 選択された要素の年代を保管する

class GenderAge_FilteringDialog extends StatefulWidget {
  @override
  GenderAge_FilteringDialogState createState() =>
      GenderAge_FilteringDialogState();
}

class GenderAge_FilteringDialogState extends State<GenderAge_FilteringDialog> {
  //表示非表示
  bool gender_flag = false;
  bool age_flag = false;

  void genderageCheckbox(String select, int flag, bool e) {
    setState(() {
      if (flag == 1) {
        // 選択が解除されたらリストから消す
        if (_genderkeep.contains(select)) {
          _genderkeep.remove(select);
        } else {
          // 選択されたらリストに追加する
          _genderkeep.add(select);
        }
      } else if (flag == 2) {
        // 選択が解除されたらリストから消す
        if (_agekeep.contains(select)) {
          _agekeep.remove(select);
        } else {
          // 選択されたらリストに追加する
          _agekeep.add(select);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var media_width = MediaQuery.of(context).size.width; //学校販売PCの場合1280
    var media_height = MediaQuery.of(context).size.height; //学校販売PCの場合609
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('絞り込み',
          style: TextStyle(
              color: HexColor('EC9361'), fontWeight: FontWeight.w900)),
      content: Container(
          padding: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * .6,
          color: HexColor('f5f3ef'),
          child: ListView(
            children: [
              SizedBox(
                //性別ボタン
                height: media_height * 0.06768,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: HexColor('EC9361'),
                    side: BorderSide(color: HexColor('EC9361')),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('性別   '),
                      gender_flag == false
                          ? //押す前は下向き矢印、押されたら上向き矢印
                          Icon(
                              Icons.expand_more_outlined,
                            )
                          : Icon(
                              Icons.expand_less_outlined,
                            ),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      gender_flag = !gender_flag;
                    });
                  },
                ),
              ),
              Visibility(
                  visible: !gender_flag,
                  child: SpaceBox.height(media_height * 0.049)),
              Visibility(
                  //性別ボタンが押されたら出てくる
                  visible: gender_flag,
                  child: Table(
                    children: [
                      TableRow(children: [
                        CheckboxListTile(
                          value: _genderkeep.contains('男性'),
                          title: Text('男性'),
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (e) {
                            setState(() {
                              genderageCheckbox('男性', 1, e!);
                            });
                          },
                        ),
                        CheckboxListTile(
                          value: _genderkeep.contains('女性'),
                          title: Text(
                            '女性',
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (e) {
                            setState(() {
                              genderageCheckbox('女性', 1, e!);
                            });
                          },
                        ),
                      ])
                    ],
                  )),
              Visibility(
                  //スペース
                  visible: gender_flag,
                  child: SpaceBox.height(media_height * 0.049)),
              SizedBox(
                //年代ボタン
                height: media_height * 0.06768,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: HexColor('EC9361'),
                    side: BorderSide(color: HexColor('EC9361')),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('年代   '),
                      age_flag == false
                          ? //押す前は下向き矢印、押されたら上向き矢印
                          Icon(
                              Icons.expand_more_outlined,
                            )
                          : Icon(
                              Icons.expand_less_outlined,
                            ),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      age_flag = !age_flag;
                    });
                  },
                ),
              ),
              Visibility(
                  //年代ボタンが押されると出てくる
                  visible: age_flag,
                  child: Column(children: [
                    Table(
                      children: [
                        TableRow(children: [
                          CheckboxListTile(
                            value: _agekeep.contains('10'),
                            title: Text('10代'),
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (e) {
                              setState(() {
                                genderageCheckbox('10', 2, e!);
                              });
                            },
                          ),
                          CheckboxListTile(
                            value: _agekeep.contains('20'),
                            title: Text('20代'),
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (e) {
                              setState(() {
                                genderageCheckbox('20', 2, e!);
                              });
                            },
                          ),
                        ]),
                        TableRow(children: [
                          CheckboxListTile(
                            value: _agekeep.contains('30'),
                            title: Text('30代'),
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (e) {
                              setState(() {
                                genderageCheckbox('30', 2, e!);
                              });
                            },
                          ),
                          CheckboxListTile(
                            value: _agekeep.contains('40'),
                            title: Text('40代'),
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (e) {
                              setState(() {
                                genderageCheckbox('40', 2, e!);
                              });
                            },
                          ),
                        ]),
                      ],
                    )
                  ]))
            ],
          )),
      actions: <Widget>[
        Center(
          child: OutlinedButton(
            child: const Text('OK'),
            style: TextButton.styleFrom(
              primary: HexColor('EC9361'),
              side: BorderSide(color: HexColor('EC9361')),
            ),
            onPressed: () {
              String age = ' '; //スペース入れないと戻り値がないので閉じれない
              String gender = ' ';
              // if(_agekeep.length!=4&&_agekeep.length!=0){
              if (_agekeep.length != 0) {
                for (int x = 0; x < _agekeep.length; x++) {
                  age = age + ',' + _agekeep[x] + '代';
                }
                age = age.substring(2, age.length);
              }
              if (_genderkeep.length != 0) {
                for (int x = 0; x < _genderkeep.length; x++) {
                  gender += ',' + _genderkeep[x];
                }
                gender = gender.substring(2, gender.length);
              }
              List<String> push = [age, gender];
              Navigator.of(context).pop(push);
              // print(age); 確認用
            },
          ),
        ),
      ],
    );
  }
}

