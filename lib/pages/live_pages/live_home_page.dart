import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:legal_friend/pages/advocate_page.dart';
import 'package:legal_friend/pages/live_pages/live_page.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/variables/pColor.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveHomePage extends StatelessWidget {
  const LiveHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: PColor.livePageBgColor,
      body: _bodyUI(publicProvider,size,context),
      bottomNavigationBar: BottomTile(),
    );
  }

  Widget _bodyUI(PublicProvider publicProvider,Size size,BuildContext context)=>SafeArea(
    child: SizedBox(
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: size.width*.1),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                          fontSize: size.width*.045
                      ),
                      children: [
                        TextSpan(text: '"',style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.width*.06)),
                        TextSpan(text: 'মহানগর দায়রা জজ আদালত, ঢাকা',
                            style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xffFFFF24),fontSize: size.width*.05)),
                        TextSpan(text: '"\n',style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.width*.06)),
                        TextSpan(text: 'ফৌজদারি বিবিধ মামলা শুনানি চলাকালে\n'),
                        TextSpan(text: 'মামলার সিরিয়াল দেখুন\n'),
                      ],
                    ),
                  ),

                  GradientButton(
                    onPressed: ()=> Navigator.push(context, MaterialPageRoute(
                            builder: (context) => LivePage())),
                    child: Text('LIVE',
                        style: TextStyle(fontSize: size.width * .06,
                            fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
                    height: size.width * .12,
                    width: size.width * .8,
                    borderRadius: size.width * .03,
                    gradientColors: [
                      Color(0xffCB081B),
                      Color(0xff9B0C17)
                    ],
                  ),
                  InkWell(
                    onTap: (){},
                      child: Text('Download App',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: size.width * .045))),
                  SizedBox(height: size.width*.2),
                  GradientButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          AdvocatePage(webUrl: 'https://legalfriendbd.com/',color: Color(0xff335184))));
                    },
                    child: Text('Legalfriend Bangladesh',
                        style: TextStyle(fontSize: size.width * .06,fontStyle: FontStyle.italic)),
                    height: size.width * .12,
                    width: size.width * .8,
                    borderRadius: size.width * .03,
                    gradientColors: [
                      PColor.themeColor,
                      Color(0xff30BE6F),
                    ],
                  ),
                  SizedBox(height: size.width*.04),

                  GradientButton(
                    onPressed: ()async{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          AdvocatePage(webUrl: 'https://www.facebook.com/legalfriendbd/',color: Color(0xff0079F2))));
                    },
                    child: Text('Facebook',
                        style: TextStyle(fontSize: size.width * .06,fontStyle: FontStyle.italic)),
                    height: size.width * .12,
                    width: size.width * .8,
                    borderRadius: size.width * .03,
                    gradientColors: [
                      Color(0xff0079F2),
                      Color(0xff3695F4)
                    ],
                  ),
                  SizedBox(height: size.width*.04),
                  GradientButton(
                    onPressed: () {

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          AdvocatePage(webUrl: 'https://www.youtube.com/channel/UCSpCs90r46ro4ttJos0JYpg',color: Color(0xffFF0000))));
                    },
                    child: Text('Youtube',
                        style: TextStyle(fontSize: size.width * .06,fontStyle: FontStyle.italic)),
                    height: size.width * .12,
                    width: size.width * .8,
                    borderRadius: size.width * .03,
                    gradientColors: [
                      Color(0xffFF0000),
                      Color(0xffFF2C2C)
                    ],
                  ),
                  SizedBox(height: size.width*.04),
                  GradientButton(
                    onPressed: () {Navigator.pop(context);},
                    child: Text('Home',
                        style: TextStyle(fontSize: size.width * .06,fontStyle: FontStyle.italic)),
                    height: size.width * .12,
                    width: size.width * .8,
                    borderRadius: size.width * .03,
                    gradientColors: [
                      Color(0xffBE3804),
                      Color(0xffFF4C00)
                    ],
                  ),
                  SizedBox(height: size.width*.04),
                ],
              ),
            ),
          ),

          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  AdvocatePage(webUrl: 'https://legalfriendbd.com/disclaimer.html',color: Color(0xff00ACA0))));
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: size.width*.04),
              child: Text('Privacy policy | Disclaimer',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: size.width * .045)),
            ),
          ),

        ],
      ),
    ),
  );
}
