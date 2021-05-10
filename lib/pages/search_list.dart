import 'package:flutter/material.dart';
import 'package:legal_friend/tiles/app_bar.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/ni_act_tile.dart';
import 'package:legal_friend/variables/variables.dart';

class SearchtList extends StatefulWidget {
  const SearchtList({Key key}) : super(key: key);

  @override
  _SearchtListState createState() => _SearchtListState();
}

class _SearchtListState extends State<SearchtList> {
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
      //floatingActionButton: BottomTile(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _bodyUI(Size size)=>ListView.builder(
    itemCount: 20,
    itemBuilder: (context, index)=>NIActTile(index: index,),
  );
}
