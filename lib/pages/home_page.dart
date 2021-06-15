import 'package:flutter/material.dart';
import 'package:legal_friend/pages/archive_list.dart';
import 'package:legal_friend/pages/bodli_khana.dart';
import 'package:legal_friend/pages/kaj_list.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/tiles/home_tile.dart';
import 'package:legal_friend/variables/variables.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);

    return Scaffold(
      body: _bodyUI(size),
      floatingActionButton: BottomTile(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _bodyUI(Size size) =>
      Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HomeMainButton(
              onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>BodliKhana())),
                image: 'assets/home_image/bodli_khana.png',
            ),
            SizedBox(height: size.width * .04),
            HomeMainButton(
              onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>KajList())),
              image: 'assets/home_image/kaj_list.png',
            ),
            SizedBox(height: size.width * .2),

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
               //Color(0xFF42A5F5),
              ],
            ),
          ],
        ),
      );
}
