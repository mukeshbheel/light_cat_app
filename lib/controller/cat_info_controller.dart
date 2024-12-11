import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider_project/model/catInfo.dart';
import 'package:uuid/uuid.dart';

class CatInfoController extends ChangeNotifier{

  CatInfoController(){
    getNewCat();
  }
  String  _catImageDemo = "https://images.unsplash.com/photo-1482434368596-fbd06cae4f89?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
  String  _catName = "Meow";
  String  _catImage = "https://images.unsplash.com/photo-1482434368596-fbd06cae4f89?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
  final String _getCatUrl = "https://api.thecatapi.com/v1/images/search";
  List<CatInfo> cats = [];
  String id = "";

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
    id = Uuid().v1();
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

  //---------------cats hive database------------------>

  Box<CatInfo> catBox = Hive.box<CatInfo>('cats');
  void getAllCats({bool skipNotifyListener = false}){
    cats = catBox.values.map((cat)=>cat).toList();
    if(!skipNotifyListener){
      notifyListeners();
    }
  }

  void saveCat(CatInfo cat){
    catBox.put(cat.id, cat);
  }

  void updateCat(CatInfo cat){
    catBox.put(cat.id, cat);
  }

  void deleteCat(String catId){
    catBox.delete(catId);
    if(catId == id){
      setIsBookmarked(false);
    }
  }

  //--------------------download image-------------------->

  Future<void> downloadImage(String imageUrl, String fileName) async {
    debugPrint('yo');
    try {
      // Fetch the image from the URL
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Get the directory to save the image
        final directory = await getExternalStorageDirectory();
        final filePath = '${directory?.path}/$fileName';

        // Save the image as a file
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        print('Image downloaded and saved to $filePath');
      } else {
        print('Failed to download image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading image: $e');
    }
  }

  bool saveImageLoading = false;
  setSaveImageLoading(bool value){
    saveImageLoading = value;
    notifyListeners();
  }
  Future<void> saveImageManually(BuildContext context, String imageUrl, String fileName) async {
    String endingExtension = ".";
    if(imageUrl.endsWith("png")){
      endingExtension += "png";
    }else if(imageUrl.endsWith("gif")){
      endingExtension += "gif";
    }else{
      endingExtension += "jpg";
    }

    try {
      setSaveImageLoading(true);
      // Request storage permissions
      if (await Permission.storage.request().isGranted) {
        // Fetch image bytes
        final response = await http.get(Uri.parse(imageUrl));
        if (response.statusCode == 200) {
          final Uint8List imageData = response.bodyBytes;

          // Save the image to Pictures directory
          final directory = Directory('/storage/emulated/0/Pictures');
          if (!await directory.exists()) {
            await directory.create(recursive: true);
          }

          final filePath = '${directory.path}/${fileName.replaceAll(" ", "_")}$endingExtension';
          final file = File(filePath);
          await file.writeAsBytes(imageData);

          log("Image saved to: $filePath");
          SnackBar snackBar = SnackBar( shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white)), backgroundColor: Colors.black, content: Text('${fileName.toUpperCase()} Saved to Gallery',style: TextStyle(color: Colors.white),));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          log("Failed to fetch image. Status: ${response.statusCode}");
        }
      } else {
        log("Permission denied.");
      }
    } catch (e) {
      log("Error saving image: $e");
    }finally{
      setSaveImageLoading(false);
    }
  }



}