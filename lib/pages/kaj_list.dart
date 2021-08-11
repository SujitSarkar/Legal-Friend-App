import 'package:flutter/material.dart';
import 'package:legal_friend/pages/login_page.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/variables/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                      Colors.teal.shade700,
                      Colors.teal.shade500
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


}
