import 'package:flutter/material.dart';
import 'package:legal_friend/pages/ni_act_page.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';

class BodliKhana extends StatefulWidget {

  @override
  _BodliKhanaState createState() => _BodliKhanaState();
}

class _BodliKhanaState extends State<BodliKhana>{

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: _bodyUI(size),
      floatingActionButton: BottomTile(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _bodyUI(Size size)=>Container(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Image.asset('assets/home_image/bodli_khana.png',height: size.width*.4,width: size.width*.8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientButton(
                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>NIActPage())),
                child: Text('Gb.AvB G±', style: TextStyle(
                    fontSize: size.width * .06, fontFamily: 'niladriFontLite')),
                height: size.width * .12,
                width: size.width*.8,
                borderRadius: size.width * .03,
                gradientColors: [
                  Colors.red[600],
                  Colors.red[500],
                ],
              ),
              SizedBox(height: size.width * .04),

              GradientButton(
                onPressed: () {},
                child: Text('gv`K/`Ûwewa', style: TextStyle(
                    fontSize: size.width * .06, fontFamily: 'niladriFontLite')),
                height: size.width * .12,
                width: size.width*.8,
                borderRadius: size.width * .03,
                gradientColors: [
                  Colors.green[700],
                  Colors.green[600],
                ],
              ),
              SizedBox(height: size.width * .04),

              GradientButton(
                onPressed: () {},
                child: Text('we‡kl UªvBe¨ybvj', style: TextStyle(
                    fontSize: size.width * .06, fontFamily: 'niladriFontLite')),
                height: size.width * .12,
                width: size.width*.8,
                borderRadius: size.width * .03,
                gradientColors: [
                  Colors.yellow[900],
                  Colors.yellow[800],
                ],
              ),

            ],
          ),
          GradientButton(
            onPressed: () {},
            child: Text('AvK©vBf', style: TextStyle(
                fontSize: size.width * .06, fontFamily: 'niladriFontLite')),
            height: size.width * .12,
            width: size.width*.8,
            borderRadius: size.width * .03,
            gradientColors: [
              Color(0xFF0D47A1),
              Color(0xFF1976D2),
            ],
          ),
          Container(),
        ],
      ),
    ),
  );
}
