import 'package:flutter/material.dart';
import 'package:legal_friend/forgot_password_page.dart';
import 'package:legal_friend/pages/create_profile_page.dart';
import 'package:legal_friend/pages/home_page.dart';
import 'package:legal_friend/providers/api_provider.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/tiles/notification_widget.dart';
import 'package:legal_friend/tiles/text_field_tile.dart';
import 'package:legal_friend/variables/pColor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInPage extends StatefulWidget {
  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController _phone = TextEditingController(text: '');
  TextEditingController _password = TextEditingController(text: '');

  @override
  void initState(){
    super.initState();
    autoLogin();
  }

  Future <void> autoLogin()async{
    final ApiProvider apiProvider = Provider.of<ApiProvider>(context,listen: false);
    final SharedPreferences pref = await SharedPreferences.getInstance();

    if(pref.getString('phone')!=null && pref.getString('password')!=null){
      showLoadingDialog('Logging in...');
      bool result = await apiProvider.login(pref.getString('phone'),pref.getString('password'));
      if(result){
        closeLoadingDialog();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
      }else{
        closeLoadingDialog();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ApiProvider apiProvider = Provider.of<ApiProvider>(context);

    return Scaffold(
      backgroundColor: PColor.greyBgColor,
      body: SafeArea(
        child: Stack(
          fit: StackFit.loose,
          children: [
            Positioned(
             top: size.width*.1,
              left: 0.0,
              right: 0.0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*.1),
                child: Image.asset('assets/login_poster.png'),
              ),
            ),
            //SizedBox(height: size.width*.2),

            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.all(size.width*.12),
                decoration: BoxDecoration(
                  color: PColor.deepBlueColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.width*.08),
                    topRight: Radius.circular(size.width*.08)
                  )
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFieldBuilder(controller: _phone, hintText: 'Phone Number',
                          textInputType: TextInputType.number,fillColor: Colors.white),
                      SizedBox(height:size.width*.04),

                      TextFieldBuilder(controller: _password, hintText: 'Password',obscure: true,
                          fillColor: Colors.white),
                      SizedBox(height:size.width*.04),

                      GradientButton(
                        onPressed: () async {
                          if(_phone.text.isNotEmpty && _password.text.isNotEmpty){
                            bool result = await apiProvider.login(_phone.text, _password.text);
                            if(result){
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
                            }
                          }else{showToast('Provide phone & password');}
                        },
                        child: Text('Login',
                            style: TextStyle(
                                fontSize: size.width * .06,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.white)),
                        height: size.width * .12,
                        width: size.width * .9,
                        borderRadius: size.width * .03,
                        gradientColors: [
                          PColor.loginBtnColor,
                          PColor.loginBtnColor
                        ],
                      ),
                      SizedBox(height:size.width*.02),

                      InkWell(
                        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordPage())),
                        child: Text('Forgotten Password?',style: TextStyle(
                            fontSize: size.width * .04,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                      ),
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
                        borderRadius: size.width * .03,
                        gradientColors: [
                          PColor.themeColor,
                          PColor.themeColor
                        ],
                      ),
                      SizedBox(height:size.width*.3),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
