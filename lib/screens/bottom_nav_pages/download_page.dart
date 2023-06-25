import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallpaper/screens/bottom_nav_pages/wallpaper_home/view_wallpaper.dart';

import '../../utils/router.dart';

class DownloadPage extends StatefulWidget {

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference downloadedWallpaper = FirebaseFirestore.instance.collection('PurchasedWallpaper');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: downloadedWallpaper.doc(uid).collection('Wallpaper').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          final data = snapshot.data!.docs;

          if (snapshot.hasData) {
            if (data.isEmpty) {
              return const Center(
                child: Text('No Saved Wallpapers'),
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
                    return GestureDetector(
                      onTap: (){
                        nextPage(ViewWallpaper(data: data[index]), context);
                      },
                      child: Container(
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
    );
  }
}
