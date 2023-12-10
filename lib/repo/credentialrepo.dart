
import 'package:intern/core/apiresponse.dart';

import '../Model/credentialmodel.dart';

abstract class CredentialRepo{
  Future <ApiResponse> registerUser(Credential credential);   //data abstraction hiding data
  Future <ApiResponse> loginAdmin(Credential credential);   //data abstraction hiding data
}