import 'package:flutter/material.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/app_bar.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/notification_widget.dart';
import 'package:legal_friend/tiles/search_list_tile.dart';
import 'package:legal_friend/variables/variables.dart';
import 'package:provider/provider.dart';

import 'no_result_found.dart';

class SearchtList extends StatefulWidget {

  @override
  _SearchtListState createState() => _SearchtListState();
}

class _SearchtListState extends State<SearchtList> {
  bool _isLoading=true;

  @override
  initState(){
    super.initState();
    _fetchSearchedData();
  }

  Future<void> _fetchSearchedData()async{
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context,listen: false);
    String collectionName='';

    if(publicProvider.pageValue==Variables.niAct) collectionName='NIAct';
    if(publicProvider.pageValue==Variables.madokDondobidhi) collectionName='MadokDondobidhi';
    if(publicProvider.pageValue==Variables.bisesTribunal) collectionName='BishesTribunal';

    await publicProvider.getSearchedDataList(collectionName);
    setState(()=> _isLoading=false);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: PublicAppBar(
          pageName: publicProvider.togglePageName(),
          bottomText: '${Variables.sorboseshUpdateBoi}${publicProvider.toggleLastUpdatedBoiNo()} ${Variables.porjonto}',
          image: 'assets/home_image/bodli_khana.png',
          color: publicProvider.toggleHeaderColor(),
        ),
      ),
      body: _isLoading
          ? Center(child: spinCircle())
          : publicProvider.searchedList.isNotEmpty
          ? _bodyUI(size,publicProvider)
          : NoResultFound(),
      bottomNavigationBar: BottomTile(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _bodyUI(Size size,PublicProvider publicProvider)=>ListView.builder(
    itemCount: publicProvider.searchedList.length,
    itemBuilder: (context, index)=>SearchListTile(index: index,dataList: publicProvider.searchedList),
  );
}
