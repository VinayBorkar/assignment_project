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
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        color: Colors.white), //tile font size, weight and color
    bodyTextStyle: TextStyle(fontSize: 19.0, color: Colors.white),
    //body text size and color
    descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
    //decription padding
    imagePadding: EdgeInsets.all(20), //image padding
  );

  Widget introImage(String assetName) {
    //widget to show intro image
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
    //Navigate to home page and remove the intro screen history
    //so that "Back" button wont work.
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: UniqueKey(),
      globalBackgroundColor: Colors.deepOrangeAccent,
      //main background of screen
      pages: [
        //set your page view here
        PageViewModel(
          title: "Fractional shares",
          body:
              "Instead of having to buy an entire share, invest any amount you want.",
          image: introImage('assets/onboarding_1.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Fractional shares",
          body:
              "Instead of having to buy an entire share, invest any amount you want.",
          image: introImage('assets/onboarding_2.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Fractional shares",
          body:
              "Instead of having to buy an entire share, invest any amount you want.",
          image: introImage('assets/onboarding_3.svg'),
          decoration: pageDecoration,
        ),

        //add more screen here
      ],

      onDone: () => goHomepage(context), //go to home page on done
      onSkip: () => goHomepage(context), // You can override on skip
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
        size: Size(10.0, 10.0), //size of dots
        color: Colors.white, //color of dots
        activeSize: Size(22.0, 10.0),
        //activeColor: Colors.white, //color of active dot
        activeShape: RoundedRectangleBorder(
          //shave of active dot
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
