import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/utils/router.dart';
import 'package:wallpaper/screens/bottom_nav_pages/wallpaper_home/upload_page.dart';

class WallPaperHome extends StatefulWidget {
  @override
  State<WallPaperHome> createState() => _WallPaperHomeState();
}

class _WallPaperHomeState extends State<WallPaperHome> {
  CollectionReference wallpaper =
      FirebaseFirestore.instance.collection('AllWallPaper');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: wallpaper.get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          final data = snapshot.data!.docs;

          if (snapshot.hasData) {
            if (data.isEmpty) {
              return const Center(
                child: Text('No Wallpapers Available'),
              );
            } else {
              return Container(
                padding: const EdgeInsets.all(10),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.5,
                  children: List.generate(data.length, (index) {
                    return Container(
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(File(data[index].get('wallpaper_url'))),
                            fit: BoxFit.cover),
                      ),
                      child: Center(
                        child: data[index].get('price') == ''
                            ? null
                            : CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Text(
                                  data[index].get('price'),
                                ),
                              ),
                      ),
                    );
                  }),
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            nextPage(UploadPage(), context);
          },
          label: const Text('Upload')),
    );
  }
}
