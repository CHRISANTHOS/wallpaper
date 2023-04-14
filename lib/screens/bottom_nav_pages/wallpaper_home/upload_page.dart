import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wallpaper/widgets/custom_button.dart';
import 'package:wallpaper/utils/pick_file.dart';

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
                  customButton(
                      text: 'Upload',
                      onTap: () {},
                      bgColor: Colors.black54,
                      textColor: Colors.white)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
