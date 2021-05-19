import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PublicAppBar extends StatelessWidget {
  String pageName;
  String bottomText;
  String image;
  Color color;
   PublicAppBar({this.image,this.pageName,this.bottomText,this.color});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        width: size.width,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width,
              height: 100,
              //color: Colors.green,
              child: Stack(
                children: [
                  Positioned(
                    bottom:0.0,
                    right: 0.0,
                    child: Column(
                      children: [
                        Container(
                          width: size.width,
                          alignment: Alignment.bottomRight,
                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 1),
                          decoration: BoxDecoration(
                              color: color,
                            borderRadius: bottomText.isNotEmpty? BorderRadius.only(
                              bottomRight: Radius.circular(size.width*.01),
                              bottomLeft: Radius.circular(size.width*.01),
                            ):BorderRadius.all(Radius.circular(size.width*.01)),

                          ),
                          child: Text('$pageName',
                              style: TextStyle(
                                  fontSize: size.width * .04,
                                  fontFamily: 'niladriFontLite',color: Colors.white)
                          ),
                        ),
                        bottomText.isNotEmpty?Container(
                          width: size.width,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 1),
                          decoration: BoxDecoration(
                              color: Color(0xffB3E9FA),
                              borderRadius:BorderRadius.only(
                                bottomRight: Radius.circular(size.width*.01),
                                bottomLeft: Radius.circular(size.width*.01),
                              ),
                              boxShadow: [
                                BoxShadow(color: Colors.grey[300],offset: Offset(0,5),blurRadius: 5)
                              ]
                          ),
                          child: Text('$bottomText',
                              style: TextStyle(
                                  fontSize: size.width * .038,
                                  color: Colors.grey[900])
                          ),
                        ):Container(height: size.width * .05,),
                      ],
                    ),
                  ),
                  Container(
                    height: 80,
                    width: size.width*.4,
                    decoration: BoxDecoration(
                      //color: Colors.green,
                        image: DecorationImage(
                            image: AssetImage(image),
                            fit: BoxFit.fitHeight
                        )
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


