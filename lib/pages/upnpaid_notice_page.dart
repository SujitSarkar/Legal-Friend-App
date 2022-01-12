import 'package:flutter/material.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/variables/pColor.dart';
import 'package:provider/provider.dart';

class UnpaidNoticePage extends StatefulWidget {
  const UnpaidNoticePage({Key key}) : super(key: key);
  @override
  _UnpaidNoticePageState createState() => _UnpaidNoticePageState();
}

class _UnpaidNoticePageState extends State<UnpaidNoticePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    return Scaffold(
      backgroundColor: PColor.greyBgColor,
      bottomNavigationBar: BottomTile(),
      body: _bodyUI(size),
    );
  }

  Widget _bodyUI(Size size)=>SafeArea(
    child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width*.08,vertical: size.width*.04),
        child: Column(
          children: [
            SizedBox(height: size.width*.1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*.1),
              child: Image.asset('assets/unpaid_notice.png',height: size.width*.5,width: size.width*.5),
            ),

            ///package list
            Center(
              child: Text('Our Service fee: Regular(one month)-250 TK, Silver (six month)-1200 TK,'
                  ' and Premium (one year)-2000 TK only. Thank you for being with us.',
                textAlign: TextAlign.center,
                style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: size.width*.045,
                fontWeight: FontWeight.w400,
              )),
            ),
            SizedBox(height: size.width*.1),

            GradientButton(
              onPressed: () async {},
              child: Text('Regular',
                  style: TextStyle(
                      fontSize: size.width * .065,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.white)),
              height: size.width * .12,
              width: size.width * .7,
              gradientColors: [
                PColor.regularColor,
                PColor.regularColor
              ],
            ),
            SizedBox(height: size.width*.02),

            GradientButton(
              onPressed: () async {},
              child: Text('Silver',
                  style: TextStyle(
                      fontSize: size.width * .065,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.white)),
              height: size.width * .12,
              width: size.width * .7,
              gradientColors: [
                PColor.silverColor,
                PColor.silverColor
              ],
            ),
            SizedBox(height: size.width*.02),

            GradientButton(
              onPressed: () async {},
              child: Text('Premium',
                  style: TextStyle(
                      fontSize: size.width * .065,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.white)),
              height: size.width * .12,
              width: size.width * .7,
              gradientColors: [
                PColor.premiumColor,
                PColor.premiumColor
              ],
            ),
            SizedBox(height: size.width*.04)
          ],
        ),
      ),
    ),
  );
}
