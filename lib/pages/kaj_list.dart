import 'package:flutter/material.dart';
import 'package:legal_friend/pages/login_page.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/tiles/notification_widget.dart';
import 'package:legal_friend/variables/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'archive_list.dart';

class KajList extends StatefulWidget {
  @override
  _KajListState createState() => _KajListState();
}

class _KajListState extends State<KajList> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: _bodyUI(size),
      bottomNavigationBar: BottomTile(),
    );
  }

  Widget _bodyUI(Size size) => Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/home_image/kaj_list.png',
                  height: size.width * .4, width: size.width * .8),
              Column(
                children: [
                  Container(
                    width: size.width * .9,
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * .01,
                        vertical: size.width * .02),
                    decoration: BoxDecoration(
                        color: Color(0xffB3E9FA),
                        borderRadius: BorderRadius.all(
                            Radius.circular(size.width * .02))),
                    child: Text(
                      Variables.kajListMgs,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey[900], fontSize: size.width * .05),
                    ),
                  ),
                  SizedBox(height: size.width * .01),
                  InkWell(
                      onTap: () => _launchSocialApp(
                          'mailto:legalfriendbd@gmail.com'
                          '?subject=Mail%20To%20LegalFriend&body=Type%20your%20message%20here'),
                      child: Text('send us',
                          style: TextStyle(
                              fontSize: size.width * .04,
                              color: Colors.blue,
                              decoration: TextDecoration.underline))),
                  Text(
                    'If you think something is wrong',
                    style: TextStyle(
                        color: Colors.grey[900], fontSize: size.width * .04),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GradientButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(Variables.agerMenu,
                        style: TextStyle(fontSize: size.width * .06)),
                    height: size.width * .12,
                    width: size.width * .8,
                    borderRadius: size.width * .03,
                    gradientColors: [
                      Colors.green[700],
                      Colors.green[600],
                    ],
                  ),
                  SizedBox(height: size.width * .04),
                  GradientButton(
                    onPressed: () async {
                      SharedPreferences _preferences =
                          await SharedPreferences.getInstance();
                      if (_preferences.getString('userPhone') != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ArchiveList()));
                      } else
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogInPage()));
                    },
                    child: Text(Variables.archive,
                        style: TextStyle(fontSize: size.width * .06)),
                    height: size.width * .12,
                    width: size.width * .8,
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

  Future<void> _launchSocialApp(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showInfo('ব্যর্থ হয়েছে !\nআবার চেষ্টা করুন');
    }
  }
}
