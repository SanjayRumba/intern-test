import 'dart:io';

import 'package:dio/dio.dart';
import 'package:intern/core/apiresponse.dart';

import '../core/networkstatus.dart';

class Api{
  Dio dio= Dio();
  Api(){dio.options.headers["content-type"]="application/json";}   //server bata json format ko data aauxa

post(String url,var data)async{
  try {
    Response response=await dio.post(url,data: data);
    if(response.statusCode==200||response.statusCode==201){
      return ApiResponse(networkStatus: NetworkStatus.success,data: response.data);  //server bata aauni state
    }
    else{
      return ApiResponse(networkStatus: NetworkStatus.error,errorMessage: "Bad Request");
    }

  }on DioError catch(e){
    if(e.response?.statusCode==400){
      return ApiResponse(networkStatus: NetworkStatus.error,errorMessage: "Bad Request");
    }
    else if(e.error is SocketException){
      return ApiResponse(networkStatus: NetworkStatus.error,errorMessage: "No Internet Connection");
    }
    else{
      return ApiResponse(networkStatus: NetworkStatus.error,errorMessage: e.toString());
    }

  }

}
Future <ApiResponse> get(String url)async{
  try {
    Response response=await dio.get(url);
    if(response.statusCode==200||response.statusCode==201){
      return ApiResponse(networkStatus: NetworkStatus.success,data: response.data);  //server bata aauni data
    }
    else{
      return ApiResponse(networkStatus: NetworkStatus.error,errorMessage: "Bad Request");
    }

  }on DioError catch(e){
    if(e.response?.statusCode==400){
      return ApiResponse(networkStatus: NetworkStatus.error,errorMessage: "Bad Request");
    }
    else if(e.error is SocketException){
      return ApiResponse(networkStatus: NetworkStatus.error,errorMessage: "No Internet Connection");
    }
    else{
      return ApiResponse(networkStatus: NetworkStatus.error,errorMessage: e.toString());
    }

  }

}
}