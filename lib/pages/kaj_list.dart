import 'package:flutter/material.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/variables/variables.dart';

import 'archive_list.dart';

class KajList extends StatefulWidget {
  @override
  _KajListState createState() => _KajListState();
}

class _KajListState extends State<KajList> {

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

          Image.asset('assets/home_image/kaj_list.png',height: size.width*.4,width: size.width*.8),

          Container(
            width: size.width*.8,
            //padding:  EdgeInsets.symmetric(horizontal: size.width*.07),
            child: Text(Variables.kajListMgs,
              textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[900], fontSize: size.width * .06, fontFamily: 'barkatFontBold'),),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientButton(
                onPressed: ()=>Navigator.pop(context),
                child: Text(Variables.agerMenu, style: TextStyle(
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
                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchiveList())),
                child: Text(Variables.archive, style: TextStyle(
                    fontSize: size.width * .06, fontFamily: 'niladriFontLite')),
                height: size.width * .12,
                width: size.width*.8,
                borderRadius: size.width * .03,
                gradientColors: [
                  Color(0xFF0D47A1),
                  Color(0xFF1976D2),
                ],
              ),

            ],
          ),
          Container(),

        ],
      ),
    ),
  );
}
