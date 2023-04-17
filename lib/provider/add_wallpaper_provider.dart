import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadWallpaper extends ChangeNotifier {
  String _message = '';
  String imagePath = '';
  bool _loading = false;

  String get message => _message;
  bool get loading => _loading;

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void resetMessage() {
    _message = '';
    notifyListeners();
  }

  void addWallPaper({File? wallPaperImage, String? uid, String? price}) async {
    _loading = true;
    notifyListeners();

    CollectionReference _products = _firestore.collection('AllWallPaper');


    try {
      _message = 'Uploading image..';
      notifyListeners();

      final imageName = wallPaperImage!.path.split('/').last;
      await _storage
          .ref()
          .child('$uid/WallPaper/$imageName')
          .putFile(wallPaperImage)
          .whenComplete(() async {
        await _storage
            .ref()
            .child('$uid/WallPaper/$imageName')
            .getDownloadURL()
            .then((value) {
          imagePath = value;
        });
      });

      final data = {
        'price': price,
        'uid': uid,
        'wallpaper image': wallPaperImage
      };

      await _products.add(data);

      _loading = false;
      _message = 'Success';
      notifyListeners();
    } on FirebaseException catch (e) {
      _loading = false;
      _message = e.message.toString();
      notifyListeners();
    } on SocketException catch (e) {
      print(e);
      _loading = false;
      _message = 'No internet connection';
      notifyListeners();
    } catch (e) {
      print(e);
      _loading = false;
      _message = 'Please try again';
      notifyListeners();
    }
  }
}
