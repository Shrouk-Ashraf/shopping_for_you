import 'package:flutter/material.dart';
import 'package:four_you_ecommerce/core/constants/app_colors.dart';
import 'package:four_you_ecommerce/core/routing/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svg_flutter/svg_flutter.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: IntroductionScreen(
          safeAreaList: const [false, false, true, false],
          bodyPadding: const EdgeInsets.only(top: 80),
          pages: [
            PageViewModel(
              title: "Choose Your Product",
              bodyWidget: const Text(
                "Welcome To a World Of Limitless Choices - Your Perfect Products Awaits",
                textAlign: TextAlign.center,
              ),
              image: SvgPicture.asset("assets/images/first_onboarding.svg"),
            ),
            PageViewModel(
              title: "Select Payment Method",
              bodyWidget: const Text(
                "For Seamless Transactions, Choose your Payment Path- Your Convenience, Our Priority",
                textAlign: TextAlign.center,
              ),
              image: SvgPicture.asset("assets/images/second_onboarding.svg"),
            ),
            PageViewModel(
              title: "Deliver At Your Door Step",
              bodyWidget: const Text(
                "From Our Doorstep to Yours - Secure and Contactless Delivery",
                textAlign: TextAlign.center,
              ),
              image: SvgPicture.asset("assets/images/third_onboarding.svg"),
            )
          ],
          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(40.0, 10.0),
            activeColor: Theme.of(context).brightness == Brightness.light
                ? AppColors.black
                : Colors.white,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black26
                : Colors.white60,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
          ),
          showNextButton: false,
          showDoneButton: true,
          showSkipButton: true,
          overrideDone: InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isFirstTime', false);
              debugPrint("done with ${prefs.getBool('isFirstTime')}");
              context.goNamed(Routes.login);
            },
            child: const Text(
              "Done",
              style: TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.end,
            ),
          ),
          overrideSkip: InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isFirstTime', false);
              debugPrint("done with ${prefs.getBool('isFirstTime')}");
              context.goNamed(Routes.login);
            },
            child: const Text(
              "Skip",
              style: TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ),
    );
  }
}
