import 'package:flutter/material.dart';
import 'package:legal_friend/pages/live_pages/live_page.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/variables/pColor.dart';
import 'package:provider/provider.dart';

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
                      TextSpan(text: 'মহানগর দায়রা জজ আদালত',
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
                Text('Download App',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: size.width * .045)),
                SizedBox(height: size.width*.1),
                GradientButton(
                  onPressed: () {},
                  child: Text('Legalalfriend bangladesh',
                      style: TextStyle(fontSize: size.width * .06,fontStyle: FontStyle.italic)),
                  height: size.width * .12,
                  width: size.width * .8,
                  borderRadius: size.width * .03,
                  gradientColors: [
                    Color(0xffFF9926),
                    Color(0xffA35C20)
                  ],
                ),
                SizedBox(height: size.width*.04),

                GradientButton(
                  onPressed: () {},
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
                  onPressed: () {},
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

          Padding(
            padding: EdgeInsets.only(bottom: size.width*.04),
            child: Text('Privacy policy | Disclaimer',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: size.width * .045)),
          ),

        ],
      ),
    ),
  );
}
