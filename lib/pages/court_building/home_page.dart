import 'package:flutter/material.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:provider/provider.dart';

class CourtBuildingHomePage extends StatefulWidget {
  const CourtBuildingHomePage({Key key}) : super(key: key);

  @override
  _CourtBuildingHomePageState createState() => _CourtBuildingHomePageState();
}

class _CourtBuildingHomePageState extends State<CourtBuildingHomePage> {
  @override
  Widget build(BuildContext context) {
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomTile(),
       body: SafeArea(
         child: _bodyUI(publicProvider,size),
       ),
    );
  }

  Widget _bodyUI(PublicProvider publicProvider,Size size)=>Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [

      Image.asset('assets/home_image/court_building.png'),

      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GradientButton(
            onPressed: () {},
            child: Text('By Court',
                style: TextStyle(fontSize: size.width * .058)),
            height: size.width * .12,
            width: size.width * .8,
            borderRadius: size.width * .03,
            gradientColors: [
              Color(0xff004E36),
              Color(0xff00B771),
            ],
          ),
          SizedBox(height: size.width*.05),

          GradientButton(
            onPressed: () {},
            child: Text('By Building',
                style: TextStyle(fontSize: size.width * .058)),
            height: size.width * .12,
            width: size.width * .8,
            borderRadius: size.width * .03,
            gradientColors: [
              Color(0xff004F48),
              Color(0xff00AA98),
            ],
          ),
          SizedBox(height: size.width*.05),

          GradientButton(
            onPressed: () {},
            child: Text('Jurisdiction',
                style: TextStyle(fontSize: size.width * .058)),
            height: size.width * .12,
            width: size.width * .8,
            borderRadius: size.width * .03,
            gradientColors: [
              Color(0xff003F5C),
              Color(0xff0070B6),
            ],
          ),
          SizedBox(height: size.width*.05),
        ],
      )

    ],
  );
}
