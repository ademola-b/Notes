class LoginResponse {
  String? key;
  List<dynamic>? non_field_errors;

  LoginResponse({this.key, this.non_field_errors});

  factory LoginResponse.fromJson(mapOfBody) {
    return LoginResponse(
      non_field_errors: mapOfBody['non_field_errors'],
      key: mapOfBody['key'],
    );
  }
}