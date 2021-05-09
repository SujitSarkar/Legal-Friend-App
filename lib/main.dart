import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legal_friend/colors/pColor.dart';
import 'package:legal_friend/pages/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(microseconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
              title: 'Legal Friend',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                backgroundColor: Colors.white,
                primarySwatch: MaterialColor(0xff00AE51, PColor.colorMap),
              ),
              home: Splash()
          );
        } else {
          // Loading is done, return the app:
          return MaterialApp(
            title: 'Legal Friend',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              backgroundColor: Colors.white,
              primarySwatch: MaterialColor(0xff00AE51, PColor.colorMap),
            ),
            home: HomePage(),
          );
        }
      },
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/logo/splash_image.png'),
      ),
    );
  }
}
