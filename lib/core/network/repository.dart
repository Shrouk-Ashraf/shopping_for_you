import 'package:four_you_ecommerce/core/constants/constants.dart';
import 'package:four_you_ecommerce/core/network/dio/dio_helper.dart';

class Repository {
  final DioHelper dioHelper;

  Repository({
    required this.dioHelper,
  });

  Future<void> login() async {
    try {
      final response = await dioHelper.post('${Constants.baseUrl}users',
          data: {'email': "Shrouk@gmail.com", "password": "123123"});
    } catch (e) {
      throw Exception(e);
    }
  }
}
