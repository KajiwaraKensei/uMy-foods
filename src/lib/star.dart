import 'package:flutter/material.dart';
import 'package:umy_foods/HexColor.dart'; //16進数カラーコード

//星評価
star(int star, int size) {
  return RichText(
      text: TextSpan(children: [
    for (int cnt = 1; cnt <= star; cnt++)
      WidgetSpan(
        child: Icon(
          Icons.star_outlined,
          color: HexColor('ffe14c'),
          size: size.toDouble(),
        ),
      ),
    for (int cnt = 1; cnt <= 5 - star; cnt++)
      WidgetSpan(
        child: Icon(
          Icons.grade_outlined,
          color: HexColor('ffe14c'),
          size: size.toDouble(),
        ),
      ),
  ]));
}
