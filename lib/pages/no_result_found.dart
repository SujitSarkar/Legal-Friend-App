import 'package:flutter/material.dart';
import 'package:legal_friend/pages/archive_list.dart';
import 'package:legal_friend/pages/bodli_khana.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/variables/variables.dart';

class NoResultFound extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Image.asset('assets/home_image/bodli_khana.png',height: size.width*.4,width: size.width*.8),
            Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    //text: 'Hello ',
                    style: TextStyle(
                        color: Colors.red[800],
                        fontSize: size.width*.12
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
                      textAlign: TextAlign.center),
                )
              ],
            ),
            Column(
              children: [
                GradientButton(
                  onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>BodliKhana())),
                  child: Text(Variables.abarOnusondhanKorun, style: TextStyle(
                      fontSize: size.width * .055)),
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
                      fontSize: size.width * .055)),
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
}



