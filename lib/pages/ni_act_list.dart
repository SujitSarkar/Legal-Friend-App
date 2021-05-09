import 'package:flutter/material.dart';
import 'package:legal_friend/tiles/app_bar.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/ni_act_tile.dart';

class NIActList extends StatefulWidget {
  const NIActList({Key key}) : super(key: key);

  @override
  _NIActListState createState() => _NIActListState();
}

class _NIActListState extends State<NIActList> {
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
          pageName: 'Gb.AvB G±',
          bottomText: 'me©‡kl Avc‡WUt eB-6/2020 ch©š—',
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
