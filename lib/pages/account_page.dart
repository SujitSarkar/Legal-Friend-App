import 'package:flutter/material.dart';
import 'package:legal_friend/pages/profile_page.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/variables/pColor.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    return Scaffold(
      backgroundColor: PColor.greyBgColor,
      bottomNavigationBar: BottomTile(),
      body: _bodyUI(size),
    );
  }

  Widget _bodyUI(Size size)=>SafeArea(
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
