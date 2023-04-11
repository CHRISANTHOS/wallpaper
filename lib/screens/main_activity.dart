import 'package:flutter/material.dart';
import 'package:wallpaper/screens/bottom_nav_pages/wallpaper_home/home_page.dart';
import 'package:wallpaper/screens/bottom_nav_pages/download_page.dart';
import 'package:wallpaper/provider/auth_provider.dart';
import 'package:wallpaper/utils/router.dart';
import 'package:wallpaper/screens/Authentication/auth_page.dart';


class MainActivity extends StatefulWidget {
  const MainActivity({Key? key}) : super(key: key);

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {

  int currentIndex = 0;

  List<Map> bottomNavItems =[
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.download, 'label': 'Download'},
  ];

  List<Widget> pages = [WallPaperHome(), DownloadPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WallPaper App'),
        actions: [
          IconButton(onPressed: (){
            AuthProvider().signOut().then((value) {
              nextPageReplace(const AuthPage(), context);
            });
          }, icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value){
          setState(() {
            currentIndex = value;
          });
        },
        items: List.generate(bottomNavItems.length, (index) {
          final data = bottomNavItems[index];
          return BottomNavigationBarItem(icon: Icon(data['icon']), label: data['label']);
        }),
      ),
    );
  }
}
