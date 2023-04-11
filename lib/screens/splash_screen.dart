import 'package:flutter/material.dart';
import 'package:wallpaper/screens/Authentication/auth_page.dart';
import 'package:wallpaper/screens/main_activity.dart';
import 'package:wallpaper/utils/router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), (){
      if(firebaseAuth.currentUser == null){
        nextPageReplace(const AuthPage(), context);
      }else{
        nextPageReplace(const MainActivity(), context);
      }
    });

    return const Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 60,
        ),
      ),
    );
  }
}
