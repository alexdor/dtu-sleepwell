import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep_well/components/introduction_library.dart';
import 'package:sleep_well/components/widgets.dart';
import 'package:sleep_well/models/page_view_model.dart';
import 'package:sleep_well/models/settings.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key key}) : super(key: key);

  List<PageViewModel> _buildPages() => [
        PageViewModel(
          //"First title page",
          //"Text of the first page of this onboarding",
          "A personal guide to health and hapiness, right in your pocket.",
          " ",
          image: Align(
            child: FirstIntroScreenImage(),
            alignment: Alignment.bottomCenter,
          ),
        ),
        PageViewModel(
          "Place the device close to your bed. ",
          "Our application tracks temperature and humidity to help you have refreshing mornings.",
          image: Align(
            child: SecondIntroScreenImage(),
            alignment: Alignment.bottomCenter,
          ),
        ),
        PageViewModel(
          "Prepare yourself for sleep ",
          "Lie on the bed, take a few deep breaths, and close your eyes, allowing the body to begin powering down.",
          image: Align(
            child: ThirdIntroScreenImage(),
            alignment: Alignment.bottomCenter,
          ),
        ),
        PageViewModel(
          "...unplug an hour before bed",
          "Try keeping screen use to a minimum, at least an hour before bed.",
          image: Align(
            child: ForthIntroScreenImage(),
            alignment: Alignment.bottomCenter,
          ),
        ),
        PageViewModel(
          "List your goals!",
          "Make smaller steps toward that difficult goal.",
          image: Align(
            child: FifthIntroScreenImage(),
            alignment: Alignment.bottomCenter,
          ),
        ),
      ];

  void _onIntroEnd(context) {
    changeShowIntro(false);
    Navigator.pushNamed(context, '/');
  }

  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: _buildPages(),
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skip: const Text(
        'Skip',
        style: TextStyle(
          fontFamily: 'Comfortaa',
          color: Color(0xFFF47D30),
          fontSize: 25.0,
        ),
      ),
      next: const Icon(
        Icons.arrow_forward,
        size: 40.0,
        color: Color(0xFFF47D30),
      ),
      done: const Text(
        'Done',
        style: TextStyle(
          fontFamily: 'Comfortaa',
          color: Color(0xFFF47D30),
          fontSize: 25.0,
        ),
      ),
    );
  }
}
