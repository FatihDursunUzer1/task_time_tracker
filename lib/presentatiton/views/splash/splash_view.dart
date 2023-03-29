import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:task_time_tracker/core/application/constants/color_constants.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackGround.color,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            displayLogo(),
            LoadingAnimationWidget.inkDrop(
                color: Colors.deepPurpleAccent, size: 50)
          ],
        ),
      ),
    );
  }

  Padding displayLogo() {
    return Padding(
        padding: EdgeInsets.all(32),
        child: Image.asset('assets/icon/ic_logo.png'));
  }
}
