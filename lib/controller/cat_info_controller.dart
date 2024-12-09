import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CatInfoController extends ChangeNotifier{
  String  _catImageDemo = "https://images.unsplash.com/photo-1482434368596-fbd06cae4f89?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
  String  _catName = "Meow";
  String  _catImage = "https://images.unsplash.com/photo-1482434368596-fbd06cae4f89?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
  final String _getCatUrl = "https://api.thecatapi.com/v1/images/search";

  String get catName => _catName;
  String get catImage => _catImage;

  bool _getCatLoading = false;
  bool get getCatLoading => _getCatLoading;

  bool _isBookmarked = false;
  bool get isBookmarked => _isBookmarked;

  void setIsBookmarked(bool value) {
    _isBookmarked = value;
    notifyListeners();
  }

  void setCatName(String catName) {
    if(catName.isEmpty)return;
    _catName = catName;
    notifyListeners();
  }

  void setGetLoading(bool value) {
    _getCatLoading = value;
    notifyListeners();
  }

  void setCatImage(String catImage) {
    if(catImage.isEmpty)return;
    _catImage = catImage;
    notifyListeners();
  }

  void _reset(){
    _catName = "Meow";
    _catImage = _catImageDemo;
    _isBookmarked = false;
    notifyListeners();
  }

  void getNewCat() async{
    log("getNewCat called");
    setGetLoading(true);
    try{
      final res = await http.get(Uri.parse(_getCatUrl));
      if(res.statusCode == 200){
        Map catData = jsonDecode(res.body)[0];
        debugPrint(res.body);
        _reset();
        setCatImage(catData['url']);
        log(_catImage);
      }else{
        log(res.statusCode.toString());
      }
    }catch(e){
      log(e.toString());
    }finally{
      setGetLoading(false);
    }
  }
}