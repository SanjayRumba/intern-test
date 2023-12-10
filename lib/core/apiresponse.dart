import 'package:intern/core/networkstatus.dart';

class ApiResponse{
  final NetworkStatus networkStatus;
  final String? errorMessage;
  final dynamic data;

  ApiResponse({required this.networkStatus,this.errorMessage,this.data});

}