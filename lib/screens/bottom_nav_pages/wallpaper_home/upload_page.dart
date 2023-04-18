import 'dart:io';
import 'package:provider/provider.dart';
import 'package:wallpaper/provider/add_wallpaper_provider.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/widgets/custom_button.dart';
import 'package:wallpaper/utils/pick_file.dart';
import 'package:wallpaper/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UploadPage extends StatefulWidget {
  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final TextEditingController _controller = TextEditingController();
  String imagePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new wallpaper'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        label: const Text('Enter price (Optional)')),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      pickImage().then((value) {
                        setState(() {
                          imagePath = value;
                        });
                      });
                    },
                    child: const SizedBox(
                      height: 50,
                      width: 50,
                      child: Icon(Icons.camera),
                    ),
                  ),
                  if(imagePath != '') Image.file(File(imagePath)),
                  Consumer<UploadWallpaper>(
                    builder: (context, add, child) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if(add.message != ''){
                          showSnackBar(context, add.message);
                          add.resetMessage();
                        }
                      });

                      return customButton(
                          text: add.loading ? 'Uploading...' : 'Upload',
                          onTap: add.loading ? null : ()async {
                            if(imagePath != ''){
                              await add.addWallPaper(uid: FirebaseAuth.instance.currentUser?.uid, wallPaperImage: File(imagePath), price: _controller.text ?? '');
                              Navigator.pop(context);
                            }else{
                              showSnackBar(context, 'Upload Image');
                            }
                          },
                          bgColor: add.loading? Colors.grey : Colors.black54,
                          textColor: Colors.white);
                    }
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
