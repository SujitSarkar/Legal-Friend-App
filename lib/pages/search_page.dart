import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:legal_friend/pages/search_list.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/app_bar.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/form_decoration.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/tiles/notification_widget.dart';
import 'package:legal_friend/variables/variables.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _internetConnected=true;
  String _amoliAdalot;
  String _jojkrot;
  String _mamlaNoDrop;
  TextEditingController _mamlaNo2 = TextEditingController(text: '');
  TextEditingController _mamlaNo = TextEditingController(text: '');

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
          bottomText:
              '${Variables.sorboseshUpdateBoi}${publicProvider.toggleLastUpdatedBoiNo()} ${Variables.porjonto}',
          image: 'assets/home_image/bodli_khana.png',
          color: publicProvider.toggleHeaderColor(),
        ),
      ),
      body: _bodyUI(size, publicProvider),
      bottomNavigationBar: BottomTile(),
    );
  }

  Widget _bodyUI(Size size, PublicProvider publicProvider) =>
      SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.width * .2),
              Container(
                width: size.width * .8,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: size.width * .02,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[800], width: 1.5),
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * .02)),
                ),
                child: Text(
                    '${Variables.boiNo}০১/২০২১ ${Variables.thekeSuruHoyeche}',
                    style: TextStyle(
                        fontSize: size.width * .04, color: Colors.grey[900])),
              ),
              SizedBox(height: size.width * .08),
              _dropDownBuilder(size, Variables.jojCourt, publicProvider),
              SizedBox(height: size.width * .04),
              _dropDownBuilder(size, Variables.amoliAdalot, publicProvider),
              SizedBox(height: size.width * .04),

              Container(
                  width: size.width * .8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size.width * .18,
                        alignment: Alignment.centerRight,
                        child: Text(publicProvider.crToggle(),
                            style: TextStyle(
                                fontSize: size.width * .04,
                                color: Colors.grey[900])),
                      ),


                      ///Mamla No
                      publicProvider.pageValue==Variables.niAct
                          ?Container(
                        width: size.width * .22,
                        child: TextField(
                          controller: _mamlaNo,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: size.width * .035),
                          decoration: boxFormDecoration(size).copyWith(
                            hintText: publicProvider.crMamlaHintFirst(),
                          ),
                        ),
                      )
                      :Container(
                        width: size.width * .38,
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[800], width: 1.5),
                            borderRadius:
                            BorderRadius.all(Radius.circular(size.width * .02))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isDense: true,
                            isExpanded: true,
                            value:_mamlaNoDrop,
                            //itemHeight: 300.0,
                            menuMaxHeight: 500,
                            hint: Text('থানার নাম',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: size.width * .04,
                                )),
                            items:Variables.thanaList.map((category) {
                              return DropdownMenuItem(
                                child: Text(category,
                                    style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: size.width * .033)),
                                value: category,
                              );
                            }).toList(),
                            onChanged: (newValue) => setState(() =>
                            _mamlaNoDrop = newValue),
                            dropdownColor: Colors.white,
                          ),
                        ),
                      ),

                      Text(
                        publicProvider.toggleSign(),
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: size.width * .05,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: size.width * .22,
                        child: TextField(
                          controller: _mamlaNo2,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: size.width * .035),
                          decoration: boxFormDecoration(size).copyWith(
                            hintText: publicProvider.crMamlaHintSecond(),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: size.width * .2),
              GradientButton(
                onPressed: () async{
                  if(publicProvider.pageValue== Variables.niAct){
                    if (_amoliAdalot != null &&
                        _jojkrot != null &&
                        _mamlaNo.text.isNotEmpty &&
                        _mamlaNo2.text.isNotEmpty) {
                      await _checkConnectivity();
                      if(_internetConnected){
                        publicProvider.bodliKhanaModel.amoliAdalot = _amoliAdalot;
                        publicProvider.bodliKhanaModel.jojCourt = _jojkrot;
                        publicProvider.bodliKhanaModel.mamlaNo =
                        '${_mamlaNo.text}${publicProvider.toggleSign()}${_mamlaNo2.text}';
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SearchtList()));
                      }else showInfo('কোন ইন্টারনেট সংযোগ নেই, '
                      'মোবাইল ডাটা/ওয়াইফাই চালু করুন \u{1F629}');
                      
                    } else
                      showToast('সকল ডেটা ফিল্ড পুরন করুন');
                  }else{
                    if (_amoliAdalot != null &&
                        _jojkrot != null &&
                        _mamlaNoDrop!=null &&
                        _mamlaNo2.text.isNotEmpty) {
                     await _checkConnectivity();
                      if(_internetConnected){
                        publicProvider.bodliKhanaModel.amoliAdalot = _amoliAdalot;
                        publicProvider.bodliKhanaModel.jojCourt = _jojkrot;
                        publicProvider.bodliKhanaModel.mamlaNo =
                        '$_mamlaNoDrop${publicProvider.toggleSign()}${_mamlaNo2.text}';
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchtList()));
                      }else showInfo('কোন ইন্টারনেট সংযোগ নেই, '
                          'মোবাইল ডাটা/ওয়াইফাই চালু করুন \u{1F629}');
                      
                    } else
                      showToast('সকল ডেটা ফিল্ড পুরন করুন');
                  }
                },
                child: Text(Variables.onusondhanKorun,
                    style: TextStyle(
                        fontSize: size.width * .04,
                        fontFamily: 'niladriFontLite')),
                height: size.width * .1,
                width: size.width * .5,
                borderRadius: size.width * .03,
                gradientColors: [
                  Colors.yellow[900],
                  Colors.yellow[800],
                ],
              ),
            ],
          ),
        ),
      );

  Widget _dropDownBuilder(
          Size size, String name, PublicProvider publicProvider) =>
      Container(
        width: size.width * .8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: size.width * .4,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: size.width * .02,
              ),
              child: Text(
                name,
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: size.width * .04, color: Colors.grey[900]),
              ),
            ),
            Container(
              width: size.width * .4,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[800], width: 1.5),
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * .02))),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isDense: true,
                  isExpanded: true,
                  value:
                      name == Variables.amoliAdalot ? _amoliAdalot : _jojkrot,
                  hint: Text(Variables.dropHint,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: size.width * .04,
                      )),
                  items: name == Variables.amoliAdalot
                      ? Variables.amoliAdalotList.map((category) {
                          return DropdownMenuItem(
                            child: Text(category,
                                style: TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: size.width * .04)),
                            value: category,
                          );
                        }).toList()
                      : Variables.jojCourtList.map((category) {
                          return DropdownMenuItem(
                            child: Text(category,
                                style: TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: size.width * .04)),
                            value: category,
                          );
                        }).toList(),
                  onChanged: (newValue) => setState(() => name == 'আমলী আদালত'
                      ? _amoliAdalot = newValue
                      : _jojkrot = newValue),
                  dropdownColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );

  Future<void> _checkConnectivity() async {
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.none) {
      setState(()=> _internetConnected = false);
    } else if (result == ConnectivityResult.mobile) {
      setState(()=> _internetConnected = true);
    } else if (result == ConnectivityResult.wifi) {
      setState(()=> _internetConnected = true);
    }
  }
}
