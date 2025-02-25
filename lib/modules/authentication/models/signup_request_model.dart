class SignUpRequestModel {
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? userName;
  String? phoneNumber;

  SignUpRequestModel({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "name": {
        "firstname": firstName,
        "lastname": lastName,
      },
      "phone": phoneNumber,
      "username": userName,
    };
  }
}
