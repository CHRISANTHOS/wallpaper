import 'package:flutter/material.dart';
import 'package:wallpaper/widgets/custom_button.dart';
import 'package:wallpaper/utils/router.dart';
import 'package:wallpaper/screens/main_activity.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: customButton(text: 'Continue with Google', onTap: (){
            nextPageReplace(const MainActivity(), context);
          }, bgColor: Colors.black54, textColor: Colors.white),
        ),
      ),
    );
  }
}
