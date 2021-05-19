import 'package:flutter/material.dart';
import 'package:legal_friend/pages/archive_list.dart';
import 'package:legal_friend/pages/payment_page.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/variables/variables.dart';

// ignore: must_be_immutable
class SearchListTile extends StatelessWidget {
   int index;
   SearchListTile({this.index});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      width: size.width*.8,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.width*.02),
          Text('${Variables.cR}২৯২৫/২০১৯',style: TextStyle(
              fontSize: size.width * .04,
              color: Colors.grey[900])),
          SizedBox(height: size.width*.01),

          Text('মোঃ শাহ আলম বানাম আব্দুল আহাদ',style: TextStyle(
              fontSize: size.width * .04,
              color: Colors.grey[900])),
          //SizedBox(height: size.width*.01),

          GradientButton(
            //onPressed: (){},
            onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage())),
            child: Text(Variables.archiveRakhun, style: TextStyle(
                fontSize: size.width * .04, fontFamily: 'niladriFontLite')),
            height: size.width * .1,
            width: size.width*.5,
            borderRadius: size.width * .03,
            gradientColors: [
              Colors.blue[600],
              Colors.blue[500],
            ],
          ),
          SizedBox(height: size.width*.02),
        ],
      ),
    );
  }
}

