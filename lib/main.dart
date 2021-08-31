import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:legal_friend/pages/home_page.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/variables/pColor.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  firebase_core.Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 3000) //display duration of [showSuccess] [showError] [showInfo], default 2000ms.
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = Colors.black.withOpacity(0.75)
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.black.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
    // ..customAnimation = CustomAnimation();
  }
  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider<PublicProvider>(create: (_) => PublicProvider()),
    //   ],
    //   child: MaterialApp(
    //     title: 'Legal Friend',
    //     debugShowCheckedModeBanner: false,
    //     theme: ThemeData(
    //       backgroundColor: Colors.white,
    //       primarySwatch: MaterialColor(0xff00AE51, PColor.colorMap),
    //       canvasColor: Colors.transparent
    //     ),
    //     home: HomePage(),
    //     builder: EasyLoading.init(),
    //   ),
    // );
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
              title: 'Legal Friend',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                backgroundColor: Colors.white,
                primarySwatch: MaterialColor(0xff00AE51, PColor.colorMap),
                canvasColor: Colors.transparent
              ),
              home: Splash(),
              builder: EasyLoading.init(),
          );
        } else {
          // Loading is done, return the app:
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<PublicProvider>(create: (_) => PublicProvider()),
            ],
            child: MaterialApp(
              title: 'Legal Friend',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                backgroundColor: Colors.white,
                primarySwatch: MaterialColor(0xff00AE51, PColor.colorMap),
                canvasColor: Colors.transparent
              ),
              home: HomePage(),
              builder: EasyLoading.init(),
            ),
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
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Image.asset('assets/logo/splash_image.png'),
        ),
      ),
    );
  }
}
