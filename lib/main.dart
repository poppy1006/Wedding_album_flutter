import 'package:flutter/material.dart';
import 'package:wedding_app/splash_screen/splash_screen.dart';
import 'package:wedding_app/screens/gallery_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), 
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // home: const GalleryScreen(),
      home: SplashScreen(),
    );
  }
}



