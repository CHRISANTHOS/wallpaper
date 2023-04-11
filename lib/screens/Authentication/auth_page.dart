import 'package:flutter/material.dart';
import 'package:wallpaper/widgets/custom_button.dart';
import 'package:wallpaper/utils/router.dart';
import 'package:wallpaper/utils/snackbar.dart';
import 'package:wallpaper/screens/main_activity.dart';
import 'package:wallpaper/provider/auth_provider.dart';

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
          child: customButton(
              text: 'Continue with Google',
              onTap: () {
                AuthProvider().signInWithGoogle().then((value) {
                  nextPageReplace(const MainActivity(), context);
                }).catchError((e) {
                  showSnackBar(
                    context,
                    e.toString(),
                  );
                });
              },
              bgColor: Colors.black54,
              textColor: Colors.white),
        ),
      ),
    );
  }
}
