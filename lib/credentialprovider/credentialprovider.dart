import 'package:flutter/material.dart';
import 'package:intern/Model/credentialmodel.dart';
import 'package:intern/core/statusutil.dart';
import 'package:intern/repo/credentialrepo.dart';
import 'package:intern/repo/repoimpl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/apiresponse.dart';
import '../core/networkstatus.dart';


class CredentialProvider extends ChangeNotifier{        //private kura lai sabai thau ma access dina lai getter ra setter banako
  String? phoneNumber;
  String? accessToken;
  String? password;
  CredentialRepo credentialRepo=CredentialRepoImpl();
  StatusUtil _registerState = StatusUtil.none;
  StatusUtil _loginStatus = StatusUtil.none;// yo chai login ko lagi state haru


  setRegisterState(StatusUtil statusUtil){
    _registerState=statusUtil;

  }
  StatusUtil get getRegisterState=>_registerState;




  setLoginStatus(StatusUtil statusUtil){
    _loginStatus=statusUtil;

  }

  StatusUtil get getLoginStatus=>_loginStatus;      


Future<void> registerUser(Credential credential) async {
    if (_registerState != StatusUtil.loading) {
      setRegisterState(StatusUtil.loading);
    }
    ApiResponse response = await credentialRepo.registerUser(credential);
    if (response.networkStatus == NetworkStatus.success) {
      setRegisterState(StatusUtil.success);
    } else if (response.networkStatus == NetworkStatus.error) {
      var errorMessage = response.errorMessage;
      setRegisterState(StatusUtil.error);
    }
  }
Future<void> loginAdmin(Credential credential) async {
    if (_loginStatus != StatusUtil.loading) {
      setLoginStatus(StatusUtil.loading);
    }
    ApiResponse response = await credentialRepo.loginAdmin(credential);
    if (response.networkStatus == NetworkStatus.success) {
      accessToken=response.data['data']['accessToken'];
      setLoginStatus(StatusUtil.success);
    } else if (response.networkStatus == NetworkStatus.error) {
      var errorMessage = response.errorMessage;
      setLoginStatus(StatusUtil.error);
    }
  }

    saveValueToSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', true);
    await prefs.setString('phoneNumber', phoneNumber!);
    await prefs.setString('accessToken', accessToken!);
  }


}