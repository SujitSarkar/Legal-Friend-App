import 'package:flutter/material.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/app_bar.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/ni_act_tile.dart';
import 'package:legal_friend/variables/variables.dart';
import 'package:provider/provider.dart';

class SearchtList extends StatefulWidget {
  const SearchtList({Key key}) : super(key: key);

  @override
  _SearchtListState createState() => _SearchtListState();
}

class _SearchtListState extends State<SearchtList> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: PublicAppBar(
          pageName: publicProvider.togglePageName(),
          bottomText: '${Variables.sorboseshUpdateBoi}৬/২০২০ ${Variables.porjonto}',
          image: 'assets/home_image/bodli_khana.png',
          color: publicProvider.toggleHeaderColor(),
        ),
      ),
      body: _bodyUI(size,publicProvider),
      bottomNavigationBar: BottomTile(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _bodyUI(Size size,PublicProvider publicProvider)=>ListView.builder(
    itemCount: 20,
    itemBuilder: (context, index)=>SearchListTile(index: index,),
  );
}
