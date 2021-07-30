import 'package:flutter/material.dart';
import 'package:workspace/HexColor.dart';   //16進数カラーコード
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart'; //年代別レビュー　


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

class Gender extends StatefulWidget {
  @override
  _Gender createState() => _Gender();
}
class _Gender extends State<Gender>{
  @override
  Widget build(BuildContext context) {
    return Text('aaa');
  }
}

//メーカー、ブランド、カテゴリー

class FilteringDialog extends StatefulWidget {
  @override
  _FilteringDialogState createState() => _FilteringDialogState();
}

class _FilteringDialogState extends State<FilteringDialog> {
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
              color: Colors.red,
              child: Category(),
            ),
            Container(color: Colors.green),
            Container(color: Colors.pink),
          ],
          onChange: (index) => print(index),
        ),
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

class Category extends StatefulWidget {
  @override
  _Category createState() => _Category();
}
class _Category extends State<Category>{
  @override
  Widget build(BuildContext context) {
    return Text('aaa');
  }
}

