class UserResponse {
  int? pk;
  String? username;
  String? email;
  String? first_name;
  String? last_name;

  UserResponse(
      {this.pk, this.username, this.email, this.first_name, this.last_name});

  factory UserResponse.fromJson(json) {
    return UserResponse(
        pk: json['pk'],
        username: json['username'],
        email: json['email'],
        first_name: json['first_name'],
        last_name: json['last_name']);
  }
}