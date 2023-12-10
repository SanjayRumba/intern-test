
import 'package:intern/Model/credentialmodel.dart';
import 'package:intern/core/apiconst.dart';
import 'package:intern/core/apiresponse.dart';
import 'package:intern/repo/api.dart';
import 'package:intern/repo/credentialrepo.dart';

class CredentialRepoImpl implements CredentialRepo{
  Api api= Api();

  @override
  Future<ApiResponse> registerUser(Credential credential)async {
    ApiResponse apiResponse=await api.post(Apiconst.BASE_URL+Apiconst.REGISTER_USER_API,credential );
    return apiResponse;

  }
  
  @override
  Future<ApiResponse> loginAdmin(Credential credential )async {
    ApiResponse apiResponse=await api.post(Apiconst.BASE_URL+Apiconst.REGISTER_USER_API,credential );
    return apiResponse;
  }
} 