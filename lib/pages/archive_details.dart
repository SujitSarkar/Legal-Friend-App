import 'package:flutter/material.dart';
import 'package:legal_friend/pages/search_page.dart';
import 'package:legal_friend/tiles/app_bar.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/variables/variables.dart';

class ArchiveDetails extends StatefulWidget {
  const ArchiveDetails({Key key}) : super(key: key);

  @override
  _ArchiveDetailsState createState() => _ArchiveDetailsState();
}

class _ArchiveDetailsState extends State<ArchiveDetails> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: PublicAppBar(
          pageName: Variables.niAct,
          bottomText: '${Variables.sorboseshUpdateBoi}6/2020 ${Variables.porjonto}',
          image: 'assets/home_image/bodli_khana.png',
          color: Colors.red[400],
        ),
      ),
      body: _bodyUI(size),
      bottomNavigationBar: BottomTile(),
      // floatingActionButton: BottomTile(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _bodyUI(Size size)=>SingleChildScrollView(
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.width*.2),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              //text: 'Hello ',
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: size.width*.04,
                fontFamily: 'barkatFontBold'
              ),
              children: <TextSpan>[
                TextSpan(text: '${Variables.cR}2925/2019\n',style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.width*.06,)),
                TextSpan(text: '†gvt kvn Avjg evbvg Avãyj Avnv`\n',style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.width*.06)),
                TextSpan(text: '${Variables.dayraNo} 18392/2020\n'),
                TextSpan(text: '${Variables.porobortiTarikh} 04/05/2021Bs\n'),
                TextSpan(text: '${Variables.amoliAdalot}\n'),
                TextSpan(text: 'wm.Gg.Gg\n'),
                TextSpan(text: '${Variables.bicaricAdalot}\n'),
                TextSpan(text: '5g hyM¥ gnvbMi `vqiv RR Av`vjZ\n'),
                TextSpan(text: '${Variables.boiNo} 01\n'),
              ],
            ),
          ),
          SizedBox(height: size.width*.2),

          GradientButton(
            onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage())),
              child: Text(Variables.abarOnusondhanKorun, style: TextStyle(
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
    ),
  );
}
