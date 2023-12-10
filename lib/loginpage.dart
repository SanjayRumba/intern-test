import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intern/Model/credentialmodel.dart';
import 'package:intern/core/statusutil.dart';
import 'package:intern/credentialprovider/credentialprovider.dart';
import 'package:intern/homepage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custombtn.dart';
import 'customform.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isVisible = false;

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<CredentialProvider>(
      builder: (context, credentialProvider, child) {  //credentialProvider =object
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Form(
      key: _formkey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
        ),
        const Center(
          child: Text(
            "Login",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
          CustomForm(
            inputFormatter: [LengthLimitingTextInputFormatter(10)],
            keyboardType: TextInputType.phone,
            prefixIcon: const Icon(Icons.phone_outlined),
            hintText: "Phone",
            validator: ((value) {
              if (value!.isEmpty) {
                return "Field is required to be filled";
              } else if (value.length < 10) {
                return "Phone number must have 10 digits";
              }
              return null;
            }),
            onChanged: (value) {
              credentialProvider.phoneNumber=value;
            },
          ),
        CustomForm(
          obsecureText: isVisible ? false : true,
          suffixOnPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
          showSuffix: true,
          validator: ((value) {
            if (value!.isEmpty) {
              return "password field must be filed up";
            } else {
              return null;
            }
          }),
          isVisible: isVisible,
          suffixIcon: isVisible
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
          hintText: "Password",
          maxLine: 1,
          prefixIcon: const Padding(
              padding: EdgeInsets.all(10), child: Icon(Icons.lock)),
          onChanged: (value) {
            credentialProvider.password = value;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        CustomButton(
          text: "Login",
          onPressed: () async {
            FocusScope.of(context).unfocus();

            if (_formkey.currentState!.validate()) {
                Credential credential=Credential(
                phoneNumber:credentialProvider.phoneNumber,password: credentialProvider.password);
                await credentialProvider.loginAdmin(credential).then((value){
                 if(credentialProvider.getLoginStatus==StatusUtil.success){
                  credentialProvider.saveValueToSharedPreference();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Homepage(),));
              }
               else if(credentialProvider.getLoginStatus==StatusUtil.error){
                alertBox();
              }
                });
            }

          },
        ),
        const Padding(
          padding:  EdgeInsets.only(left: 300, top: 10),
          child: Center(
            child: Text(
              "Forget Password?",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        const Padding(
          padding:EdgeInsets.only(top: 10),
          child: Row(
            children:[
              Flexible(
                  child: Divider(
                thickness: 0.5,
                color: Colors.black,
              )),
              SizedBox(
                width: 20,
              ),
              Text("Or",
                  style: TextStyle(
                      color: Colors.black, fontSize: 16, fontFamily: "Andika"
                      // decoration: TextDecoration.underline,
                      )),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: Divider(
                thickness: 0.5,
                color: Colors.black,
              )),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
       const Padding(
          padding:EdgeInsets.only(
            top: 30,
            left: 60,
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 80),
            child: Row(
              children: [
                 Text("Don't have an account? ",
                    style: TextStyle(fontSize: 16, fontFamily: "Andika")),
                 Text("Sign up",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Andika",
                      color: Color(0xFF3173BF),
                    )),
              ],
            ),
          ),
        ),
      ]),
    )
        );
      },
    );
    
  }


  alertBox() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(8),
          title: const Text("Invalid"),
          content: const Text(" Invalid Credentials"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
