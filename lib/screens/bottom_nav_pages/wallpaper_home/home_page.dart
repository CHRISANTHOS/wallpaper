import 'package:flutter/material.dart';
import 'package:wallpaper/utils/router.dart';
import 'package:wallpaper/screens/bottom_nav_pages/wallpaper_home/upload_page.dart';

class WallPaperHome extends StatefulWidget {

  @override
  State<WallPaperHome> createState() => _WallPaperHomeState();
}

class _WallPaperHomeState extends State<WallPaperHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('home'),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        nextPage(UploadPage(), context);
      }, label: const Text('Upload')),
    );
  }
}