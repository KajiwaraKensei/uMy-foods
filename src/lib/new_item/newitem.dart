import 'dart:collection';
import 'package:flutter/material.dart';
// パッケージ
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart'; //パンくず
import 'package:intl/date_symbol_data_local.dart'; //翻訳
import 'package:table_calendar/table_calendar.dart'; //カレンダー
// 外部ファイル
import 'package:umy_foods/HexColor.dart'; //16進数カラーコード
import 'package:umy_foods/SpaceBox.dart'; //空間
import 'package:umy_foods/star.dart'; //星評価
import 'package:umy_foods/header.dart';
import 'package:umy_foods/footer.dart';
import 'package:umy_foods/clipButton.dart';

/*void main() {
  initializeDateFormatting().then((_) => runApp(MyApp())); //翻訳して実行
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewItemPage(),
    );
  }
}
*/
class NewItemPage extends StatefulWidget {
  @override
  _NewItemPageState createState() => _NewItemPageState();
}

class _NewItemPageState extends State<NewItemPage> {
  DateTime _focusedDay = DateTime.now(); //現在日時
  DateTime now = DateTime.now(); //現在日時
  int week_cnt = 0; //先週
  int week_cntend = 7; //来週
  Map<DateTime, List> _eventsList = {};

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  List weekname = [
    '',
    '月',
    '火',
    '水',
    '木',
    '金',
    '土',
    '日',
  ]; //曜日リスト

  @override
  void initState() {
    super.initState();
    //サンプルのイベントリスト
    _eventsList = {
      DateTime(2021, 9, 2): [
        '商品ID0',
        '商品ID1',
        '商品ID2',
        '商品ID3',
      ],
      DateTime(2021, 9, 3): [
        '商品ID4',
        '商品ID5',
        '商品ID6',
        '商品ID7',
      ],
      DateTime(2021, 9, 7): [
        '商品ID8',
        '商品ID9',
      ],
      DateTime(2021, 9, 10): [
        '商品ID10',
        '商品ID11',
        '商品ID12',
      ],
      DateTime(2021, 9, 12): ['商品ID13'],
      DateTime(2021, 9, 17): [
        '商品ID14',
        '商品ID15',
        '商品ID16',
      ],
      DateTime(2021, 9, 18): ['商品ID17'],
      DateTime(2021, 9, 21): ['商品ID18'],
      DateTime(2021, 9, 25): ['商品ID19'],
      DateTime(2021, 9, 30): ['商品ID20'],
      DateTime(2021, 10, 1): ['商品ID21'],
      DateTime(2021, 10, 19): ['商品ID22'],
      DateTime(2021, 10, 21): ['商品ID31'],
      DateTime(2021, 10, 12): ['商品ID24'],
      DateTime(2021, 10, 18): ['商品ID55'],
      DateTime(2021, 10, 19): ['商品ID27'],
    };
  }

  DateTime label_start = DateTime.now(); //日時タイトル
  DateTime label_end = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day + 6); //日時タイトル
  bool _calendar = false; //カレンダー表示非表示
  bool nosunday = true; //日曜日に合わせる

  Widget build(BuildContext context) {
    final _events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventsList);

    List getEventForDay(DateTime day) {
      //入力した日付のイベントを取得
      return _events[day] ?? [];
    }

    return Scaffold(
    appbar:Header(),
    floatingActionButton: clipButton(),
          body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: ListView(
          children: [
            BreadCrumb(
              //パンくずリスト
              items: <BreadCrumbItem>[
                BreadCrumbItem(
                    content: GestureDetector(
                  child: Text('パン'),
                  onTap: () {
                    setState(() {});
                  },
                )),
                BreadCrumbItem(
                    content: GestureDetector(
                  child: Text('くず'),
                  onTap: () {
                    setState(() {});
                  },
                )),
              ],
              divider: Icon(Icons.chevron_right),
            ),
            SpaceBox.height(20),
            Row(children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Column(
                    children: [
                      SizedBox(
                        //カレンダー表示非表示ボタン
                        height: 40,
                        child: ElevatedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('カレンダーでチェックする'),
                                Icon(
                                  Icons.expand_more_outlined,
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: HexColor('EC9361'),
                                onPrimary: Colors.white
                                // side:BorderSide(color: HexColor('EC9361')),
                                ),
                            onPressed: () async {
                              setState(() {
                                _calendar = !_calendar;
                              });
                            }),
                      ),
                      Visibility(
                          visible: _calendar,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TableCalendar(
                                //カレンダー設定
                                locale: 'ja_JP',
                                firstDay: DateTime.utc(2020, 1, 1),
                                lastDay: DateTime.utc(2030, 12, 31),
                                startingDayOfWeek:
                                    StartingDayOfWeek.sunday, //月曜始まり
                                focusedDay: _focusedDay, //現在日時
                                eventLoader: getEventForDay, //イベント読み込み
                                daysOfWeekHeight: 30, //曜日の高さ
                                headerStyle: HeaderStyle(
                                    //表示切替非表示
                                    formatButtonVisible: false,
                                    titleCentered: true, //タイトル年月中央寄せ
                                    decoration: BoxDecoration(
                                        color: HexColor('#F5F3EF'))),
                                calendarBuilders: CalendarBuilders(
                                  //色合いなどのカスタム
                                  markerBuilder: (context, date, events) {
                                    //イベントマーカー
                                    if (events.isNotEmpty) {
                                      return _buildEventsMarker(date, events);
                                    }
                                  },
                                  //カレンダーカスタム
                                  dowBuilder: (context, day) {
                                    //曜日のラベル
                                    return _weeklabel(day.weekday);
                                  },
                                  defaultBuilder: (context, day, focusedDay) {
                                    //今日以外の今月の日付
                                    return _day(day.weekday, day.day);
                                  },
                                  todayBuilder: (context, day, focusedDay) {
                                    //今日の日付
                                    return _today(day.weekday, day.day);
                                  },
                                  outsideBuilder: (context, day, focusedDay) {
                                    //先月・来月の日付
                                    return _outmonth(day.weekday, day.day);
                                  },
                                ),
                              ),
                              Container(
                                  //カレンダー内の●の説明
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 5),
                                  color: Colors.white,
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    width: 130,
                                    padding: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      color:
                                          HexColor('F5F3EF').withOpacity(0.3),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '●',
                                          style: TextStyle(
                                              color: HexColor('EC9361'),
                                              fontSize: 20),
                                        ),
                                        SpaceBox.width(10),
                                        Text('新発売商品数')
                                      ],
                                    ),
                                  )),
                            ],
                          )),
                      SpaceBox.height(60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            //先週ボタン
                            width: 100,
                            height: 30,
                            child: ElevatedButton(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios_outlined,
                                  ),
                                  Text('先週')
                                ],
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered))
                                    return HexColor('EC9361'); //ホバーした時
                                  return HexColor('B8AA8E');
                                }),
                              ),
                              onPressed: () {
                                setState(() {
                                  week_cnt -= 7;
                                  week_cntend -= 7;
                                  if (nosunday == true) {
                                    //現在日時が日曜日以外だったら日曜日に合わせる
                                    label_start = DateTime(
                                        label_start.year,
                                        label_start.month,
                                        label_start.day - 7 - now.weekday);
                                    label_end = DateTime(
                                        label_end.year,
                                        label_end.month,
                                        label_end.day - 7 - now.weekday);
                                    nosunday = false;
                                  } else {
                                    label_start = DateTime(label_start.year,
                                        label_start.month, label_start.day - 7);
                                    label_end = DateTime(label_end.year,
                                        label_end.month, label_end.day - 7);
                                  }
                                });
                              },
                            ),
                          ),
                          //先週と来週ボタンの間の日付
                          if (nosunday = true) //現在日時が日曜日以外の場合
                            Text(
                                DateTime(label_start.year, label_start.month,
                                            label_start.day - now.weekday)
                                        .month
                                        .toString() +
                                    '月' +
                                    DateTime(
                                            label_start.year,
                                            label_start.month,
                                            label_start.day - now.weekday)
                                        .day
                                        .toString() +
                                    '日(' +
                                    weekname[DateTime(
                                            label_start.year,
                                            label_start.month,
                                            label_start.day - now.weekday)
                                        .weekday] +
                                    ') ―  ' +
                                    DateTime(label_end.year, label_end.month,
                                            label_end.day - now.weekday)
                                        .month
                                        .toString() +
                                    '月' +
                                    DateTime(label_end.year, label_end.month,
                                            label_end.day - now.weekday)
                                        .day
                                        .toString() +
                                    '日(' +
                                    weekname[DateTime(
                                            label_end.year,
                                            label_end.month,
                                            label_end.day - now.weekday)
                                        .weekday] +
                                    ')',
                                style: TextStyle(fontSize: 25)),
                          if (nosunday = false) //現在日時が日曜日の場合
                            Text(
                                label_start.month.toString() +
                                    '月' +
                                    (label_start.day).toString() +
                                    '日(' +
                                    weekname[label_start.weekday] +
                                    ') ―  ' +
                                    label_end.month.toString() +
                                    '月' +
                                    (label_end.day).toString() +
                                    '日(' +
                                    weekname[label_end.weekday] +
                                    ')',
                                style: TextStyle(fontSize: 25)),
                          SizedBox(
                            //来週ボタン
                            width: 100,
                            height: 30,
                            child: ElevatedButton(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('来週'),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                  ),
                                ],
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered))
                                    return HexColor('EC9361'); //ホバーした時
                                  return HexColor('B8AA8E');
                                }),
                              ),
                              onPressed: () {
                                setState(() {
                                  week_cnt += 7;
                                  week_cntend += 7;
                                  if (nosunday == true) {
                                    //現在日時が日曜日以外だったら日曜日に合わせる
                                    label_start = DateTime(
                                        label_start.year,
                                        label_start.month,
                                        label_start.day + 7 - now.weekday);
                                    label_end = DateTime(
                                        label_end.year,
                                        label_end.month,
                                        label_end.day + 7 - now.weekday);
                                    nosunday = false;
                                  } else {
                                    label_start = DateTime(label_start.year,
                                        label_start.month, label_start.day + 7);
                                    label_end = DateTime(label_end.year,
                                        label_end.month, label_end.day + 7);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SpaceBox.height(35),
                      //発売日時・新商品のカードを表示
                      if (DateTime(now.year, now.month, now.day).weekday !=
                          7) //現在日時が日曜日以外だったら
                        for (int cnt = week_cnt;
                            cnt < week_cntend;
                            cnt++) //一週間分
                          _releaseList(
                              getEventForDay(DateTime(now.year, now.month,
                                  (now.day - now.weekday) + cnt)),
                              DateTime(now.year, now.month,
                                  (now.day - now.weekday) + cnt)),
                      if (DateTime(now.year, now.month, now.day).weekday ==
                          7) //現在日時が日曜日だったら
                        for (int cnt = week_cnt;
                            cnt < week_cntend;
                            cnt++) //一週間分
                          _releaseList(
                              getEventForDay(
                                  DateTime(now.year, now.month, now.day + cnt)),
                              DateTime(now.year, now.month, now.day + cnt)),
                      SpaceBox.height(20),
                      Row(
                        //ページング
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            //数字ボタン
                            width: 35,
                            height: 50,
                            child: ElevatedButton(
                              child: Text(
                                '1',
                                style: TextStyle(fontSize: 20),
                              ),
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
                            //＞ボタン
                            child: const Text(
                              '>',
                              style: TextStyle(fontSize: 40),
                            ),
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(flex: 2, child: Text('広告'))
            ])
          ],
        ),
      );
  }

  Widget _releaseList(List<dynamic> releaseId, DateTime day) {
    //発売日時・新商品のカードを表示
    releaseId = releaseId.toList();
    if (releaseId.length != 0) {
      //新発売の商品が無ければ表示しない
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            //発売日時の表示
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                    color: HexColor('E7E3D9'),
                    border: Border(
                        top: BorderSide(color: HexColor('8C6E63'), width: 5))),
              ),
              Column(
                children: [
                  SpaceBox.height(8),
                  Text(
                    day.month.toString() +
                        '月' +
                        day.day.toString() +
                        '日(' +
                        weekname[day.weekday] +
                        ')発売',
                    style: TextStyle(fontSize: 20),
                    // scrollPhysics: NeverScrollableScrollPhysics(),
                  ),
                ],
              )
            ],
          ),
          SpaceBox.height(25),
          Column(
            children: [
              for (int x = 0; x < 3; x++)
                Row(
                  children: [
                    for (int i = 0 + (x * 3); i < 3 * (x + 1); i++)
                      if (releaseId.length > i)
                        Container(
                            child: Row(
                          children: [
                            SpaceBox.width(60),
                            Card(
                              //商品カード
                              child: InkWell(
                                onTap: () {
                                  setState(() {}); //商品詳細ページへ
                                },
                                child: Container(
                                    child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Container(
                                              //商品画像
                                              height: 100,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Image.network(
                                                    'https://images-na.ssl-images-amazon.com/images/I/71tcgatTdML._AC_SL1500_.jpg'),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('明治'), //メーカー
                                                Text(releaseId[
                                                    i]), //商品名（現在は商品IDを表示中）
                                                Row(
                                                  //星評価
                                                  children: [
                                                    star(3, 25),
                                                    Text('500',
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                'EC9361'),
                                                            fontSize: 12))
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        RichText(
                                                            //気になる数
                                                            text: TextSpan(
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                children: [
                                                              TextSpan(
                                                                  text: '1',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      color: HexColor(
                                                                          'EC9361'))),
                                                              TextSpan(
                                                                  text: '気になる')
                                                            ])),
                                                        RichText(
                                                            //リピート数
                                                            text: TextSpan(
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                children: [
                                                              TextSpan(
                                                                  text: '100',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      color: HexColor(
                                                                          'EC9361'))),
                                                              TextSpan(
                                                                  text: 'リピート')
                                                            ]))
                                                      ],
                                                    ),
                                                    SpaceBox.width(10),
                                                    ElevatedButton(
                                                      //クリップボタン
                                                      child: Icon(
                                                        Icons
                                                            .assignment_turned_in,
                                                      ),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        padding:
                                                            EdgeInsets.all(15),
                                                        primary:
                                                            HexColor('EC9361'),
                                                        onPrimary: Colors.white,
                                                        shape: CircleBorder(
                                                          side: BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                            style: BorderStyle
                                                                .solid,
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
                                        ))),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              SpaceBox.height(20)
            ],
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  //ここから下は色や背景などカレンダーのカスタム
  Widget _buildEventsMarker(DateTime date, List events) {
    //カレンダー内イベントマーカー●
    return Positioned(
      bottom: 3,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: HexColor('EC9361'),
        ),
        width: 20.0,
        height: 20.0,
        child: Center(
          child: Text(
            '${events.length}',
            style: TextStyle().copyWith(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _today(int week, int day) {
    //現在日の表示
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
        color: HexColor('F5F3EF').withOpacity(0.5),
      ),
      child: Column(
        children: [
          SpaceBox.height(5),
          if (week == 6) //土曜日の場合
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                day.toString(),
                style: TextStyle(color: Colors.blue),
              ),
            )
          else if (week == 7) //日曜日の場合
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                day.toString(),
                style: TextStyle(color: Colors.red),
              ),
            )
          else
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                day.toString(),
                style: TextStyle(color: Colors.black),
              ),
            )
        ],
      ),
    );
  }

  Widget _day(int week, int day) {
    //日付の表示
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SpaceBox.height(5),
          if (week == 6) //土曜日の場合
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                day.toString(),
                style: TextStyle(color: Colors.blue),
              ),
            )
          else if (week == 7) //日曜日の場合
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                day.toString(),
                style: TextStyle(color: Colors.red),
              ),
            )
          else
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                day.toString(),
                style: TextStyle(color: Colors.black),
              ),
            )
        ],
      ),
    );
  }

  Widget _outmonth(int week, int day) {
    //今月に表示されている先月来月の日付
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SpaceBox.height(5),
          if (week == 6) //土曜日の場合
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                day.toString(),
                style: TextStyle(color: Colors.blue.withOpacity(0.3)),
              ),
            )
          else if (week == 7) //日曜日の場合
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                day.toString(),
                style: TextStyle(color: Colors.red.withOpacity(0.3)),
              ),
            )
          else
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                day.toString(),
                style: TextStyle(color: Colors.grey.withOpacity(0.8)),
              ),
            )
        ],
      ),
    );
  }

  Widget _weeklabel(int week) {
    //曜日
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
            color: Colors.white,
          ),
        ),
        if (week == 6) //土曜日の場合
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              weekname[week],
              style: TextStyle(color: Colors.blue),
            ),
          )
        else if (week == 7) //日曜日の場合
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              weekname[week],
              style: TextStyle(color: Colors.red),
            ),
          )
        else
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              weekname[week],
              style: TextStyle(color: Colors.black),
            ),
          )
      ],
    );
  }
}
