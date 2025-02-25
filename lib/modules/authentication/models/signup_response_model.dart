class SignUpResponseModel {
  int? id;
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? userName;
  String? phoneNumber;
  SignUpResponseModel({
    required this.id,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.phoneNumber,
  });

  SignUpResponseModel.fromJson(json) {
    id = json['id'];
  }
}
