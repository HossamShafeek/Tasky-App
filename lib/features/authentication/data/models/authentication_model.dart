
class AuthenticationModel {
  String accessToken;
  String refreshToken;
  String id;

  AuthenticationModel({required this.accessToken,required this.refreshToken,required this.id});

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(

      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      id: json['_id'] as String,
    );
  }

}
