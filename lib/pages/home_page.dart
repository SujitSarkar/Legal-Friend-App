import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:legal_friend/pages/account_page.dart';
import 'package:legal_friend/pages/bodlikhana/bodli_khana.dart';
import 'package:legal_friend/pages/court_building/home_page.dart';
import 'package:legal_friend/pages/advocate_page.dart';
import 'package:legal_friend/pages/kaj_list.dart';
import 'package:legal_friend/pages/live_pages/live_home_page.dart';
import 'package:legal_friend/pages/profile_page.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/home_tile.dart';
import 'package:legal_friend/tiles/notification_widget.dart';
import 'package:legal_friend/variables/pColor.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  @override
  initState(){
    super.initState();
    _customInit();
  }

  Future<void> _customInit() async {
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context,listen: false);
    if (publicProvider.noticeBoardImageLink.isEmpty) {
      setState(() => _isLoading = true);
      await publicProvider.getNoticeBoardImageLink().then((value) {
        setState(() => _isLoading = false);
      });
    }
    if(publicProvider.noticeBoardImageLink.isNotEmpty){
      Future.delayed(Duration(milliseconds: 200)).then((value){
        _showNotice(publicProvider);
      });
    }
    await publicProvider.getLastUpdateBook();
  }

  void _showNotice(PublicProvider publicProvider){
    showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(5.0),
          scrollable: true,
          backgroundColor: Colors.white,
          content: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: ()=>Navigator.pop(context),
                  child: Icon(Icons.cancel),
                ),
              ),
              CachedNetworkImage(
                imageUrl: publicProvider.noticeBoardImageLink,
                placeholder: (context, url) => spinCircle(),
                errorWidget: (context, url, error) => Icon(Icons.info_outline),
                //fit: BoxFit.contain,
              ),
            ],
          ),
        );
      },
      animationType: DialogTransitionType.slideFromTopFade,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _isLoading
          ? Center(child: spinCircle())
          : _bodyUI(size),
      backgroundColor: _isLoading
          ? Colors.white
          : PColor.deepBlueColor,
    );
  }

  Widget _bodyUI(Size size) => SafeArea(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ///Top Section
        Column(
          children: [
            SizedBox(height:size.width*.05),
            ///Advocacy image
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*.15),
              child: Image.asset('assets/easy_advocacy_home.png')),
            SizedBox(height:size.width*.15),

            ///Account
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountPage()));
              },
              child: Container(
                height: size.width*.35,
                width: size.width*.35,
                decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    borderRadius: BorderRadius.all(Radius.circular(size.width*.2)),
                    border: Border.all(color: Colors.white,width: size.width*.015)
                ),
                child: Image.asset('assets/boy.png')
              ),
            ),
            SizedBox(height: size.width*.02),

            ///Name
            Text('Kamrul Hasan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width*.06,
                  fontWeight: FontWeight.w500,
                )),
            SizedBox(height: size.width*.02),
          ],
        ),

        ///Middle Section
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              top: size.width*.06,
              left: size.width*.06,
              right: size.width*.06,
              bottom: size.width*.02
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.width*.08),
                    topRight: Radius.circular(size.width*.08)
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: HomeMainButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>BodliKhana()));
                            },bgColor: PColor.bodliKhanaBgColor,
                            image: 'assets/home_image/bodli_khana.png',
                          ),
                        ),
                        SizedBox(width: size.width*.02),
                        HomeMainButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AdvocatePage(webUrl: 'https://www.dhakabarassociation.com/member_of_dba.php',color: PColor.advocateBgColor)));
                          },bgColor: PColor.advocateBgColor,
                          image: 'assets/home_image/advocate.png')
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.width*.02),

                Expanded(
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeMainButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CourtBuildingHomePage()));
                            },
                            bgColor: Color(0xff06476A),
                            image: 'assets/home_image/court_building.png'),
                        SizedBox(width: size.width*.02),
                        Expanded(
                          child: HomeMainButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>KajList()));
                            },
                            bgColor: PColor.kajListBgColor,
                            image: 'assets/home_image/kaj_list.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        ///Bottom Navigation Bar
        Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              color: Colors.white,
              height: size.width*.2,
            ),
            Container(
              height: size.width*.13,
              decoration: BoxDecoration(
                color: PColor.deepGreen,
                border: Border(
                  top: BorderSide(color: PColor.yellowColor,width: size.width*.012)
                )
              ),
            ),
            Positioned(
              top: -size.width*.009,
              child: GestureDetector(
                onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>LiveHomePage()));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: size.width*.15,
                  width: size.width*.15,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white,width: 2),
                    shape: BoxShape.circle,
                    color: Colors.white
                  ),
                  child: Image.asset('assets/logo/logo_wbg.png',fit: BoxFit.cover),
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}
