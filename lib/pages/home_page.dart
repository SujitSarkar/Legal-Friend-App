import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:legal_friend/pages/bodli_khana.dart';
import 'package:legal_friend/pages/court_building/home_page.dart';
import 'package:legal_friend/pages/lawyer_page.dart';
import 'package:legal_friend/pages/kaj_list.dart';
import 'package:legal_friend/pages/live_pages/live_home_page.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/home_tile.dart';
import 'package:legal_friend/tiles/notification_widget.dart';
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
          ?Center(child: spinCircle())
          : _bodyUI(size),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomTile(),

    );
  }

  Widget _bodyUI(Size size) => Stack(
    children: [
      Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.width * .15),
                  HomeMainButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BodliKhana())),
                    image: 'assets/home_image/bodli_khana.png',
                  ),
                  SizedBox(height: size.width * .04),

                  HomeMainButton(
                    onPressed: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => KajList())),
                    image: 'assets/home_image/kaj_list.png',
                  ),
                  SizedBox(height: size.width * .04),

                  HomeMainButton(
                    onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>CourtBuildingHomePage())),
                    image: 'assets/home_image/court_building.png',
                  ),
                  SizedBox(height: size.width * .04),

                  HomeMainButton(
                    onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>LawyerPage())),
                    image: 'assets/home_image/lawyear.png',
                  ),
                  SizedBox(height: size.width * .04),
                ],
              ),
            ),
          ),

      ///LIVE
      Positioned(
        right: -26.0,
        bottom: 50.0,
        child: RotationTransition(
          turns: AlwaysStoppedAnimation(-90 / 360),
          child: Material(
            color: Colors.red,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: InkWell(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>LiveHomePage())),
              child: Container(
                alignment: Alignment.center,
                height: 28,
                width: 80,
                child: Text('LIVE',style: TextStyle(
                  color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,fontSize: 18.0
                )),
              ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                )
            ),
          ),
        ),
      )
    ],
  );
}
