import 'package:flutter/material.dart';
import 'package:legal_friend/pages/create_profile_page.dart';
import 'package:legal_friend/pages/home_page.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/tiles/notification_widget.dart';
import 'package:legal_friend/tiles/text_field_tile.dart';
import 'package:legal_friend/variables/pColor.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {
  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController _phone = TextEditingController(text: '');

  TextEditingController _password = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);

    return Scaffold(
      backgroundColor: PColor.greyBgColor,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomTile(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*.1),
                  child: Image.asset('assets/login_poster.png'),
                ),
                SizedBox(height: size.width*.2),

                Container(
                  padding: EdgeInsets.all(size.width*.04),
                  margin: EdgeInsets.symmetric(horizontal: size.width*.07),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(size.width*.04))
                  ),
                  child: Column(
                    children: [
                      TextFieldBuilder(controller: _phone, labelText: 'Phone Number',
                          textInputType: TextInputType.number),
                      SizedBox(height:size.width*.04),

                      TextFieldBuilder(controller: _password, labelText: 'Password',obscure: true),
                      SizedBox(height:size.width*.04),

                      GradientButton(
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                          // if (_phone.text.isNotEmpty) {
                          //   if(_phone.text.length>=11){
                          //
                          //   }else showToast('মোবাইল নাম্বার ১১ ডিজিট হতে হবে');
                          // }else showToast('ফর্ম পুরন করুন');
                        },
                        child: Text('Login',
                            style: TextStyle(
                                fontSize: size.width * .06,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.white)),
                        height: size.width * .12,
                        width: size.width * .9,
                        gradientColors: [
                          PColor.loginBtnColor,
                          PColor.loginBtnColor
                        ],
                      ),
                      SizedBox(height:size.width*.02),

                      Text('Forgotten Password?',style: TextStyle(
                          fontSize: size.width * .04,
                          fontWeight: FontWeight.bold,
                          color: PColor.loginBtnColor)),
                      SizedBox(height:size.width*.1),

                      GradientButton(
                        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateProfilePage())),
                        child: Text('Create New Profile',
                            style: TextStyle(
                                fontSize: size.width * .06,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: PColor.yellowColor)),
                        height: size.width * .12,
                        width: size.width * .9,
                        gradientColors: [
                          PColor.themeColor,
                          PColor.themeColor
                        ],
                      ),
                      SizedBox(height:size.width*.1),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
