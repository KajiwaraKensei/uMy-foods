import 'package:flutter/material.dart';
import 'package:workspace/HexColor.dart';   //16進数カラーコード


enum SingingCharacter { evaluation, post,like,comment }

class SortDialog extends StatefulWidget {
  @override
  _SortDialogState createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  SingingCharacter? _character = SingingCharacter.evaluation;

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
                    _character = value;
                  });
                },
              ),
              RadioListTile(
                title: const Text('投稿順'),
                groupValue: _character,
                value: SingingCharacter.post,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
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
                  });
                },
              ),
              RadioListTile(
                title: const Text('コメント数順'),
                groupValue: _character,
                value: SingingCharacter.comment,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
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
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}