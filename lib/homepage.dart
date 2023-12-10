import 'package:flutter/material.dart';
import 'package:intern/credentialprovider/credentialprovider.dart';
import 'package:intern/loginpage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return  Consumer<CredentialProvider>(
      builder: (context, credentialProvider, child) =>Scaffold(
        appBar: AppBar(
          title: Text('Test'),
          actions: [
            IconButton(onPressed: ()async{
                                    final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.remove('accessToken');
                                await prefs.remove('phoneNumber');
                                await prefs.remove('isLogin');
                                await Future.delayed(Duration(seconds: 2));
    
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => LoginForm(),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
    
            }, icon: Icon(Icons.logout_outlined))
          ],
    
        ),
    body: Column(
      children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(credentialProvider.accessToken??''),
          ],
        ),
      )
      ],
    ),
      ),
    );
  }
}