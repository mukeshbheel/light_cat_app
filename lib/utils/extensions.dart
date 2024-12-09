import 'package:flutter/cupertino.dart';

extension AddGap on List<Widget>{
  List<Widget> addElement(Widget element){
    List<Widget> list = [];
    for(int i = 0; i < this.length; i++){
      list.add(this[i]);
      if(i != this.length-1){
        list.add(element);
      }
    }
    return list;
  }
}