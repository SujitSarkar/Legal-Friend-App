import 'package:flutter/material.dart';
import 'package:legal_friend/pages/archive_details.dart';
import 'package:legal_friend/tiles/app_bar.dart';
import 'package:legal_friend/tiles/archive_tile.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
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
          bottomText: '${Variables.sorboseshUpdateBoi}6/2020 ${Variables.porjonto}',
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
      SizedBox(height: size.width*.04),
      Container(
        width: size.width*.7,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: size.width * .02,),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue,width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(size.width*.02)),
        ),
        child: Text(Variables.songrokkhitoArchive,style: TextStyle(
            fontSize: size.width * .04,
            fontFamily: 'niladriFontLite',color: Colors.blue)),
      ),
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
