import 'dart:io';
import 'purchased_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/utils/convert_url_to_file.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class ApplyWallPaperProvider extends ChangeNotifier {

  String _message = '';
  bool _status = false;

  String get message => _message;
  bool get status => _status;

  void apply(String? image, int? location, String? path)async{
    _status = true;
    notifyListeners();

    try{
      File file = await convertUrlToFile(image!);

      await WallpaperManager.setWallpaperFromFile(file.path, location!);

      if(path != 'saved'){
        PurchasedWallPaper().save(wallpaperImage: image);
      }
      _status = false;
      _message = 'Applied';
      notifyListeners();
    }catch(e){
      print(e);
      _status = false;
      _message = 'Error Occured';
      notifyListeners();
    }

  }

  void resetMessage(){
    _message = '';
    notifyListeners();
  }

}