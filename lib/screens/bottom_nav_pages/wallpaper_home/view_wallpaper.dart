import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewWallpaper extends StatefulWidget {

  QueryDocumentSnapshot<Object?> data;
  ViewWallpaper({Key? key,required this.data}) : super(key: key);

  @override
  State<ViewWallpaper> createState() => _ViewWallpaperState();
}

class _ViewWallpaperState extends State<ViewWallpaper> {
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
                onTap: (){},
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
