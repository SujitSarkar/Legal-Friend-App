import 'package:flutter/material.dart';
import 'package:legal_friend/pages/login_page.dart';
import 'package:legal_friend/pages/profile_page.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/variables/pColor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/api_provider.dart';
import '../tiles/notification_widget.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ApiProvider apiProvider = Provider.of<ApiProvider>(context);
    return Scaffold(
      //backgroundColor: PColor.greyBgColor,
      backgroundColor: PColor.blueColor,
      bottomNavigationBar: Material(color:Colors.white,child: BottomTile()),
      body: _bodyUI(size,apiProvider),
    );
  }

  Widget _bodyUI(Size size, ApiProvider apiProvider) => SafeArea(
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
                child: Image.asset('assets/easy_advocacy.png')),
            SizedBox(height:size.width*.15),

            ///Account
            Container(
              height: size.width*.35,
              width: size.width*.35,
              decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.all(Radius.circular(size.width*.2)),
                  border: Border.all(color: Colors.white,width: size.width*.015)
              ),
              child: Image.asset(apiProvider.loginModel.user.gender=='Male'? 'assets/boy.png':'assets/girl.png')
              // Icon(Icons.person,size: size.width*.28,
              //     color: Theme.of(context).primaryColor),
            ),
            SizedBox(height: size.width*.02),

            ///Name, Designation, Address
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: size.width*.05,
                    fontWeight: FontWeight.w500,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: '${apiProvider.loginModel.user.name}\n',style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width*.09,fontWeight: FontWeight.w900)),
                    TextSpan(text: '${apiProvider.loginModel.user.profession}\n'),
                    TextSpan(text: '${apiProvider.loginModel.user.address}\n')
                  ],
                ),
              ),
            ),
            SizedBox(height: size.width*.02),
          ],
        ),

        ///Middle Section
        Expanded(
          child: Container(
            width: size.width,
            padding: EdgeInsets.only(
                top: size.width*.06,
                left: size.width*.06,
                right: size.width*.06,
                bottom: size.width*.02
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.width*.05),
                    topRight: Radius.circular(size.width*.05)
                )
            ),
            child: Column(
              children: [
                SizedBox(height: size.width*.04),
                GradientButton(
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                  child: Text('Profile',
                      style: TextStyle(
                          fontSize: size.width * .065,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.white)),
                  height: size.width * .12,
                  width: size.width * .7,
                  borderRadius: size.width * .03,
                  gradientColors: [
                    PColor.profileColor,
                    PColor.profileColor
                  ],
                ),
                SizedBox(height: size.width*.02),

                GradientButton(
                  onPressed: () async {},
                  child: Text('Password',
                      style: TextStyle(
                          fontSize: size.width * .065,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.white)),
                  height: size.width * .12,
                  width: size.width * .7,
                  borderRadius: size.width * .03,
                  gradientColors: [
                    PColor.passwordColor,
                    PColor.passwordColor
                  ],
                ),
                SizedBox(height: size.width*.02),

                GradientButton(
                  onPressed: () async {
                    showLoadingDialog('Logging out...');
                    final SharedPreferences pref = await SharedPreferences.getInstance();
                    await pref.clear();
                    closeLoadingDialog();
                    showToast('Logged out');
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LogInPage()), (route) => false);
                  },
                  child: Text('Logout',
                      style: TextStyle(
                          fontSize: size.width * .065,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.white)),
                  height: size.width * .12,
                  width: size.width * .7,
                  borderRadius: size.width * .03,
                  gradientColors: [
                    PColor.logoutColor,
                    PColor.logoutColor
                  ],
                ),

              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget _bodyUI2(Size size)=>SafeArea(
    child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width*.04,vertical: size.width*.04),
        child: Column(
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*.1),
              child: Image.asset('assets/login_poster.png'),
            ),
            SizedBox(height: size.width*.1),

            ///Top Container
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ///Image
                  Container(
                    height: size.width*.3,
                    width: size.width*.3,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.all(Radius.circular(size.width*.2))
                    ),
                    child: Icon(Icons.person,size: size.width*.28,
                        color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(height: size.width*.02),

                  ///Name, Designation, Address
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: size.width*.06,
                          fontWeight: FontWeight.w500,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'Kamrul Hasan\n',style: TextStyle(
                            color: Colors.teal,
                            fontSize: size.width*.09,fontWeight: FontWeight.w900)),
                          TextSpan(text: 'Advocate\n'),
                          TextSpan(text: 'Dhaka\n')
                        ],
                      ),
                    ),
                  ),

                  GradientButton(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ProfilePage()));
                    },
                    child: Text('Profile',
                        style: TextStyle(
                            fontSize: size.width * .065,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.white)),
                    height: size.width * .12,
                    width: size.width * .7,
                    borderRadius: size.width * .03,
                    gradientColors: [
                      PColor.profileColor,
                      PColor.profileColor
                    ],
                  ),
                  SizedBox(height: size.width*.02),

                  GradientButton(
                    onPressed: () async {},
                    child: Text('Password',
                        style: TextStyle(
                            fontSize: size.width * .065,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.white)),
                    height: size.width * .12,
                    width: size.width * .7,
                    borderRadius: size.width * .03,
                    gradientColors: [
                      PColor.passwordColor,
                      PColor.passwordColor
                    ],
                  ),
                  SizedBox(height: size.width*.02),

                  GradientButton(
                    onPressed: () async {},
                    child: Text('Logout',
                        style: TextStyle(
                            fontSize: size.width * .065,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.white)),
                    height: size.width * .12,
                    width: size.width * .7,
                    borderRadius: size.width * .03,
                    gradientColors: [
                      PColor.logoutColor,
                      PColor.logoutColor
                    ],
                  ),
                  SizedBox(height: size.width*.04),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
