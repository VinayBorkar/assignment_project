import 'package:assignment_project/screens/initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageDecoration pageDecoration = const PageDecoration(
    titleTextStyle: TextStyle(
        fontSize: 28.0, fontWeight: FontWeight.w700, color: Colors.white),
    bodyTextStyle: TextStyle(fontSize: 19.0, color: Colors.white),
    descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
    imagePadding: EdgeInsets.all(20),
  );

  Widget introImage(String assetName) {
    return Align(
      child: SvgPicture.asset(assetName, width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  void goHomepage(context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return InitialScreen();
    }), (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: UniqueKey(),
      globalBackgroundColor: Colors.deepOrangeAccent,
      pages: [
        PageViewModel(
          title: "Page 1",
          body: "Introduction to the ToDo app",
          image: introImage('assets/onboarding_1.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Page 2",
          body: "Introduction to the ToDo app",
          image: introImage('assets/onboarding_2.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Page 3",
          body: "Introduction to the ToDo app",
          image: introImage('assets/onboarding_3.svg'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => goHomepage(context),
      onSkip: () => goHomepage(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text(
        'Skip',
        style: TextStyle(color: Colors.white),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      done: const Text(
        'Getting Stated',
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.white,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
