import 'package:flutter/material.dart';
import 'package:legal_friend/pages/archive_list.dart';
import 'package:legal_friend/pages/search_page.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/variables/variables.dart';
import 'package:provider/provider.dart';

class NoResultFound extends StatefulWidget {

  @override
  _NoResultFoundState createState() => _NoResultFoundState();
}

class _NoResultFoundState extends State<NoResultFound> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    return Scaffold(
      body: _bodyUI(size,publicProvider),
      floatingActionButton: BottomTile(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _bodyUI(Size size,PublicProvider publicProvider)=>Container(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/home_image/bodli_khana.png',height: size.width*.4,width: size.width*.8),
          Column(
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  //text: 'Hello ',
                  style: TextStyle(
                      color: Colors.red[800],
                      fontSize: size.width*.12,
                      fontFamily: 'niladriFontLite'
                  ),
                  children: <TextSpan>[
                    TextSpan(text: '${Variables.dukkhito}\n'),
                    TextSpan(text: '${Variables.konoFolafolNei}\n',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: size.width*.08,
                          color: Theme.of(context).primaryColor,
                        )),

                  ],
                ),
              ),
              Container(
                width: size.width*.9,
                padding: EdgeInsets.all(size.width*.04),
                decoration: BoxDecoration(
                  color: Color(0xffB3E9FA),
                  borderRadius: BorderRadius.all(Radius.circular(size.width*.02))
                ),
                child: Text(
                  Variables.dukkhitoMgs,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'barkatFontBold'),),
              )
            ],
          ),


          Column(
            children: [
              GradientButton(
                onPressed: () =>Navigator.pop(context),
                child: Text(Variables.abarOnusondhanKorun, style: TextStyle(
                    fontSize: size.width * .055, fontFamily: 'niladriFontLite')),
                height: size.width * .12,
                width: size.width*.8,
                borderRadius: size.width * .03,
                gradientColors: [
                  Colors.blue[600],
                  Colors.blue[400],
                ],
              ),
              SizedBox(height: size.width*.04),
              GradientButton(
                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchiveList())),
                child: Text(Variables.archive, style: TextStyle(
                    fontSize: size.width * .055, fontFamily: 'niladriFontLite')),
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
          Container(),
        ],
      ),
    ),
  );
}


