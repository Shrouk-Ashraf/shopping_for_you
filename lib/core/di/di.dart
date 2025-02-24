import 'package:four_you_ecommerce/core/network/dio/dio_helper.dart';
import 'package:four_you_ecommerce/core/network/repository.dart';
import 'package:four_you_ecommerce/modules/authentication/cubit/login_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

GetIt di = GetIt.I;

Future init() async {
  di.allowReassignment == true;

  if (!di.isRegistered<DioHelper>()) {
    di.registerLazySingleton<DioHelper>(() => DioHelper());
  }

  if (!di.isRegistered<Repository>()) {
    di.registerLazySingleton<Repository>(
      () => Repository(
        dioHelper: di<DioHelper>(),
      ),
    );
  }
  di.registerLazySingleton<LoginCubit>(
    () => LoginCubit(
      di<Repository>(),
    ),
  );
}
