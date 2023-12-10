import 'package:flutter/material.dart';
import 'package:intern/credentialprovider/credentialprovider.dart';
import 'package:intern/homepage.dart';
import 'package:intern/loginpage.dart';
import 'package:intern/splashscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CredentialProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
        ),
        home:const SplashScreens(),
      ),
    );
  }
}
