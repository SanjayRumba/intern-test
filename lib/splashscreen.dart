import 'package:flutter/material.dart';
import 'package:intern/homepage.dart';
import 'package:intern/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({Key? key}) : super(key: key);

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  @override
  void initState() {
    navigateToAnotherPage();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 150),
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Image.network('https://static.thenounproject.com/png/4188546-200.png')),
          ),
        ],
      ),
    );
  }

  navigateToAnotherPage() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isLogin = prefs.getBool('isLogin') ?? false;
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => !isLogin
                  ? const LoginForm()
                  : Homepage()),
          (Route<dynamic> route) => false);
    });
  }
}