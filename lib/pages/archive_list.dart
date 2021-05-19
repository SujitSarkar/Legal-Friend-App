import 'package:flutter/material.dart';
import 'package:legal_friend/pages/archive_details.dart';
import 'package:legal_friend/tiles/app_bar.dart';
import 'package:legal_friend/tiles/archive_tile.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/variables/variables.dart';

class ArchiveList extends StatefulWidget {

  @override
  _ArchiveListState createState() => _ArchiveListState();
}

class _ArchiveListState extends State<ArchiveList> {
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
          pageName: '',//Variables.niAct,
          bottomText: '',
          image: 'assets/home_image/bodli_khana.png',
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: _bodyUI(size),
      bottomNavigationBar: BottomTile(),
      //floatingActionButton: BottomTile(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _bodyUI(Size size)=>Column(
    children: [
      //SizedBox(height: size.width*.04),
      GradientButton(
        onPressed: (){},
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
      SizedBox(height: size.width*.04),
      Expanded(
        child: ListView.builder(
          itemCount: 4,
          shrinkWrap: true,
          itemBuilder: (context, index)=>InkWell(
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchiveDetails())),
              child: ArchiveTile(index: index,)),
        ),
      ),
    ],
  );
}
