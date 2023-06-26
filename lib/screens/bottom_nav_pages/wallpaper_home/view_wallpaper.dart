import 'dart:io';
import 'package:provider/provider.dart';
import 'package:wallpaper/payment/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/provider/apply_wallpaper_provider.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import '../../../utils/snackbar.dart';

class ViewWallpaper extends StatefulWidget {
  QueryDocumentSnapshot<Object?> data;
  String path;

  ViewWallpaper({Key? key, required this.data, this.path = ''}) : super(key: key);

  @override
  State<ViewWallpaper> createState() => _ViewWallpaperState();
}

class _ViewWallpaperState extends State<ViewWallpaper> {
  List<String> apply = ['Home Screen', 'LockScreen', 'Both'];

  void showSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<ApplyWallPaperProvider>(
                builder: (context, applyWall, child) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if(applyWall.message != ''){
                      showSnackBar(context, applyWall.message);
                      applyWall.resetMessage();
                      Navigator.pop(context);
                    }
                  });
                  return Column(
                    children: [
                      Text(
                        applyWall.status ? 'Please wait...' : 'Apply',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      ...List.generate(apply.length, (index) {
                        final data = apply[index];
                        return GestureDetector(
                          onTap: (){
                            final image  = widget.data.get('wallpaper_url');
                            switch(index){
                              case 0:
                                //HOME
                              applyWall.apply(image, WallpaperManager.HOME_SCREEN, widget.path);
                                break;
                              case 1:
                                //LOCK
                                applyWall.apply(image, WallpaperManager.LOCK_SCREEN, widget.path);
                                break;
                              case 2:
                                //BOTH
                                applyWall.apply(image, WallpaperManager.BOTH_SCREEN, widget.path);
                                break;
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 50,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.only(bottom: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: Text(
                              data,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        );
                      })
                    ],
                  );
                }
              ),
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
          Image.file(
            File(widget.data.get('wallpaper_url')),
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 8,
            child: GestureDetector(
              onTap: () {
                if (widget.data.get('price') == '') {
                  showSheet(context);
                } else {
                  Payment(
                    context: context,
                    amount: widget.data.get('price'),
                    image: widget.data.get('wallpaper_url'),
                  ).chargeCardAndMakePayment();
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
                child: Text(
                  widget.data.get('price') == '' ? 'Apply' : 'Purchase',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
