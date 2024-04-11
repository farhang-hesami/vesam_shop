class Authentication {
  String? fullName;
  String? phoneNumber;
  String? email;
  String? password;
  String? accessToken;

  Authentication({this.fullName, this.phoneNumber, this.email, this.password});

  Authentication.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
