import 'package:flutter/material.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/tiles/text_field_tile.dart';
import 'package:legal_friend/variables/pColor.dart';
import 'package:legal_friend/variables/variables.dart';
import 'package:provider/provider.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({Key key}) : super(key: key);

  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  TextEditingController _firstName=TextEditingController(text: '');
  TextEditingController _laseName=TextEditingController(text: '');
  TextEditingController _day=TextEditingController(text: '');
  TextEditingController _month=TextEditingController(text: '');
  TextEditingController _year=TextEditingController(text: '');
  String _gender='';
  String _profession='';

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///Image
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width*.2),
            child: Image.asset('assets/logo/splash_image.png'),
          ),
          Text(
            'Make your information true,\nIt\'s easy and fast',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black,fontSize: size.width*.06,fontWeight: FontWeight.w500),
          ),
          SizedBox(height: size.width*.04),

          Container(
            padding: EdgeInsets.all(size.width*.04),
            margin: EdgeInsets.symmetric(horizontal: size.width*.07),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(size.width*.04))
            ),
            child: Column(
              children: [
                TextFieldBuilder(controller: _firstName, hintText: 'First Name'),
                SizedBox(height:size.width*.04),
                TextFieldBuilder(controller: _laseName, hintText: 'Last Name'),
                SizedBox(height:size.width*.04),
                Row(
                  children: [
                    Expanded(child: TextFieldBuilder(controller: _day, hintText: 'Day',textInputType: TextInputType.number)),
                    SizedBox(width:size.width*.02),
                    Expanded(child: TextFieldBuilder(controller: _month, hintText: 'Month',textInputType: TextInputType.number)),
                    SizedBox(width:size.width*.02),
                    Expanded(child: TextFieldBuilder(controller: _year, hintText: 'Year',textInputType: TextInputType.number)),
                  ],
                ),
                SizedBox(height:size.width*.04),

                ///Gender
                Row(
                  children: Variables.genderList.map((item) => Expanded(
                      child: InkWell(
                        onTap: ()=> setState(()=>_gender=item),
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: item=='Male' || item=='Female'
                              ?size.width*.02:0.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: item==_gender
                                ? PColor.blueColor:Colors.grey),
                            color: item==_gender?PColor.blueColor:Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(size.width*.02))
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: size.width * .032,
                              horizontal: size.width * .04),
                          child: Text(item,style: TextStyle(
                            fontSize: size.width*.04,
                            color: item==_gender
                                ? Colors.white:Colors.grey
                          ),),
                        ),
                      ))
                  ).toList(),
                ),
                SizedBox(height:size.width*.04),

                // Expanded(
                //   child: GridView(
                //     shrinkWrap: true,
                //     scrollDirection: Axis.vertical,
                //     physics: ClampingScrollPhysics(),
                //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 2,
                //       // crossAxisSpacing: size.width*.02,
                //       // mainAxisSpacing: size.width*.02,
                //       // childAspectRatio: 1
                //     ),
                //     children: Variables.professionList.map((item) =>
                //         Container(color: Colors.green)
                //     //     InkWell(
                //     //   onTap: ()=> setState(()=>_profession=item),
                //     //   child: Container(
                //     //     alignment: Alignment.center,
                //     //     margin: EdgeInsets.only(right: item=='Male' || item=='Female'
                //     //         ?size.width*.02:0.0),
                //     //     decoration: BoxDecoration(
                //     //         border: Border.all(color: item==_profession
                //     //             ? PColor.blueColor:Colors.grey),
                //     //         color: item==_profession?PColor.blueColor:Colors.white,
                //     //         borderRadius: BorderRadius.all(Radius.circular(size.width*.02))
                //     //     ),
                //     //     padding: EdgeInsets.symmetric(
                //     //         vertical: size.width * .032,
                //     //         horizontal: size.width * .04),
                //     //     child: Text(item,style: TextStyle(
                //     //         fontSize: size.width*.04,
                //     //         color: item==_profession
                //     //             ? Colors.white:Colors.grey
                //     //     ),),
                //     //   ),
                //     // )
                //     ).toList(),
                //   ),
                // ),
                SizedBox(height:size.width*.04),

                GradientButton(
                  onPressed: (){},
                  child: Text('Create Your Profile',
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
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
