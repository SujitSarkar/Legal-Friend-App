import 'package:flutter/material.dart';
import 'package:legal_friend/pages/bodli_khana.dart';
import 'package:legal_friend/pages/search_page.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/app_bar.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/variables/variables.dart';
import 'package:provider/provider.dart';

class ArchiveDetails extends StatefulWidget {
  const ArchiveDetails({Key key}) : super(key: key);

  @override
  _ArchiveDetailsState createState() => _ArchiveDetailsState();
}

class _ArchiveDetailsState extends State<ArchiveDetails> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: PublicAppBar(
          pageName: '',//Variables.niAct,
          bottomText: '',
          image: 'assets/home_image/bodli_khana.png',
          color: Theme.of(context).primaryColor,
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
                fontSize: size.width*.04
              ),
              children: <TextSpan>[
                TextSpan(text: '${Variables.cR}২৯১৫/২০১৯\n',style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.width*.06,)),
                TextSpan(text: 'মোঃ শাহ আলম বানাম আব্দুল আহাদ\n',style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.width*.06)),
                TextSpan(text: '${Variables.dayraNo} ১৮৩৯২/২০২০\n'),
                TextSpan(text: '${Variables.porobortiTarikh} ০৪/০৫/২০২১ইং\n'),
                TextSpan(text: '${Variables.amoliAdalot}\n'),
                TextSpan(text: 'সিএমএম\n'),
                TextSpan(text: '${Variables.bicaricAdalot}\n'),
                TextSpan(text: '৫ম যুগ্ম মহানগর দায়রা জজ আদালত\n'),
                TextSpan(text: '${Variables.boiNo} ০১\n'),
              ],
            ),
          ),
          SizedBox(height: size.width*.2),

          GradientButton(
            onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>BodliKhana())),
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
