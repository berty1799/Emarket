import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:berty1/auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return AnimatedSplashScreen(
      backgroundColor: Color(0xFFE3F2FD),
      splash: Column(
        children: [
          Center(
            child: Lottie.asset('assets/Shopping bag.json'),
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
              child: Lottie.asset("assets/loading splash.json",
                  height: 200, width: 200))
        ],
      ),
      duration: 3500,
      splashIconSize: 500,
      nextScreen: Auth(),
    );
  }
}
