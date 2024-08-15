import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedding_app/screens/gallery_screen.dart';
import 'package:wedding_app/widgets/constants.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  // ##################### SPLASH TIMER #####################

  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => const EndSplash()
            )
         )
    );
  }

  // ############## SPLASH SCREEN CONTENT ##############
  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    return Container(
      color: bgclr,
      //child:const Image(image: AssetImage('assets/Logo.png'))
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SizedBox(height: _mediaQuery.size.height * 0.2,),
          // SizedBox(height: 15,),
          Image.asset("assets/images/splash.png"),
          Align(
            alignment: Alignment.center,
            child: TextAnimator(
            Constants.SPLASH_NAME,
            style: GoogleFonts.alexBrush(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: txtclr,
              decoration: TextDecoration.none,
            ),
          )
          ),

          // TextAnimator(
          //   "Ashik & Afna",
          //   style: GoogleFonts.alexBrush(
          //     fontSize: 40,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.black,
          //     decoration: TextDecoration.none,
          //   ),
          // )
        ],
      ),
    );
  }
}

class EndSplash extends StatelessWidget {
  const EndSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GalleryScreen();
  }
}
