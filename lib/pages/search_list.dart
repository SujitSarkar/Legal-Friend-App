import 'package:flutter/material.dart';
import 'package:legal_friend/model_class/bodli_khana_model.dart';
import 'package:legal_friend/pages/no_result_found.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/app_bar.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/search_list_tile.dart';
import 'package:legal_friend/variables/variables.dart';
import 'package:provider/provider.dart';

class SearchtList extends StatefulWidget {

  @override
  _SearchtListState createState() => _SearchtListState();
}

class _SearchtListState extends State<SearchtList> {

  List<BodliKhanaModel> _filteredSubList = [];
  List<BodliKhanaModel> _subList = [];
  int _counter=0;

  void _customInit(PublicProvider publicProvider){
    setState(()=> _counter++);
    if(publicProvider.pageValue==Variables.niAct) _subList=publicProvider.niActDataList;
    if(publicProvider.pageValue==Variables.madokDondobidhi) _subList=publicProvider.madokDataList;
    if(publicProvider.pageValue==Variables.bisesTribunal) _subList=publicProvider.tribunalDataList;
    //_filteredSubList = _subList;
    // setState(() {
    //   _filteredSubList = _subList.where((element) =>
    //   (element.jojCourt.toLowerCase().contains(publicProvider.bodliKhanaModel.jojCourt)
    //       && element.amoliAdalot.toLowerCase().contains(publicProvider.bodliKhanaModel.amoliAdalot)
    //       && element.mamlaNo.toLowerCase().contains(publicProvider.bodliKhanaModel.mamlaNo)
    //   )).toList();
    // });
    for(int i=0; i<_subList.length;i++){
      if(_subList[i].amoliAdalot==publicProvider.bodliKhanaModel.amoliAdalot &&
      _subList[i].jojCourt==publicProvider.bodliKhanaModel.jojCourt &&
      _subList[i].mamlaNo==publicProvider.bodliKhanaModel.mamlaNo){
        _filteredSubList.add(_subList[i]);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    if(_counter==0) _customInit(publicProvider);

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
      body: _filteredSubList.isNotEmpty
          ? _bodyUI(size,publicProvider)
          :NoResultFound(),
      bottomNavigationBar: BottomTile(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _bodyUI(Size size,PublicProvider publicProvider)=>ListView.builder(
    itemCount: _filteredSubList.length,
    itemBuilder: (context, index)=>SearchListTile(index: index,dataList: _filteredSubList),
  );
}
