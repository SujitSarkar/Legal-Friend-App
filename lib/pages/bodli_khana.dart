import 'package:flutter/material.dart';
import 'package:legal_friend/pages/archive_list.dart';
import 'package:legal_friend/pages/search_page.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/tiles/notification_widget.dart';
import 'package:legal_friend/variables/variables.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

class BodliKhana extends StatefulWidget {

  @override
  _BodliKhanaState createState() => _BodliKhanaState();
}

class _BodliKhanaState extends State<BodliKhana>{

  int _counter=0;
  bool _isLoading=false;

  Future<void> _customInit(PublicProvider publicProvider)async{
    setState(()=>_counter++);
    if(publicProvider.bodliKhanaList.isEmpty){
      setState(()=>_isLoading=true);
      await publicProvider.getBodliKhanaDataList().then((value){
        setState(()=>_isLoading=false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    if(_counter==0) _customInit(publicProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: _bodyUI(size,publicProvider),
      bottomNavigationBar: BottomTile(),
    );
  }

  Widget _bodyUI(Size size,PublicProvider publicProvider)=>Center(
    child: _isLoading
        ? spinCircle()
        : RefreshIndicator(
      backgroundColor: Colors.white,
      onRefresh: ()async{
        await publicProvider.getBodliKhanaDataList();
      },
          child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

          Image.asset('assets/home_image/bodli_khana.png',height: size.width*.4,width: size.width*.8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientButton(
                onPressed: (){
                  publicProvider.pageValue=Variables.niAct;
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()));
                  },
                child: Text(Variables.niAct, style: TextStyle(
                    fontSize: size.width * .06)),
                height: size.width * .12,
                width: size.width*.8,
                borderRadius: size.width * .03,
                gradientColors: [
                  Colors.red[600],
                  Colors.red[500],
                ],
              ),
              SizedBox(height: size.width * .04),

              GradientButton(
                onPressed: () {
                  publicProvider.pageValue=Variables.madokDondobidhi;
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()));
                },
                child: Text(Variables.madokDondobidhi, style: TextStyle(
                    fontSize: size.width * .06)),
                height: size.width * .12,
                width: size.width*.8,
                borderRadius: size.width * .03,
                gradientColors: [
                  Colors.green[700],
                  Colors.green[600],
                ],
              ),
              SizedBox(height: size.width * .04),

              GradientButton(
                onPressed: () {
                  publicProvider.pageValue=Variables.bisesTribunal;
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()));
                },
                child: Text(Variables.bisesTribunal, style: TextStyle(
                    fontSize: size.width * .06)),
                height: size.width * .12,
                width: size.width*.8,
                borderRadius: size.width * .03,
                gradientColors: [
                  Colors.yellow[900],
                  Colors.yellow[800],
                ],
              ),

            ],
          ),
          GradientButton(
            onPressed: () async{
              SharedPreferences _preferences = await SharedPreferences.getInstance();
              if(_preferences.getString('userPhone')!=null){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchiveList()));
              }else  Navigator.push(context, MaterialPageRoute(builder: (context)=>LogInPage()));
            },
            child: Text(Variables.archive, style: TextStyle(
                fontSize: size.width * .06)),
            height: size.width * .12,
            width: size.width*.8,
            borderRadius: size.width * .03,
            gradientColors: [
              Color(0xFF0D47A1),
              Color(0xFF1976D2),
            ],
          ),
          Container(),
      ],
    ),
        ),
  );
}
