import 'dart:io';
import 'package:wallpaper/payment/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ViewWallpaper extends StatefulWidget {

  QueryDocumentSnapshot<Object?> data;
  ViewWallpaper({Key? key,required this.data}) : super(key: key);

  @override
  State<ViewWallpaper> createState() => _ViewWallpaperState();
}

class _ViewWallpaperState extends State<ViewWallpaper> {
  List<String> apply = ['Home Screen', 'LockScreen', 'Both'];

  void showSheet(BuildContext context){
    showModalBottomSheet(context: context, builder: (context){
      return SizedBox(
        height: 200,
        child: Column(
          children: [
            const Text('Apply', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ...List.generate(apply.length, (index) {
              return Container(
                width: MediaQuery.of(context).size.width * 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text(apply[index], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              );
            })
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.expand,
          children: [
            Image.file(File(widget.data.get('wallpaper_url')), fit: BoxFit.cover,),
            Positioned(
              bottom: 8,
              child: GestureDetector(
                onTap: (){
                  if(widget.data.get('price') == ''){
                    showSheet(context);
                  }else{
                    Payment(context: context, amount: widget.data.get('price'), image: widget.data.get('wallpaper_url')).chargeCardAndMakePayment();
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Text(widget.data.get('price') == '' ? 'Apply' : 'Purchase', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                ),
              ),
            )
          ],
      ),
    );
  }
}
