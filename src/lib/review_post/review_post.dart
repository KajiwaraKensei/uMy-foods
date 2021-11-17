import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; //文字数制限
import 'package:flutter/rendering.dart';
import 'dart:math';

// パッケージ
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart'; //パンくず
import 'package:flutter_dropzone/flutter_dropzone.dart'; //ドラッグ&ドロップアップロード
import 'package:image_picker/image_picker.dart'; //アップロード
import 'package:flutter_screenutil/flutter_screenutil.dart'; //レスポンシブ
import 'package:umy_foods/details/details.dart';
import 'package:umy_foods/header.dart';
import 'package:umy_foods/footer.dart';
import 'package:umy_foods/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; //DB

// 外部ファイル
import 'package:umy_foods/HexColor.dart'; //16進数カラーコード
import 'package:umy_foods/SpaceBox.dart'; //空間

class ReviewPostPage extends StatefulWidget {
  ReviewPostPage(
      this.product_id, this.product_name, this.image, this.maker, this.where);
  final String product_id;
  final String product_name;
  final String image;
  final String maker;
  final String where;

  @override
  _ReviewPostPageState createState() =>
      _ReviewPostPageState(product_id, product_name, image, maker, where);
}

//ラジオボタンの割り当て
enum SweetnessRadio { FIRST, SECOND, THIRD, FOUR, FIVE }
enum AcidityRadio { FIRST, SECOND, THIRD, FOUR, FIVE }
enum SaltyRadio { FIRST, SECOND, THIRD, FOUR, FIVE }
enum BitterRadio { FIRST, SECOND, THIRD, FOUR, FIVE }
enum SpicyRadio { FIRST, SECOND, THIRD, FOUR, FIVE }
enum TasteRadio { FIRST, SECOND, THIRD, FOUR, FIVE }

class _ReviewPostPageState extends State<ReviewPostPage> {
  _ReviewPostPageState(
      this.product_id, this.product_name, this.image, this.maker, this.where);
  final String product_id;
  final String product_name;
  final String image;
  final String maker;
  final String where;
  //星評価on,off判定
  final List<int> _comprehensive = [1, 2, 3];
  final List<int> _costperformance = [1, 2, 3];

  //選択した星評価の値（初期値３）
  int comprehensive_rate = 3;
  int costperformance_rate = 3;

  var repeat_text = ['はい', 'いいえ', 'わからない'];
  //選択したリピートの値（初期値はい）
  String repeat_button = 'はい';

  //ラジオボタン初期値１
  SweetnessRadio _sweetnessValue = SweetnessRadio.FIRST;
  AcidityRadio _acidityValue = AcidityRadio.FIRST;
  SaltyRadio _saltyValue = SaltyRadio.FIRST;
  BitterRadio _bitterValue = BitterRadio.FIRST;
  SpicyRadio _spicyValue = SpicyRadio.FIRST;
  TasteRadio _tasteValue = TasteRadio.FIRST;

  num sweet = 1;
  num acidity = 1;
  num salty = 1;
  num bitter = 1;
  num spicy = 1;
  num umami = 1;

  //ドロップ画像
  bool _hoverFlag = false;
  String urll = ''; //画像のURL（なぜか使えない）
  late DropzoneViewController _controller;
  String? _filename; //ファイルの名前
  int? _fileSize; //ファイルのサイズ
  String? _fileMIME; //ファイルの種類
  dynamic _fileData; //ファイルのデータ
  List _dropDataList = []; //データリスト

  //選択画像
  final picker = ImagePicker(); //画像を取得
  List _selectDateList = []; //データリスト

  var image_flag = []; //ドロップ・選択か判別
  int cnt = 0; //5枚カウント
  String image_alart = ''; //アラート

  //選択画像の取得
  void picker_image(List<XFile> pick_image) {
    for (int x = 0; x < pick_image.length; x++) {
      if (cnt < 5) {
        image_alart = '';
        _selectDateList.add(pick_image[x]);
        image_flag.add(_selectDateList.length.toString() + '2');
        cnt++;
      } else {
        image_alart = '※画像は最大5枚です';
      }
    }
  }

  //ファイルがドロップされたら情報を読み込んでから、画面を更新する。
  void _handleFileDrop(dynamic ev) async {
    // ファイル情報を読み込む。
    _filename = await _controller.getFilename(ev);
    _fileSize = await _controller.getFileSize(ev);
    _fileMIME = await _controller.getFileMIME(ev);
    _fileData = await _controller.getFileData(ev);

    if (_fileMIME!.startsWith('image')) {
      if (cnt < 5) {
        cnt++;
        image_alart = '';
        _dropDataList.add(_fileData);
        image_flag.add(_dropDataList.length.toString() + '1');
      } else {
        image_alart = '※画像は最大5枚です';
      }
    } else {
      image_alart = '※対応していない形式のファイルです';
    }

    // 一時的なリンクを生成して表示する。
    final url = await _controller.createFileUrl(ev);
    // print(url);
    _controller.releaseFileUrl(url);
    urll = url;

    // ホバー状態の表示を解除する。
    _hoverFlag = false;

    // ファイル情報が揃ったら描画を更新する。
    setState(() {});
  }

  //画像の✕ボタン押されたとき
  void delete_image(int num) {
    if (image_flag[num].substring(1, 2) == '1') {
      //ドロップ画像の場合
      _dropDataList.remove(
          _dropDataList[int.parse(image_flag[num].substring(0, 1)) - 1]);
      for (int x = num + 1; x < image_flag.length; x++) {
        if (image_flag[x].substring(1, 2) == '1') {
          //判別の数値を繰り下げ
          image_flag[x] =
              (int.parse(image_flag[x].substring(0, 1)) - 1).toString() + '1';
        }
      }
    } else {
      //選択画像の場合
      _selectDateList.remove(
          _selectDateList[int.parse(image_flag[num].substring(0, 1)) - 1]);
      for (int x = num + 1; x < image_flag.length; x++) {
        if (image_flag[x].substring(1, 2) == '2') {
          //判別の数値を繰り下げ
          image_flag[x] =
              (int.parse(image_flag[x].substring(0, 1)) - 1).toString() + '2';
        }
      }
    }
    image_flag.remove(image_flag[num]); //✕押した画像の判別値を削除
    image_alart = '';
    cnt--;
    if (_dropDataList.length == 0) {
      _fileMIME = null;
      cnt = 0;
    }
  }

  //タグ
  var _textFieldFocusNode;
  var _inputController = TextEditingController();
  var _chipList = <Chip>[]; //タグリスト
  var _keyNumber = 0;
  var tag;
  String tag_alart = ''; //タグアラート

  @override
  void initState() {
    _textFieldFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  //タグの追加を押した時
  void _onSubmitted(String text) {
    setState(() {
      if (_chipList.length < 8) {
        //8個まで
        if (text.length < 11) {
          //10文字まで
          _inputController.text = '';
          _addChip(text); //タグを追加
          FocusScope.of(context).requestFocus(_textFieldFocusNode);
          tag = '';
          tag_alart = '';
        } else {
          tag_alart = '※タグは最大１０文字です';
        }
      } else {
        tag_alart = '※タグは最大８個までです';
      }
    });
  }

  //クリップwidgetでタグを追加
  void _addChip(String text) {
    var chipKey = Key('chip_key_$_keyNumber');
    _keyNumber++;

    _chipList.add(
      Chip(
        key: chipKey,
        label: Text(text, style: TextStyle(fontSize: 14.sp)),
        onDeleted: () => _deleteChip(chipKey),
      ),
    );
  }

  //タグの✕ボタンで削除
  void _deleteChip(Key chipKey) {
    setState(() => _chipList.removeWhere((Widget w) => w.key == chipKey));
  }

  Widget build(BuildContext context) {
    var media_width = MediaQuery.of(context).size.width; //学校販売PCの場合1280
    var media_height = MediaQuery.of(context).size.height; //学校販売PCの場合609

    final comment =
    TextEditingController();

    return Scaffold(
        appBar: Header(),
        body: ListView(children: [
          Padding(
              padding: EdgeInsets.symmetric(
                  vertical: media_height * 0.032,
                  horizontal: media_width * 0.031),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BreadCrumb(
                      //パンくずリスト
                      items: <BreadCrumbItem>[
                        BreadCrumbItem(
                          content: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyApp(),
                                  ));
                            },
                            child: Text(
                              'TOP',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        BreadCrumbItem(
                          content: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              where,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        BreadCrumbItem(
                          content: TextButton(
                            onPressed: () {},
                            child: Text(
                              'レビュー投稿',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ],
                      divider: Icon(Icons.chevron_right, size: 24.sp),
                    ),
                    SpaceBox.height(media_height * 0.03),
                    Row(children: [
                      Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: media_width * 0.0156),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: media_height * 0.016,
                                      bottom: media_height * 0.041),
                                  child: Row(
                                    children: [
                                      Container(
                                        //商品画像
                                        height: media_height * 0.16,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Image.network((image == "")
                                              ? 'https://firebasestorage.googleapis.com/v0/b/umyfoods-rac.appspot.com/o/NoImage.png?alt=media&token=ed1d2e08-d7ce-47d4-bd6c-16dc4f95addf'
                                              : image),
                                        ),
                                      ),
                                      SpaceBox.width(media_width * 0.078),
                                      Column(
                                        //商品名、メーカー
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SelectableText(maker /*'アサヒ飲料株式会社'*/,
                                              style: TextStyle(fontSize: 16.sp),
                                              scrollPhysics:
                                                  NeverScrollableScrollPhysics()),
                                          SelectableText(
                                              product_name /*'ウィルキンソン タンサン 炭酸水 500ml×24本'*/,
                                              style: TextStyle(
                                                  fontSize: 22.sp,
                                                  fontWeight: FontWeight.bold),
                                              scrollPhysics:
                                                  NeverScrollableScrollPhysics())
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                    //評価
                                    margin: EdgeInsets.symmetric(
                                        vertical: media_height * 0.041),
                                    child: Column(
                                      //
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SelectableText('評価',
                                            style: TextStyle(
                                                fontSize: 22.sp,
                                                color: HexColor('EC9361'),
                                                fontWeight: FontWeight.bold),
                                            scrollPhysics:
                                                NeverScrollableScrollPhysics()),
                                        SpaceBox.height(media_height * 0.03),
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    media_width * 0.0625),
                                            child: Table(
                                              columnWidths: const <int,
                                                  TableColumnWidth>{
                                                0: FlexColumnWidth(0.36), //1列目幅
                                                1: FlexColumnWidth(1.0), //２列目幅
                                              },
                                              children: [
                                                TableRow(children: [
                                                  Container(
                                                    height: media_height * 0.09,
                                                    child: SelectableText(
                                                        '総合評価',
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                        ),
                                                        scrollPhysics:
                                                            NeverScrollableScrollPhysics()),
                                                  ),
                                                  Row(
                                                    //星評価
                                                    children: [
                                                      for (int cnt = 1;
                                                          cnt <= 5;
                                                          cnt++)
                                                        TextButton(
                                                          child: Icon(
                                                            Icons.star_outlined,
                                                            size: 35.sp,
                                                          ),
                                                          style: TextButton
                                                              .styleFrom(
                                                            primary: _comprehensive
                                                                    .contains(
                                                                        cnt)
                                                                ? HexColor(
                                                                    'FFDF4C')
                                                                : Colors
                                                                    .grey, //押したとき色変化
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              if (comprehensive_rate !=
                                                                  cnt) {
                                                                //押した星ボタンが前と違ったら
                                                                comprehensive_rate =
                                                                    cnt;
                                                                _comprehensive
                                                                    .clear();
                                                                for (int x = 1;
                                                                    x <=
                                                                        comprehensive_rate;
                                                                    x++)
                                                                  _comprehensive
                                                                      .add(
                                                                          x); //表示設定
                                                                for (int i = 5;
                                                                    i >
                                                                        comprehensive_rate;
                                                                    i--)
                                                                  _comprehensive
                                                                      .remove(
                                                                          i); //非表示設定
                                                              }
                                                            });
                                                          },
                                                        ),
                                                    ],
                                                  )
                                                ]),
                                                TableRow(children: [
                                                  Container(
                                                    height: media_height * 0.09,
                                                    child: SelectableText('コスパ',
                                                        style: TextStyle(
                                                            fontSize: 16.sp),
                                                        scrollPhysics:
                                                            NeverScrollableScrollPhysics()),
                                                  ),
                                                  Row(
                                                    children: [
                                                      for (int cnt = 1;
                                                          cnt <= 5;
                                                          cnt++)
                                                        TextButton(
                                                          child: Icon(
                                                            Icons.star_outlined,
                                                            size: 35.sp,
                                                          ),
                                                          style: TextButton
                                                              .styleFrom(
                                                            primary:
                                                                _costperformance
                                                                        .contains(
                                                                            cnt)
                                                                    ? HexColor(
                                                                        'FFDF4C')
                                                                    : Colors
                                                                        .grey,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              if (costperformance_rate !=
                                                                  cnt) {
                                                                //押した星ボタンが前と違ったら
                                                                costperformance_rate =
                                                                    cnt;
                                                                _costperformance
                                                                    .clear();
                                                                for (int x = 1;
                                                                    x <=
                                                                        costperformance_rate;
                                                                    x++)
                                                                  _costperformance
                                                                      .add(
                                                                          x); //表示設定
                                                                for (int i = 5;
                                                                    i >
                                                                        costperformance_rate;
                                                                    i--)
                                                                  _costperformance
                                                                      .remove(
                                                                          i); //非表示設定
                                                              }
                                                            });
                                                          },
                                                        ),
                                                    ],
                                                  )
                                                ]),
                                              ],
                                            ))
                                      ],
                                    )),
                                Container(
                                    //味覚
                                    margin: EdgeInsets.symmetric(
                                        vertical: media_height * 0.041),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SelectableText('味覚',
                                            style: TextStyle(
                                                fontSize: 22.sp,
                                                color: HexColor('EC9361'),
                                                fontWeight: FontWeight.bold),
                                            scrollPhysics:
                                                NeverScrollableScrollPhysics()),
                                        SpaceBox.height(media_height * 0.03),
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    media_width * 0.0625),
                                            child: Table(
                                              columnWidths: const <int,
                                                  TableColumnWidth>{
                                                0: FlexColumnWidth(0.2), //1列目幅
                                                1: FlexColumnWidth(0.2), //2列目幅
                                                2: FlexColumnWidth(0.2), //3列目幅
                                                3: FlexColumnWidth(0.2), //4列目幅
                                                4: FlexColumnWidth(0.2), //5列目幅
                                                5: FlexColumnWidth(0.2), //6列目幅
                                                6: FlexColumnWidth(0.2), //7列目幅
                                                7: FlexColumnWidth(0.2), //8列目幅
                                              },
                                              children: [
                                                TableRow(children: [
                                                  //値のラベル
                                                  Container(
                                                    height: 0.057,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text('',
                                                          style: TextStyle(
                                                              fontSize: 14.sp)),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text('低い',
                                                        style: TextStyle(
                                                            fontSize: 14.sp)),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text('１',
                                                        style: TextStyle(
                                                            fontSize: 14.sp)),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text('２',
                                                        style: TextStyle(
                                                            fontSize: 14.sp)),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text('３',
                                                        style: TextStyle(
                                                            fontSize: 14.sp)),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text('４',
                                                        style: TextStyle(
                                                            fontSize: 14.sp)),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text('５',
                                                        style: TextStyle(
                                                            fontSize: 14.sp)),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text('高い',
                                                        style: TextStyle(
                                                            fontSize: 14.sp)),
                                                  ),
                                                ]),
                                                TableRow(children: [
                                                  //甘味
                                                  Container(
                                                    height:
                                                        media_height * 0.082,
                                                    child: SelectableText('甘味',
                                                        style: TextStyle(
                                                            fontSize: 16.sp),
                                                        scrollPhysics:
                                                            NeverScrollableScrollPhysics()),
                                                  ),
                                                  Text('',
                                                      style: TextStyle(
                                                          fontSize: 14.sp)),
                                                  Radio(
                                                    value: SweetnessRadio.FIRST,
                                                    groupValue: _sweetnessValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Sweetness(
                                                            value, 1),
                                                  ),
                                                  Radio(
                                                    value:
                                                        SweetnessRadio.SECOND,
                                                    groupValue: _sweetnessValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Sweetness(
                                                            value, 2),
                                                  ),
                                                  Radio(
                                                    value: SweetnessRadio.THIRD,
                                                    groupValue: _sweetnessValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Sweetness(
                                                            value, 3),
                                                  ),
                                                  Radio(
                                                    value: SweetnessRadio.FOUR,
                                                    groupValue: _sweetnessValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Sweetness(
                                                            value, 4),
                                                  ),
                                                  Radio(
                                                    value: SweetnessRadio.FIVE,
                                                    groupValue: _sweetnessValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Sweetness(
                                                            value, 5),
                                                  ),
                                                  Text('',
                                                      style: TextStyle(
                                                          fontSize: 14.sp)),
                                                ]),
                                                TableRow(children: [
                                                  //酸味
                                                  Container(
                                                    height:
                                                        media_height * 0.082,
                                                    child: SelectableText('酸味',
                                                        style: TextStyle(
                                                            fontSize: 16.sp),
                                                        scrollPhysics:
                                                            NeverScrollableScrollPhysics()),
                                                  ),
                                                  Text('',
                                                      style: TextStyle(
                                                          fontSize: 14.sp)),
                                                  Radio(
                                                    value: AcidityRadio.FIRST,
                                                    groupValue: _acidityValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Acidity(
                                                            value, 1),
                                                  ),
                                                  Radio(
                                                    value: AcidityRadio.SECOND,
                                                    groupValue: _acidityValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Acidity(
                                                            value, 2),
                                                  ),
                                                  Radio(
                                                    value: AcidityRadio.THIRD,
                                                    groupValue: _acidityValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Acidity(
                                                            value, 3),
                                                  ),
                                                  Radio(
                                                    value: AcidityRadio.FOUR,
                                                    groupValue: _acidityValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Acidity(
                                                            value, 4),
                                                  ),
                                                  Radio(
                                                    value: AcidityRadio.FIVE,
                                                    groupValue: _acidityValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Acidity(
                                                            value, 5),
                                                  ),
                                                  Text('',
                                                      style: TextStyle(
                                                          fontSize: 14.sp)),
                                                ]),
                                                TableRow(children: [
                                                  //塩味
                                                  Container(
                                                    height:
                                                        media_height * 0.082,
                                                    child: SelectableText('塩味',
                                                        style: TextStyle(
                                                            fontSize: 16.sp),
                                                        scrollPhysics:
                                                            NeverScrollableScrollPhysics()),
                                                  ),
                                                  Text(''),
                                                  Radio(
                                                    value: SaltyRadio.FIRST,
                                                    groupValue: _saltyValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Salty(
                                                            value, 1),
                                                  ),
                                                  Radio(
                                                    value: SaltyRadio.SECOND,
                                                    groupValue: _saltyValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Salty(
                                                            value, 2),
                                                  ),
                                                  Radio(
                                                    value: SaltyRadio.THIRD,
                                                    groupValue: _saltyValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Salty(
                                                            value, 3),
                                                  ),
                                                  Radio(
                                                    value: SaltyRadio.FOUR,
                                                    groupValue: _saltyValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Salty(
                                                            value, 4),
                                                  ),
                                                  Radio(
                                                    value: SaltyRadio.FIVE,
                                                    groupValue: _saltyValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Salty(
                                                            value, 5),
                                                  ),
                                                  Text('',
                                                      style: TextStyle(
                                                          fontSize: 14.sp)),
                                                ]),
                                                TableRow(children: [
                                                  //苦味
                                                  Container(
                                                    height:
                                                        media_height * 0.082,
                                                    child: SelectableText('苦味',
                                                        style: TextStyle(
                                                            fontSize: 16.sp),
                                                        scrollPhysics:
                                                            NeverScrollableScrollPhysics()),
                                                  ),
                                                  Text(''),
                                                  Radio(
                                                    value: BitterRadio.FIRST,
                                                    groupValue: _bitterValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Bitter(
                                                            value, 1),
                                                  ),
                                                  Radio(
                                                    value: BitterRadio.SECOND,
                                                    groupValue: _bitterValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Bitter(
                                                            value, 2),
                                                  ),
                                                  Radio(
                                                    value: BitterRadio.THIRD,
                                                    groupValue: _bitterValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Bitter(
                                                            value, 3),
                                                  ),
                                                  Radio(
                                                    value: BitterRadio.FOUR,
                                                    groupValue: _bitterValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Bitter(
                                                            value, 4),
                                                  ),
                                                  Radio(
                                                    value: BitterRadio.FIVE,
                                                    groupValue: _bitterValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Bitter(
                                                            value, 5),
                                                  ),
                                                  Text('',
                                                      style: TextStyle(
                                                          fontSize: 14.sp)),
                                                ]),
                                                TableRow(children: [
                                                  //辛味
                                                  Container(
                                                    height:
                                                        media_height * 0.082,
                                                    child: SelectableText('辛味',
                                                        style: TextStyle(
                                                            fontSize: 16.sp),
                                                        scrollPhysics:
                                                            NeverScrollableScrollPhysics()),
                                                  ),
                                                  Text(''),
                                                  Radio(
                                                    value: SpicyRadio.FIRST,
                                                    groupValue: _spicyValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Spicy(
                                                            value, 1),
                                                  ),
                                                  Radio(
                                                    value: SpicyRadio.SECOND,
                                                    groupValue: _spicyValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Spicy(
                                                            value, 2),
                                                  ),
                                                  Radio(
                                                    value: SpicyRadio.THIRD,
                                                    groupValue: _spicyValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Spicy(
                                                            value, 3),
                                                  ),
                                                  Radio(
                                                    value: SpicyRadio.FOUR,
                                                    groupValue: _spicyValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Spicy(
                                                            value, 4),
                                                  ),
                                                  Radio(
                                                    value: SpicyRadio.FIVE,
                                                    groupValue: _spicyValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Spicy(
                                                            value, 5),
                                                  ),
                                                  Text('',
                                                      style: TextStyle(
                                                          fontSize: 14.sp)),
                                                ]),
                                                TableRow(children: [
                                                  //旨味
                                                  Container(
                                                    height:
                                                        media_height * 0.082,
                                                    child: SelectableText('旨味',
                                                        style: TextStyle(
                                                            fontSize: 16.sp),
                                                        scrollPhysics:
                                                            NeverScrollableScrollPhysics()),
                                                  ),
                                                  Text('',
                                                      style: TextStyle(
                                                          fontSize: 14.sp)),
                                                  Radio(
                                                    value: TasteRadio.FIRST,
                                                    groupValue: _tasteValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Taste(
                                                            value, 1),
                                                  ),
                                                  Radio(
                                                    value: TasteRadio.SECOND,
                                                    groupValue: _tasteValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Taste(
                                                            value, 2),
                                                  ),
                                                  Radio(
                                                    value: TasteRadio.THIRD,
                                                    groupValue: _tasteValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Taste(
                                                            value, 3),
                                                  ),
                                                  Radio(
                                                    value: TasteRadio.FOUR,
                                                    groupValue: _tasteValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Taste(
                                                            value, 4),
                                                  ),
                                                  Radio(
                                                    value: TasteRadio.FIVE,
                                                    groupValue: _tasteValue,
                                                    onChanged: (value) =>
                                                        _onRadioSelected_Taste(
                                                            value, 5),
                                                  ),
                                                  Text('',
                                                      style: TextStyle(
                                                          fontSize: 14.sp)),
                                                ]),
                                              ],
                                            ))
                                      ],
                                    )),
                                Container(
                                    //リピート
                                    margin: EdgeInsets.symmetric(
                                        vertical: media_height * 0.041),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SelectableText('リピートしたいですか？',
                                              style: TextStyle(
                                                  fontSize: 22.sp,
                                                  color: HexColor('EC9361'),
                                                  fontWeight: FontWeight.bold),
                                              scrollPhysics:
                                                  NeverScrollableScrollPhysics()),
                                          SpaceBox.height(media_height * 0.049),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    media_width * 0.0625),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                for (int cnt = 0;
                                                    cnt < 3;
                                                    cnt++)
                                                  SizedBox(
                                                    //リピートボタン
                                                    width: media_width * 0.108,
                                                    height:
                                                        media_height * 0.049,
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: repeat_button
                                                                .contains(
                                                                    repeat_text[
                                                                        cnt])
                                                            ? HexColor('B8AA8E')
                                                            : Colors.grey,
                                                      ),
                                                      child: Text(
                                                          repeat_text[cnt],
                                                          style: TextStyle(
                                                              fontSize: 14.sp)),
                                                      onPressed: () {
                                                        setState(() {
                                                          repeat_button =
                                                              repeat_text[
                                                                  cnt]; //選択を代入
                                                        });
                                                      },
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              //評価のみ投稿
                                              margin: EdgeInsets.only(
                                                  top: media_height * 0.164,
                                                  bottom: media_height * 0.041),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  SizedBox(
                                                    //評価のみ投稿ボタン
                                                    width: media_width * 0.14,
                                                    height:
                                                        media_height * 0.065,
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary:
                                                                  Colors.white,
                                                              side: BorderSide(
                                                                width: 1.5,
                                                                color: HexColor(
                                                                    'EC9361'),
                                                              )),
                                                      child: Text(
                                                        '評価のみ投稿する',
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            color: HexColor(
                                                                'EC9361')),
                                                      ),
                                                      onPressed: () async {
                                                        final user =
                                                            await FirebaseAuth
                                                                .instance
                                                                .currentUser;
                                                        final userId = user?.uid
                                                            .toString();
                                                        final snapshot =
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'account')
                                                                .where(
                                                                    'user_id',
                                                                    isEqualTo:
                                                                        userId)
                                                                .get();
                                                        final userData =
                                                            snapshot.docs[0];
                                                        String reviewId =
                                                            randomString(20);
                                                        final now =
                                                            Timestamp.fromDate(
                                                                DateTime.now());
                                                        List<num> taste = [
                                                          sweet,
                                                          acidity,
                                                          salty,
                                                          bitter,
                                                          spicy,
                                                          umami
                                                        ];
                                                        showDialog<int>(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                  '内容確認',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14.sp),
                                                                ),
                                                                content: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                          'レビュー内容はこちらでよろしいですか。'),
                                                                      Container(
                                                                          height:
                                                                              40.h),
                                                                      Text(
                                                                        '商品名：' +
                                                                            product_name,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14.sp),
                                                                      ),
                                                                      Text(
                                                                          '評価　：' +
                                                                              comprehensive_rate
                                                                                  .toString(),
                                                                          style:
                                                                              TextStyle(fontSize: 14.sp)),
                                                                      Text(
                                                                          'コスパ　：' +
                                                                              costperformance_rate
                                                                                  .toString(),
                                                                          style:
                                                                              TextStyle(fontSize: 14.sp)),
                                                                      Text(
                                                                          '甘味：' +
                                                                              taste[0]
                                                                                  .toString(),
                                                                          style:
                                                                              TextStyle(fontSize: 14.sp)),
                                                                      Text(
                                                                          '酸味：' +
                                                                              taste[1]
                                                                                  .toString(),
                                                                          style:
                                                                              TextStyle(fontSize: 14.sp)),
                                                                      Text(
                                                                          '塩味：' +
                                                                              taste[2]
                                                                                  .toString(),
                                                                          style:
                                                                              TextStyle(fontSize: 14.sp)),
                                                                      Text(
                                                                          '苦味：' +
                                                                              taste[3]
                                                                                  .toString(),
                                                                          style:
                                                                              TextStyle(fontSize: 14.sp)),
                                                                      Text(
                                                                          '辛味：' +
                                                                              taste[4]
                                                                                  .toString(),
                                                                          style:
                                                                              TextStyle(fontSize: 14.sp)),
                                                                      Text(
                                                                          '旨味：' +
                                                                              taste[5]
                                                                                  .toString(),
                                                                          style:
                                                                              TextStyle(fontSize: 14.sp)),
                                                                    ]),
                                                                actions: <
                                                                    Widget>[
                                                                  FlatButton(
                                                                    child: Text(
                                                                        '投稿',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14.sp)),
                                                                    onPressed:
                                                                        () {
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'review')
                                                                          .doc(
                                                                              reviewId)
                                                                          .set({
                                                                        'comment_sum':
                                                                            0,
                                                                        'delete_date':
                                                                            now,
                                                                        'delete_flag':
                                                                            false,
                                                                        'favorite_sum':
                                                                            0,
                                                                        'product_id':
                                                                            product_id,
                                                                        'product_name':
                                                                            product_name,
                                                                        'review_comment':
                                                                            "",
                                                                        'review_cospa':
                                                                            costperformance_rate,
                                                                        'review_evaluation':
                                                                            comprehensive_rate,
                                                                        'review_id':
                                                                            reviewId,
                                                                        'review_postdate':
                                                                            now,
                                                                        'tag_id':
                                                                            [],
                                                                        'taste':
                                                                            taste,
                                                                        'update_date':
                                                                            now,
                                                                        'url': [
                                                                          ''
                                                                        ],
                                                                        'user_birthday':
                                                                            userData['user_birthday'],
                                                                        'user_gender':
                                                                            userData['user_gender'],
                                                                        'user_id':
                                                                            userId,
                                                                        'user_name':
                                                                            userData['user_name'],
                                                                      });
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => DetailsPage(product_id, 'レビュー投稿')));
                                                                    },
                                                                  ),
                                                                  FlatButton(
                                                                    child: Text(
                                                                        '戻る',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14.sp)),
                                                                    onPressed: () =>
                                                                        Navigator.of(context)
                                                                            .pop(),
                                                                  ),
                                                                ],
                                                              );
                                                            });
                                                      },
                                                    ),
                                                  ),
                                                  // SizedBox(  //投稿ボタン
                                                  //   width: media_width*0.14,
                                                  //   height: media_height*0.065,
                                                  //   child: ElevatedButton(
                                                  //     style: ElevatedButton.styleFrom(
                                                  //       primary: HexColor('EC9361') ,
                                                  //     ),
                                                  //     child: Text('投稿する',),
                                                  //     onPressed: () {
                                                  //       setState(() {
                                                  //       });
                                                  //     },
                                                  //   ),
                                                  // ),
                                                ],
                                              ))
                                        ])),
                                Container(
                                  //画像
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SelectableText('画像を追加',
                                              style: TextStyle(
                                                  fontSize: 22.sp,
                                                  color: HexColor('EC9361'),
                                                  fontWeight: FontWeight.bold),
                                              scrollPhysics:
                                                  NeverScrollableScrollPhysics()),
                                          SelectableText('最大５枚まで',
                                              style: TextStyle(fontSize: 14.sp),
                                              scrollPhysics:
                                                  NeverScrollableScrollPhysics())
                                        ],
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              top: media_height * 0.049,
                                              bottom: media_height * 0.019),
                                          width: media_width * 0.6382,
                                          height: media_height * 0.40,
                                          child: Stack(
                                            //ドロップゾーンとコンテナを被らせてる
                                            children: [
                                              DropzoneView(
                                                //ドロップゾーン
                                                operation: DragOperation.move,
                                                cursor: CursorType.auto,
                                                onCreated: (ctrl) =>
                                                    _controller = ctrl,
                                                onDrop: (ev) =>
                                                    _handleFileDrop(ev),
                                                onError: (ev) =>
                                                    print('Error: $ev'),
                                                onHover: () => setState(() {
                                                  _hoverFlag = true;
                                                }),
                                                onLeave: () => setState(() {
                                                  _hoverFlag = false;
                                                }),
                                              ),
                                              Container(
                                                width: media_width * 0.6382,
                                                height: media_height * 0.40,
                                                padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        media_height * 0.008,
                                                    horizontal:
                                                        media_width * 0.015),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: imageViewArea(
                                                    context,
                                                    media_width,
                                                    media_height), //画像を表示
                                              )
                                            ],
                                          )),
                                      SelectableText(image_alart,
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 15),
                                          scrollPhysics:
                                              NeverScrollableScrollPhysics()), //画像アラート
                                    ],
                                  ),
                                ),
                                Container(
                                  //コメント
                                  margin: EdgeInsets.symmetric(
                                      vertical: media_height * 0.041),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SelectableText('コメント',
                                              style: TextStyle(
                                                  fontSize: 22.sp,
                                                  color: HexColor('EC9361'),
                                                  fontWeight: FontWeight.bold),
                                              scrollPhysics:
                                                  NeverScrollableScrollPhysics()),
                                          SelectableText('最大400文字',
                                              style: TextStyle(fontSize: 14.sp),
                                              scrollPhysics:
                                                  NeverScrollableScrollPhysics())
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: media_height * 0.049),
                                        child: TextField(
                                          minLines: 3,
                                          maxLines: null,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                400), //最大400文字
                                          ],
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: HexColor('EC9361'),
                                                  width: 1.5),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.5),
                                            ),
                                            hintStyle:
                                                TextStyle(fontSize: 14.sp),
                                            hintText:
                                                "お気に入りの食品を共有してみましょう！\n（例）食感、味、おすすめの食べ方",
                                          ),
                                          style: TextStyle(fontSize: 15.sp),
                                          controller: comment,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  //タグ
                                  margin: EdgeInsets.symmetric(
                                      vertical: media_height * 0.041),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SelectableText('タグを追加',
                                              style: TextStyle(
                                                  fontSize: 22.sp,
                                                  color: HexColor('EC9361'),
                                                  fontWeight: FontWeight.bold),
                                              scrollPhysics:
                                                  NeverScrollableScrollPhysics()),
                                          Tooltip(
                                              //タグの説明
                                              preferBelow: false,
                                              message:
                                                  'タグを付けると同じキーワードでの投稿を瞬時に検索できたり、\n話題を共有したりすることができます',
                                              child: Icon(
                                                  Icons.help_outline_outlined,
                                                  size: 24.sp)),
                                          SelectableText('最大10文字　8個まで',
                                              style: TextStyle(fontSize: 14.sp),
                                              scrollPhysics:
                                                  NeverScrollableScrollPhysics())
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: media_height * 0.049,
                                            bottom: media_height * 0.019),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  //タグ表示エリア
                                                  height: media_height * 0.13,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          media_height * 0.015,
                                                      horizontal:
                                                          media_height * 0.011),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Wrap(
                                                          alignment:
                                                              WrapAlignment
                                                                  .start,
                                                          spacing: 15.0,
                                                          runSpacing: 15.0,
                                                          direction:
                                                              Axis.horizontal,
                                                          children: _chipList,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (_chipList.length == 0)
                                                  Container(
                                                    //タグが０の場合表示
                                                    padding: EdgeInsets.only(
                                                        top: media_height *
                                                            0.0245,
                                                        left:
                                                            media_width * 0.01),
                                                    child: Text(
                                                        'タグを追加してみましょう！\n（例）今日のアイス、ご褒美スイーツ、チョコミン党',
                                                        style: TextStyle(
                                                            fontSize: 15.sp,
                                                            color: HexColor(
                                                                    '#444444')
                                                                .withOpacity(
                                                                    0.8))),
                                                  )
                                              ],
                                            ),
                                            Divider(
                                              //線
                                              height: media_height * 0.032,
                                              thickness: 2,
                                              indent: 0,
                                              endIndent: 0,
                                            ),
                                            Container(
                                                //タグ入力エリア
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        media_width * 0.01),
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      //タグ入力
                                                      child: TextField(
                                                        focusNode:
                                                            _textFieldFocusNode,
                                                        autofocus: false,
                                                        controller:
                                                            _inputController,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: 'タグを入力',
                                                          hintStyle: TextStyle(
                                                              fontSize: 14.sp),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: HexColor(
                                                                      'ec9463')
                                                                  .withOpacity(
                                                                      0.0),
                                                            ),
                                                          ),
                                                        ),
                                                        onSubmitted:
                                                            _onSubmitted,
                                                        onChanged: (value) {
                                                          tag = value;
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      //送信ボタン
                                                      width: media_width * 0.05,
                                                      height:
                                                          media_height * 0.065,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: HexColor(
                                                              'e5e5e5'),
                                                        ),
                                                        child: Icon(
                                                          Icons.send_outlined,
                                                          size: 24.sp,
                                                          color: HexColor(
                                                              '#444444'),
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            _onSubmitted(tag);
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                      SelectableText(tag_alart,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 15.sp),
                                          scrollPhysics:
                                              NeverScrollableScrollPhysics()) //タグアラート
                                    ],
                                  ),
                                ),
                                Container(
                                    //投稿ボタン
                                    margin: EdgeInsets.only(
                                        top: media_height * 0.014,
                                        bottom: media_height * 0.041),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          //投稿ボタン
                                          width: media_width * 0.14,
                                          height: media_height * 0.065,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: HexColor('EC9361'),
                                            ),
                                            child: Text(
                                              '投稿する',
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                            onPressed: () async {
                                              final user = await FirebaseAuth
                                                  .instance.currentUser;
                                              final userId =
                                                  user?.uid.toString();
                                              final snapshot =
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('account')
                                                      .where('user_id',
                                                          isEqualTo: userId)
                                                      .get();
                                              final userData = snapshot.docs[0];
                                              String reviewId =
                                                  randomString(20);
                                              final now = Timestamp.fromDate(
                                                  DateTime.now());
                                              List<num> taste = [
                                                sweet,
                                                acidity,
                                                salty,
                                                bitter,
                                                spicy,
                                                umami
                                              ];
                                              showDialog<int>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                        '内容確認',
                                                        style: TextStyle(
                                                            fontSize: 14.sp),
                                                      ),
                                                      content: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                'レビュー内容はこちらでよろしいですか。'),
                                                            Container(
                                                                height: 40.h),
                                                            Text(
                                                              '商品名：' +
                                                                  product_name,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.sp),
                                                            ),
                                                            Text(
                                                                '評価　：' +
                                                                    comprehensive_rate
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp)),
                                                            Text(
                                                                'コスパ　：' +
                                                                    costperformance_rate
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp)),
                                                            Text(
                                                                '甘味：' +
                                                                    taste[0]
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp)),
                                                            Text(
                                                                '酸味：' +
                                                                    taste[1]
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp)),
                                                            Text(
                                                                '塩味：' +
                                                                    taste[2]
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp)),
                                                            Text(
                                                                '苦味：' +
                                                                    taste[3]
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp)),
                                                            Text(
                                                                '辛味：' +
                                                                    taste[4]
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp)),
                                                            Text(
                                                                '旨味：' +
                                                                    taste[5]
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp)),
                                                            Text(
                                                                'コメント：' +
                                                                    comment.text.toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp)),
                                                            Text(
                                                                'タグ：' +
                                                                    _chipList
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp)),
                                                          ]),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                          child: Text('投稿',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.sp)),
                                                          onPressed: () {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'review')
                                                                .doc(reviewId)
                                                                .set({
                                                              'comment_sum': 0,
                                                              'delete_date':
                                                                  now,
                                                              'delete_flag':
                                                                  false,
                                                              'favorite_sum': 0,
                                                              'product_id':
                                                                  product_id,
                                                              'product_name':
                                                                  product_name,
                                                              'review_comment':
                                                                  comment.text.toString(),
                                                              'review_cospa':
                                                                  costperformance_rate,
                                                              'review_evaluation':
                                                                  comprehensive_rate,
                                                              'review_id':
                                                                  reviewId,
                                                              'review_postdate':
                                                                  now,
                                                              'tag_id':
                                                                  _chipList,
                                                              'taste': taste,
                                                              'update_date':
                                                                  now,
                                                              'url': [''],
                                                              'user_birthday':
                                                                  userData[
                                                                      'user_birthday'],
                                                              'user_gender':
                                                                  userData[
                                                                      'user_gender'],
                                                              'user_id': userId,
                                                              'user_name':
                                                                  userData[
                                                                      'user_name'],
                                                            });
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        DetailsPage(
                                                                            product_id,
                                                                            'レビュー投稿')));
                                                          },
                                                        ),
                                                        FlatButton(
                                                          child: Text('戻る',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.sp)),
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                          ),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(
                                '広告',
                                style: TextStyle(fontSize: 14.sp),
                              )
                            ],
                          ))
                    ])
                  ])),
          FooterCreate(),
          //フッター
        ]));
  }

  //画像表示
  Widget imageViewArea(BuildContext context, double m, double h) =>
      Builder(builder: (context) {
        var media_width = m;
        var media_height = h;

        if (_dropDataList.length == 0 && _selectDateList.length == 0) {
          // まだなにもアップされていないとき。
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.collections_outlined,
                color: HexColor('#444444').withOpacity(0.3),
                size: 100,
              ),
              Column(
                children: [
                  SizedBox(
                    //選択ボタン
                    width: media_width * 0.14,
                    height: media_height * 0.049,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: HexColor('B8AA8E'),
                      ),
                      child: Text(
                        '選択',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      onPressed: () async {
                        List<XFile>? image = await picker.pickMultiImage();
                        setState(() {
                          picker_image(image!);
                        });
                      },
                    ),
                  ),
                  SpaceBox.height(media_height * 0.02463),
                  Text(
                    'または、ここに画像ファイルをドラッグしてください(Beta版は画像投稿できません)',
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: HexColor('#444444').withOpacity(0.8)),
                  )
                ],
              )
            ],
          ));
        } else {
          //画像が1枚以上の場合
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  for (int x = 0;
                      x < _dropDataList.length + _selectDateList.length;
                      x++)
                    Stack(
                      children: [
                        Container(
                          //画像表示
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: media_width * 0.121,
                          height: media_height * 0.2545,
                          child: image_flag[x].substring(1, 2) == '1'
                              ? Image.memory(_dropDataList[
                                  int.parse(image_flag[x].substring(0, 1)) - 1])
                              : Image.network(_selectDateList[
                                      int.parse(image_flag[x].substring(0, 1)) -
                                          1]
                                  .path),
                        ),
                        Padding(
                          //✕ボタン
                          padding: EdgeInsets.only(left: media_width * 0.09375),
                          child: SizedBox(
                            //投稿ボタン
                            width: media_width * 0.01953,
                            height: media_height * 0.041,
                            child: TextButton(
                              child: Icon(
                                Icons.clear_outlined,
                                size: (30 / (media_width * media_height)) *
                                    (media_width * media_height),
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  delete_image(x);
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    )
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    //選択ボタン
                    width: media_width * 0.14,
                    height: media_height * 0.049,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: HexColor('B8AA8E'),
                      ),
                      child: Text(
                        '選択',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      onPressed: () async {
                        List<XFile>? image = await picker.pickMultiImage();
                        setState(() {
                          picker_image(image!);
                        });
                      },
                    ),
                  ),
                  SpaceBox.height(media_height * 0.02463),
                  Text(
                    'または、ここに画像ファイルをドラッグしてください',
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: HexColor('#444444').withOpacity(0.8)),
                  )
                ],
              ),
            ],
          );
        }
      });
  //以下ラジオボタンの処理
  _onRadioSelected_Sweetness(value, num level) {
    setState(() {
      sweet = level;
      _sweetnessValue = value;
    });
  }

  _onRadioSelected_Acidity(value, num level) {
    setState(() {
      acidity = level;
      _acidityValue = value;
    });
  }

  _onRadioSelected_Salty(value, num level) {
    setState(() {
      salty = level;
      _saltyValue = value;
    });
  }

  _onRadioSelected_Bitter(value, num level) {
    setState(() {
      bitter = level;
      _bitterValue = value;
    });
  }

  _onRadioSelected_Spicy(value, num level) {
    setState(() {
      spicy = level;
      _spicyValue = value;
    });
  }

  _onRadioSelected_Taste(value, num level) {
    setState(() {
      umami = level;
      _tasteValue = value;
    });
  }
}

String randomString(int length) {
  const _randomChars =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  const _charsLength = _randomChars.length;

  final rand = new Random();
  final codeUnits = new List.generate(
    length,
    (index) {
      final n = rand.nextInt(_charsLength);
      return _randomChars.codeUnitAt(n);
    },
  );
  return new String.fromCharCodes(codeUnits);
}
