import 'package:four_you_ecommerce/core/network/dio/dio_helper.dart';
import 'package:four_you_ecommerce/core/network/repository.dart';
import 'package:four_you_ecommerce/modules/authentication/cubit/auth_cubit.dart';
import 'package:four_you_ecommerce/modules/cart/cubit/cart_cubit.dart';
import 'package:four_you_ecommerce/modules/home/cubit/home_cubit.dart';
import 'package:four_you_ecommerce/modules/layout/cubit/home_layout_cubit.dart';
import 'package:get_it/get_it.dart';

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
  di.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      di<Repository>(),
    ),
  );
  di.registerLazySingleton<HomeLayoutCubit>(
    () => HomeLayoutCubit(),
  );
  di.registerLazySingleton<CartCubit>(
    () => CartCubit(),
  );

  di.registerLazySingleton<HomeCubit>(
    () => HomeCubit(di<Repository>()),
  );
}
