class RegistrationResponse {
  List<dynamic>? non_field_errors;
  List<dynamic>? username;
  List<dynamic>? email;
  List<dynamic>? password1;
  String? key;

  RegistrationResponse(
      {this.non_field_errors,
      this.username,
      this.email,
      this.password1,
      this.key});

  factory RegistrationResponse.fromJson(mapOfResponseBody) {
    return RegistrationResponse(
      non_field_errors: mapOfResponseBody['non_field_errors'],
      username: mapOfResponseBody['username'],
      email: mapOfResponseBody['email'],
      password1: mapOfResponseBody['password1'],
      key: mapOfResponseBody['key'],
    );
  }
}