import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:four_you_ecommerce/core/constants/app_colors.dart';
import 'package:four_you_ecommerce/core/di/di.dart';
import 'package:four_you_ecommerce/core/routing/router.dart';
import 'package:four_you_ecommerce/core/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
  EasyLoading.instance
    ..backgroundColor = Colors.black.withOpacity(0.5) // Semi-transparent black
    ..textColor = Colors.white
    ..indicatorColor = AppColors.primaryColor
    ..loadingStyle = EasyLoadingStyle.custom
    ..maskColor = Colors.black.withOpacity(0.5) // Dark mask behind loader
    ..boxShadow = [const BoxShadow(color: Colors.transparent)] // Remove shadow
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle // Change animation
    ..dismissOnTap = false;
  await init();
  final appRouter = AppRouter(isFirstTime);
  runApp(MyApp(
    appRouter: appRouter,
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp.router(
            restorationScopeId: 'app',
            title: 'Shopping For You',
            debugShowCheckedModeBanner: false,
            builder: EasyLoading.init(),
            themeMode: ThemeMode.light,
            theme: lightTheme,
            darkTheme: darkTheme,
            backButtonDispatcher: RootBackButtonDispatcher(),
            routeInformationParser: appRouter.router.routeInformationParser,
            routeInformationProvider: appRouter.router.routeInformationProvider,
            routerDelegate: appRouter.router.routerDelegate,
          );
        });
  }
}
