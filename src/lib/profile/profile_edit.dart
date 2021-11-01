import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; //文字数制限
import 'package:flutter/rendering.dart';

// パッケージ
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';    //パンくず
import 'package:image_picker/image_picker.dart';  //画像アップロード

// 外部ファイル
import 'package:workspace/HexColor.dart';   //16進数カラーコード
import 'package:workspace/SpaceBox.dart';   //空間
import 'package:workspace/Filtering.dart'; //フィルタリングポップアップ
import 'package:workspace/profile/profile.dart';   //プロフィール

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ProfileEditPage(),
//     );
//   }
// }

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

//各ラジオボタンの設定
enum GenderRadioValue { FIRST, SECOND, THIRD }
enum TasteRadioValue { FIRST, SECOND }
enum FlavorRadioValue { FIRST, SECOND}
enum QuantityRadioValue { FIRST, SECOND}

class _ProfileEditPageState extends State<ProfileEditPage> {
  
//選択画像
  final picker = ImagePicker(); //画像を取得
  XFile? icon_image; //URLに変更前
  String icon_url='https://images-na.ssl-images-amazon.com/images/I/71qJYwkBWwL._SX402_.jpg';  //仮で初期はポケモン

  GenderRadioValue _gValue = GenderRadioValue.FIRST;  //ラジオボタン初期値
  String gender=''; //選択した性別の値

//生年月日プルダウン
  // リストアイテム 　
  List<String> year_list = <String>['1950','1951','1952','1953','1954','1955','1956','1957','1958','1959','1960','1961','1962','1963','1964',
    '1965','1966','1967','1968','1969','1970','1971','1972','1973','1974','1975','1976','1977','1978','1979','1980','1981','1982','1983','1984',
    '1985','1986','1987','1988','1989','1990','1991','1992','1993','1994','1995','1996','1997','1998','1999','2000','2001','2002','2003','2004',
    '2005','2006','2007','2008','2009','2010','2011','2012','2013','2014','2015','2016','2017','2018','2019','2020','2021','2022'];
  String year_defaultValue = '2000';  //西暦の初期値

  // リストアイテム 　
  List<String> month_list = <String>['1','2','3','4','5','6','7','8','9','10','11','12'];
  String month_defaultValue = '1';  //月の初期値

  // リストアイテム 　
  List<String> day_list = <String>['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31',];
  String day_defaultValue = '1';  //日の初期値

  String age_label='20代前半';  //年代ラベル

//好みの味覚ラジオボタン設定
  TasteRadioValue _tValue =TasteRadioValue.FIRST;  //味ラジオボタン初期値
  String taste=''; //選択した味の値
  FlavorRadioValue _fValue = FlavorRadioValue.FIRST;  //味覚ラジオボタン初期値
  String flavor=''; //選択した値た味覚の値
  QuantityRadioValue _qValue = QuantityRadioValue.FIRST;  //量・質ラジオボタン初期値
  String quantity=''; //選択した量・質の値

  List<String> like_maker=[]; //選択したメーカー
    
  // 選択した生年月日と初期値を入れ替え
  void _handleChange(String newValue,int num) {
    setState(() {
      switch (num) {
        case 1: 
          year_defaultValue = newValue;
          break;
        case 2:
          month_defaultValue = newValue;
          break;
        case 3:
          day_defaultValue = newValue;
          break;
        default:
        print('error');
      }
    });
  }

  //年代計算
  void age_check(){
    DateTime now=DateTime.now();  //現在
    DateTime old=DateTime(int.parse(year_defaultValue),int.parse(month_defaultValue),int.parse(day_defaultValue));//入力された生年月日
    DateTime comparison=DateTime(old.year,now.month,now.day); //入力された年に現在の月日
    int age=now.year-int.parse(year_defaultValue);
    if(comparison.difference(old).inDays>-1){
      age+=1;
    }
    age-=1;
    setState(() {
      if(age<10){
        age_label=('10歳未満');
      }else if(age>59){
        age_label=('60代以上');
      }else{
        if(int.parse((age.toString()).substring(1, 2))<5){
          age_label=(age.toString()).substring(0, 1)+'0代前半';
        }else{
          age_label=(age.toString()).substring(0, 1)+'0代後半';
        }
      }
    });
     print(age.toString());  //確認用
  }
  
  Widget build(BuildContext context) {

    var media_width = MediaQuery.of(context).size.width;  //学校販売PCの場合1280
    var media_height = MediaQuery.of(context).size.height;  //学校販売PCの場合609

    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(vertical: media_height*0.032,horizontal: media_width*0.125),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: media_height*0.066),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(  //アイコン
                          width: media_width*0.195,
                          padding: EdgeInsets.only(right: media_width*0.039),
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: media_width*0.078,
                            height: media_height*0.1642,
                            decoration: new BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(icon_url)
                              )
                            )
                          ),
                        ),
                        Container(  //アイコン変更ボタン
                          width: media_width*0.454,
                          child: Row( 
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(  //選択ボタン
                                width: media_width*0.24,
                                height: media_height*0.049,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: HexColor('B8AA8E') ,
                                  ),
                                  child: Text('プロフィール画像を変更',),                                 
                                  onPressed: ()async {
                                    XFile? image = await picker.pickImage(source: ImageSource.gallery); //画像取得
                                    setState(() {
                                      icon_image=image; 
                                      icon_url=icon_image!.path;  //画像をURLに変換
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                    ),
                  ),
                  Container(    //ユーザーネーム
                    margin: EdgeInsets.symmetric(vertical: media_height*0.066),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: media_width*0.195,
                          padding: EdgeInsets.only(right: media_width*0.039),
                          alignment: Alignment.centerRight,
                          child: SelectableText.rich(
                            TextSpan(
                              text: 'ユーザーネーム', // default text style
                              children: <TextSpan>[
                                TextSpan(text: '（必須）', style: TextStyle(color: HexColor('EC9361'))),
                              ],
                            ),scrollPhysics: NeverScrollableScrollPhysics()
                          )
                        ),
                        Container(  //ユーザーネーム入力
                          width: media_width*0.454,
                          child: TextField(
                              minLines: 1,
                              maxLines: 1,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(15),  //最大15文字
                              ],
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: HexColor('EC9361'), width: 1.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                                ),
                                hintText: "最大１５文字",
                              ),
                              style: TextStyle(fontSize: 15),
                            ),
                        ),
                      ],
                    ),
                  ),
                  Container(  //性別
                    margin: EdgeInsets.symmetric(vertical: media_height*0.066),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: media_width*0.195,
                          padding: EdgeInsets.only(right: media_width*0.039),
                          alignment: Alignment.centerRight,
                          child: SelectableText.rich(
                            TextSpan(
                              text: '性別', 
                              children: <TextSpan>[
                                TextSpan(text: '（必須）', style: TextStyle(color: HexColor('EC9361'))),
                              ],
                            ),scrollPhysics: NeverScrollableScrollPhysics()
                          )
                        ),
                        Container(  //性別ラジオボタン
                          width: media_width*0.454,
                          child: Table(
                            children: [
                              TableRow(
                                children: [
                                  RadioListTile(
                                    title: Text('男性'),
                                    value: GenderRadioValue.FIRST,
                                    groupValue: _gValue,
                                    onChanged: (value) => gender_onRadioSelected(value,'男性'),
                                  ),
                                  RadioListTile(
                                    title: Text('女性'),
                                    value: GenderRadioValue.SECOND,
                                    groupValue: _gValue,
                                    onChanged: (value) => gender_onRadioSelected(value,'女性'),
                                  ),
                                  RadioListTile(
                                    title: Text('秘密'),
                                    value: GenderRadioValue.THIRD,
                                    groupValue: _gValue,
                                    onChanged: (value) => gender_onRadioSelected(value,'秘密'),
                                  ),
                                ]
                              )
                            ],
                          )
                        ),                        // Container(
                        //   width: media_width*0.195,
                        //   padding: EdgeInsets.only(left: media_width*0.039),
                        //   child: CheckboxListTile(
                        //     value: g_hide,
                        //     title: Text('非表示にする'),
                        //     controlAffinity: ListTileControlAffinity.leading,
                        //     onChanged: (value) {
                        //       setState(() {
                        //         g_hide = value!;
                        //       });
                        //     },
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  Container(  //生年月日
                    margin: EdgeInsets.symmetric(vertical: media_height*0.066),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: media_width*0.195,
                          padding: EdgeInsets.only(right: media_width*0.039),
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Tooltip(  //年代の説明
                                preferBelow: false,
                                message: '生年月日を設定すると年代にピッタリな情報をお届けできます',
                                child: Icon(
                                  Icons.help_outlined,
                                  color: HexColor('EC9361'),
                                )
                              ),
                              SelectableText.rich(
                                TextSpan(
                                  text: '生年月日', // default text style
                                  children: <TextSpan>[
                                    TextSpan(text: '（必須）', style: TextStyle(color: HexColor('EC9361'))),
                                  ],
                                ),scrollPhysics: NeverScrollableScrollPhysics()
                              )
                            ],
                          )
                        ),
                        Container(  //生年月日のドロップダウン
                          width: media_width*0.454,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(    //年
                                children: [
                                  DropdownButton<String>( //ドロップダウン
                                    value: year_defaultValue,
                                    onChanged: (String? newValue){ 
                                      setState(() {
                                        _handleChange(newValue!,1); //選択値を入れ替える
                                        age_check();  //年代計算
                                      });
                                    },
                                    items: year_list.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),SelectableText('年',scrollPhysics: NeverScrollableScrollPhysics())
                                ],
                              ),
                              Row(    //月
                                children: [
                                  DropdownButton<String>(//ドロップダウン
                                    value: month_defaultValue,
                                    onChanged: (String? newValue){
                                      setState(() {
                                        _handleChange(newValue!,2);//選択値を入れ替える
                                        age_check();//年代計算
                                      });
                                    },
                                    items: month_list.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                  SelectableText('月',scrollPhysics: NeverScrollableScrollPhysics())
                                ],
                              ),
                              Row(    //日
                                children: [
                                  DropdownButton<String>(//ドロップダウン
                                    value: day_defaultValue,
                                    onChanged: (String? newValue){
                                      setState(() {
                                        _handleChange(newValue!,3);//選択値を入れ替える
                                        age_check();//年代計算
                                      });
                                    },
                                    items: day_list.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                  SelectableText('日',scrollPhysics: NeverScrollableScrollPhysics())
                                ],
                              ),
                              SpaceBox.width(media_width*0.03125),
                              SelectableText(age_label,scrollPhysics: NeverScrollableScrollPhysics()) //年代表示
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(  //食の好み
                    margin: EdgeInsets.symmetric(vertical: media_height*0.066),
                    child: Row(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: media_width*0.195,
                          padding: EdgeInsets.only(right: media_width*0.039),
                          alignment: Alignment.centerRight,
                          child: SelectableText.rich(
                            TextSpan(
                              text: '食品の好み', 
                            ),scrollPhysics: NeverScrollableScrollPhysics()
                          )
                        ),
                        Container(  //好みのラジオボタン
                          width: media_width*0.454,
                          child: Table(
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            columnWidths: const <int, TableColumnWidth>{
                              0: FlexColumnWidth(1),  //1列目幅
                              1: FlexColumnWidth(0.7),  //2列目幅
                              2: FlexColumnWidth(2),  //3列目幅
                              3: FlexColumnWidth(2),  //4列目幅
                            },
                            children: [
                              TableRow( //味（薄味派・濃味派）
                                decoration: BoxDecoration(
                                  color:HexColor('#F5F3EF') 
                                ),
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: SelectableText('味',scrollPhysics: NeverScrollableScrollPhysics()),
                                  ),
                                  Container(),
                                  RadioListTile(
                                    title: Text('薄味派'),
                                    value: TasteRadioValue.FIRST,
                                    groupValue: _tValue,
                                    onChanged: (value) => taste_onRadioSelected(value,'薄味派'),
                                  ),
                                  RadioListTile(
                                    title: Text('濃味派'),
                                    value: TasteRadioValue.SECOND,
                                    groupValue: _tValue,
                                    onChanged: (value) => taste_onRadioSelected(value,'濃味派'),
                                  ),
                                ]
                              ),
                              TableRow( //味覚（甘口派・辛口派）
                                decoration: BoxDecoration(
                                  color:Colors.white
                                ),
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: SelectableText('味覚',scrollPhysics: NeverScrollableScrollPhysics()),
                                  ),
                                  Container(),
                                  RadioListTile(
                                    title: Text('甘口派'),
                                    value: FlavorRadioValue.FIRST,
                                    groupValue: _fValue,
                                    onChanged: (value) => flavor_onRadioSelected(value,'甘口派'),
                                  ),
                                  RadioListTile(
                                    title: Text('辛口派'),
                                    value: FlavorRadioValue.SECOND,
                                    groupValue: _fValue,
                                    onChanged: (value) => flavor_onRadioSelected(value,'辛口派'),
                                  ),
                                ]
                              ),
                              TableRow( //量・質（量派・質派）
                                decoration: BoxDecoration(
                                  color:HexColor('#F5F3EF') 
                                ),
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: SelectableText('量・質',scrollPhysics: NeverScrollableScrollPhysics()),
                                  ),
                                  Container(),
                                  RadioListTile(
                                    title: Text('量派'),
                                    value: QuantityRadioValue.FIRST,
                                    groupValue: _qValue,
                                    onChanged: (value) => quantity_onRadioSelected(value,'量派'),
                                  ),
                                  RadioListTile(
                                    title: Text('質派'),
                                    value: QuantityRadioValue.SECOND,
                                    groupValue: _qValue,
                                    onChanged: (value) => quantity_onRadioSelected(value,'質派'),
                                  ),
                                ]
                              )
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
                  Container(  //お気に入りのメーカー
                    // margin: EdgeInsets.symmetric(vertical: media_height*0.066),
                    margin: EdgeInsets.symmetric(vertical: media_height*0.066),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: media_width*0.195,
                          padding: EdgeInsets.only(right: media_width*0.039),
                          alignment: Alignment.centerRight,
                          child: SelectableText.rich(
                            TextSpan(
                              text: 'お気に入りのメーカー', 
                            ),scrollPhysics: NeverScrollableScrollPhysics()
                          )
                        ),
                        Container(
                          width: media_width*0.454,
                          child: Column( 
                            children: [
                              SizedBox(  //メーカーボタン
                                width: media_width*0.24,
                                height: media_height*0.049,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: HexColor('B8AA8E') ,
                                  ),
                                  child: Text('お気に入りのメーカーを選択',),                                 
                                  onPressed: ()async {
                                    var selected = await showDialog<List<String>>(//選択したものを取得
                                        context: context,
                                        barrierDismissible:true, 
                                        builder: (BuildContext context) {
                                          return Maker_FilteringDialog();
                                    });
                                    setState(() {
                                      if (selected != null) { //何も押さず閉じた場合nullになる
                                        like_maker = selected;
                                      }
                                    });
                                  },
                                ),
                              ),
                              SpaceBox.height(20),
                              if(like_maker.isNotEmpty)
                              Wrap(   //選択したメーカー名表示
                                children: [
                                  Row(
                                    children: [
                                      BreadCrumb( 
                                        items: <BreadCrumbItem>[  //メーカー名の間に・を入れて表示
                                          for(int x=0;x<like_maker.length;x++)
                                          BreadCrumbItem(content: Text(like_maker[x])),
                                        ],
                                        divider: Text('・'),  
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(  //自己紹介
                    margin: EdgeInsets.symmetric(vertical: media_height*0.066),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: media_width*0.195,
                          padding: EdgeInsets.only(right: media_width*0.039),
                          alignment: Alignment.topRight,
                          child: SelectableText.rich(
                            TextSpan(
                              text: '自己紹介',
                            ),scrollPhysics: NeverScrollableScrollPhysics()
                          )
                        ),
                        Container(  //自己紹介入力欄
                          width: media_width*0.454,
                          child: TextField(
                              minLines: 6,
                              maxLines: 6,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(200),  //最大200文字
                              ],
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: HexColor('EC9361'), width: 1.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                                ),
                                hintText: "最大200文字",
                              ),
                              style: TextStyle(fontSize: 15),
                            ),
                        ),
                      ],
                    ),
                  ),
                  Container(  //戻る・更新ボタン
                    width: media_width*0.594,
                    height: media_height*0.2,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(  //戻るボタン
                          width: media_width*0.15,
                          height: media_height*0.049,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: HexColor('616161').withOpacity(0.6) ,
                            ),
                            child: Text('戻る',),                                 
                            onPressed: ()async {
                              setState(() {
                                Navigator.push( context, MaterialPageRoute( builder: (context) => ProfilePage()));
                              });
                            },
                          ),
                        ),
                        SizedBox(  //更新ボタン
                          width: media_width*0.15,
                          height: media_height*0.049,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: HexColor('EC9361') ,
                            ),
                            child: Text('更新',),                                 
                            onPressed: ()async {
                            },
                          ),
                        ),        
                      ],
                    )
                  )
                ],
              ),
            ),
            //フッター
          ],
        )
      ),
    );
  }
  
  //以下ラ選択したジオボタンの値取得・変更
  gender_onRadioSelected(value,String select) {
    setState(() {
      gender=select;
      _gValue = value;
    });
  }
  taste_onRadioSelected(value,String select) {
    setState(() {
      taste=select;
      _tValue = value;
    });
  }
  flavor_onRadioSelected(value,String select) {
    setState(() {
      flavor=select;
      _fValue = value;
    });
  }
  quantity_onRadioSelected(value,String select) {
    setState(() {
      quantity=select;
      _qValue = value;
    });
  }
}
