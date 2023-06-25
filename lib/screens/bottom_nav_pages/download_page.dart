import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DownloadPage extends StatefulWidget {

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('download'),
      ),
    );
  }
}
