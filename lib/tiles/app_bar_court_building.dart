import 'package:flutter/material.dart';
import 'package:legal_friend/variables/pColor.dart';

class CourtBuildingAppBar extends StatelessWidget {
  final String pageName;
  final String courtName;
  const CourtBuildingAppBar({this.pageName,this.courtName});

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
                          padding: EdgeInsets.symmetric(horizontal: size.width * .03,vertical: 1),
                          decoration: BoxDecoration(
                            color: PColor.livePageBgColor,
                            borderRadius: BorderRadius.all(Radius.circular(size.width*.01)),
                          ),
                          child: Text('$pageName',
                              style: TextStyle(
                                  fontSize: size.width * .04,
                                  fontFamily: 'niladriFontLite',color: Colors.white)
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: size.width*.04,
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
                          )
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 2.0,
                    left: 0.0,
                    child: Container(
                      height: size.width*.24,
                      width: size.width*.35,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/home_image/court_building.png'),
                              fit: BoxFit.fitHeight
                          )
                      ),
                    ),
                  ),

                  courtName!=null?Positioned(
                    top: 0.0,
                    right: size.width*.03,
                    child: SizedBox(
                      width: size.width*.64,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('আদালতের ধরন',
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'niladriFontLite',
                                fontSize: size.width*.04),),
                          Text(courtName,
                            maxLines: 1,
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'niladriFontLite',
                                fontSize: size.width*.055)),
                        ],
                      ),
                    ),
                  ):Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


