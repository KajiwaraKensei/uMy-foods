import 'package:flutter/material.dart';
import 'package:umy_foods/HexColor.dart';   //16進数カラーコード


//詳細画面・レビュー検索
class SortDialog extends StatefulWidget {
  @override
  _SortDialogState createState() => _SortDialogState();
}

enum SingingCharacter { evaluation, post,like,comment }

class _SortDialogState extends State<SortDialog> {
  SingingCharacter? _character = SingingCharacter.evaluation;
  String select='評価順';//選択したものを入れる
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('表示順',style: TextStyle(color: HexColor('EC9361'),fontWeight: FontWeight.w900 )),
      content: Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * .6,
        color: HexColor('f5f3ef'),
        child:Table(children: [
          TableRow(
            children: [
              RadioListTile(
                title: const Text('評価順'),
                groupValue: _character,
                value: SingingCharacter.evaluation,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    sort_onRadioSelected(value,'評価順');
                  });
                },
              ),
              RadioListTile(
                title: const Text('投稿順'),
                groupValue: _character,
                value: SingingCharacter.post,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    sort_onRadioSelected(value,'投稿順');
                  });
                },
              ),
            ]),
          TableRow(
            children: [
              RadioListTile(
                title: const Text('いいね順'),
                groupValue: _character,
                value: SingingCharacter.like,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                    sort_onRadioSelected(value,'いいね順');
                  });
                },
              ),
              RadioListTile(
                title: const Text('コメント数順'),
                groupValue: _character,
                value: SingingCharacter.comment,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    sort_onRadioSelected(value,'コメント数順');
                  });
                },
              )
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
              String push = ''; //選択した値
              push=select;
              // if (_character == SingingCharacter.evaluation) {
              //   select = '評価順';
              // } else if (_character == SingingCharacter.post) {
              //   select = '投稿順';
              // } else if (_character == SingingCharacter.like) {
              //   select = 'いいね順';
              // } else if (_character == SingingCharacter.comment) {
              //   select = 'コメント数順';
              // }
              Navigator.of(context).pop(push);
            },
          ),
        ),
      ],
    );
  }
  void sort_onRadioSelected(value,String x){
    select=x; //選択した値を代入
    _character=value; //選択判定
  }
}

//レビュー時の商品選択
class ProductSelectionSortDialog extends StatefulWidget {
  @override
  _ProductSelectionSortDialogState createState() => _ProductSelectionSortDialogState();
}
enum ProductSelectionRadio { alphabetical, release}

class _ProductSelectionSortDialogState extends State<ProductSelectionSortDialog> {

  ProductSelectionRadio? _character = ProductSelectionRadio.alphabetical; //初期設定
  String select='五十音順'; //選択したものを入れる
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('表示順',style: TextStyle(color: HexColor('EC9361'),fontWeight: FontWeight.w900 )),
      content: Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * .3,
        height: MediaQuery.of(context).size.height * .3,
        color: HexColor('f5f3ef'),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RadioListTile(
              title: const Text('五十音順'),
              groupValue: _character,
              value: ProductSelectionRadio.alphabetical,
              onChanged: (ProductSelectionRadio? value) {
                setState(() {
                  productSelection_onRadioSelected(value,'五十音順');
                });
              },
            ),
            RadioListTile(  
              title: const Text('発売日順'),
              groupValue: _character,
              value: ProductSelectionRadio.release,
              onChanged: (ProductSelectionRadio? value) {
                setState(() {
                  productSelection_onRadioSelected(value,'発売日順');
                });
              },
            ),
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
              String push = ''; //選択した値
              push=select;
              print(push);
              Navigator.of(context).pop();
              // Navigator.of(context).pop(push);
            },
          ),
        ),
      ],
    );
  }
  void productSelection_onRadioSelected(value,String x){
    select=x; //選択した値を代入
    _character=value; //選択判定
  }
}

//商品検索
class SearchResultsSortDialog extends StatefulWidget {
  @override
  _SearchResultsSortDialogState createState() => _SearchResultsSortDialogState();
}

enum SearchResultsRadio { evaluation, post,like,comment }

class _SearchResultsSortDialogState extends State<SearchResultsSortDialog> {
  SearchResultsRadio? _character = SearchResultsRadio.evaluation;
  String select='評価順';//選択したものを入れる
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('表示順',style: TextStyle(color: HexColor('EC9361'),fontWeight: FontWeight.w900 )),
      content: Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * .6,
        color: HexColor('f5f3ef'),
        child:Table(children: [
          TableRow(
            children: [
              RadioListTile(
                title: const Text('評価順'),
                groupValue: _character,
                value: SearchResultsRadio.evaluation,
                onChanged: (SearchResultsRadio? value) {
                  setState(() {
                    searchresults_onRadioSelected(value,'評価順');
                  });
                },
              ),
              RadioListTile(
                title: const Text('気になる順'),
                groupValue: _character,
                value: SearchResultsRadio.post,
                onChanged: (SearchResultsRadio? value) {
                  setState(() {
                    searchresults_onRadioSelected(value,'気になる順');
                  });
                },
              ),
            ]),
          TableRow(
            children: [
              RadioListTile(
                title: const Text('リピート順'),
                groupValue: _character,
                value: SearchResultsRadio.like,
                onChanged: (SearchResultsRadio? value) {
                  setState(() {
                    _character = value;
                    searchresults_onRadioSelected(value,'リピート順');
                  });
                },
              ),
              Container(),
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
              String push = ''; //選択した値
              push=select;
              Navigator.of(context).pop(push);
            },
          ),
        ),
      ],
    );
  }
  void searchresults_onRadioSelected(value,String x){
    select=x; //選択した値を代入
    _character=value; //選択判定
  }
}
