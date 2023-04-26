import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PurchasedWallPaper{

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void save({required String wallpaperImage}) async{
    CollectionReference _product = firestore.collection('PurchasedWallPaper');

    final uid = FirebaseAuth.instance.currentUser!.uid;
    try{
      Map<String, dynamic> data = {
        'uid': uid,
        'price': '',
        'wallpaper_url': wallpaperImage
      };

      await _product.doc(uid).collection('WallPaper').add(data);
    }catch(e){
      print(e);
    }
    }

  }