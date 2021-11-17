import 'package:flutter/material.dart';
import 'package:umy_foods/HexColor.dart'; //16進数カラーコード
import 'package:flutter_screenutil/flutter_screenutil.dart';//レスポンシブ

//星評価
star(int star, int size) {
  // var stars=['','★☆☆☆☆','★★☆☆☆','★★★☆☆','★★★★☆','★★★★★'];

  // return  Text(stars[star],style: TextStyle(color: HexColor('ffe14c'),fontSize: size.toDouble()));

  return RichText(
      text: TextSpan(children: [
    for (int cnt = 1; cnt <= star; cnt++)
      WidgetSpan(
                child: Icon(
          Icons.star_outlined,
          color: HexColor('ffe14c'),
          size: size.toDouble().sp,
        ),
      ),
          for (int cnt = 1; cnt <= 5 - star; cnt++)
      WidgetSpan(
                child: Icon(
          Icons.grade_outlined,
          color: HexColor('ffe14c'),
          size: size.toDouble().sp,
        ),
      ),
        ]));

}
