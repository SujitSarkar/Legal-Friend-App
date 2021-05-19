import 'package:flutter/material.dart';
import 'package:legal_friend/variables/variables.dart';

// ignore: must_be_immutable
class ArchiveTile extends StatelessWidget {
  int index;
  ArchiveTile({this.index});

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
              fontSize: size.width * .042,
              fontWeight: FontWeight.bold,
               color: index==0?Theme.of(context).primaryColor: Colors.grey[900])),
          SizedBox(height: size.width*.01),

          Text('মোঃ শাহ আলম বানাম আব্দুল আহাদ',style: TextStyle(
              fontSize: size.width * .042,
              fontWeight: FontWeight.bold,
              color: index==0?Theme.of(context).primaryColor: Colors.grey[900])),

          SizedBox(height: size.width*.02),
        ],
      ),
    );
  }
}

