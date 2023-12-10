
class Credential{
  String? phoneNumber;
  String? password;

  Credential({this.phoneNumber, this.password});

  Credential.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['password'] = this.password;
    return data;
  }
}