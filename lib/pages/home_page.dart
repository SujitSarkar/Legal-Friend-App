import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:legal_friend/pages/archive_list.dart';
import 'package:legal_friend/pages/bodli_khana.dart';
import 'package:legal_friend/pages/kaj_list.dart';
import 'package:legal_friend/pages/login_page.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/tiles/home_tile.dart';
import 'package:legal_friend/tiles/notification_widget.dart';
import 'package:legal_friend/variables/variables.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  int _counter = 0;

  Future<void> _customInit(PublicProvider publicProvider) async {
    setState(() => _counter++);
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
          content: CachedNetworkImage(
            imageUrl: publicProvider.noticeBoardImageLink,
            placeholder: (context, url) => spinCircle(),
            errorWidget: (context, url, error) => Icon(Icons.info_outline),
            //fit: BoxFit.contain,
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
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    if (_counter == 0) _customInit(publicProvider);

    return Scaffold(
      body: _isLoading
          ?Center(child: spinCircle())
          : _bodyUI(size),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomTile(),
    );
  }

  Widget _bodyUI(Size size) => Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            SizedBox(height: size.width * .2),
            GradientButton(
              onPressed: () async {
                SharedPreferences _preferences =
                    await SharedPreferences.getInstance();
                if (_preferences.getString('userPhone') != null) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ArchiveList()));
                } else
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogInPage()));
              },
              child: Text(Variables.archive,
                  style: TextStyle(fontSize: size.width * .06)),
              height: size.width * .12,
              width: size.width * .8,
              borderRadius: size.width * .03,
              gradientColors: [
                Color(0xFF0D47A1),
                Color(0xFF1976D2),
                //Color(0xFF42A5F5),
              ],
            ),
          ],
        ),
      );
}
