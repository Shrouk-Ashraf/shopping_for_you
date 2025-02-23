import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:svg_flutter/svg_flutter.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: IntroductionScreen(
          safeAreaList: [false, false, true, false],
          bodyPadding: EdgeInsets.only(top: 80),
          pages: [
            PageViewModel(
              title: "Choose Your Product",
              bodyWidget: Text(
                "Welcome To a World Of Limitless Choices - Your Perfect Products Awaits",
                textAlign: TextAlign.center,
              ),
              image: SvgPicture.asset("assets/images/first_onboarding.svg"),
            ),
            PageViewModel(
              title: "Choose Your Product",
              bodyWidget: Text(
                "Welcome To a World Of Limitless Choices - Your Perfect Products Awaits",
                textAlign: TextAlign.center,
              ),
              image: SvgPicture.asset("assets/images/first_onboarding.svg"),
            )
          ],
          showNextButton: false,
          done: const Text("Done"),
          onDone: () {
            // On button pressed
          },
        ),
      ),
    );
  }
}
