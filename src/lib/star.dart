import 'package:flutter/material.dart';
import 'package:workspace/HexColor.dart';   //16進数カラーコード

star(int star,int size){
    // var stars=['','★☆☆☆☆','★★☆☆☆','★★★☆☆','★★★★☆','★★★★★'];

    // return  Text(stars[star],style: TextStyle(color: HexColor('ffe14c'),fontSize: size.toDouble()));

    return RichText(
      text: TextSpan(
        children:[
          for(int cnt=1;cnt<=star;cnt++)
            WidgetSpan(
                child: Icon(Icons.star_outlined,color: HexColor('ffe14c'),size: size.toDouble(),),
            ),
          for(int cnt=1;cnt<=5-star;cnt++)
            WidgetSpan(
                child: Icon(Icons.grade_outlined,color: HexColor('ffe14c'),size: size.toDouble(),),
            ),
        ]
      )
    );

}