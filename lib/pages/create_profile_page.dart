import 'package:flutter/gestures.dart';
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
  TextEditingController _password=TextEditingController(text: '');
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
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///Image
          Padding(
            padding: EdgeInsets.fromLTRB(size.width*.2, size.width*.05, size.width*.2, 0.0),
            child: Image.asset('assets/logo/splash_image.png'),
          ),
          Text(
            'Make your information true,\nIt\'s easy and fast',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black,fontSize: size.width*.06,fontWeight: FontWeight.w500),
          ),
          SizedBox(height: size.width*.04),

          ///Field Container
          Container(
            padding: EdgeInsets.all(size.width*.04),
            margin: EdgeInsets.symmetric(horizontal: size.width*.04),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(size.width*.04))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldBuilder(controller: _firstName, labelText: 'First Name'),
                SizedBox(height:size.width*.04),
                TextFieldBuilder(controller: _laseName, labelText: 'Last Name'),
                SizedBox(height:size.width*.04),

                ///Date of birth
                Padding(
                  padding: EdgeInsets.only(bottom: size.width*.02),
                  child: Text('Date of birth',
                      textAlign: TextAlign.start,
                      style:TextStyle(
                        color: Colors.grey,
                        fontSize: size.width*.045,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                Row(
                  children: [
                    Expanded(child: TextFieldBuilder(controller: _day, labelText: 'Day',textInputType: TextInputType.number)),
                    SizedBox(width:size.width*.02),
                    Expanded(child: TextFieldBuilder(controller: _month, labelText: 'Month',textInputType: TextInputType.number)),
                    SizedBox(width:size.width*.02),
                    Expanded(child: TextFieldBuilder(controller: _year, labelText: 'Year',textInputType: TextInputType.number)),
                  ],
                ),
                SizedBox(height:size.width*.04),

                ///Gender
                Padding(
                  padding: EdgeInsets.only(bottom: size.width*.02),
                  child: Text('Gender',
                      textAlign: TextAlign.start,
                      style:TextStyle(
                    color: Colors.grey,
                    fontSize: size.width*.045,
                    fontWeight: FontWeight.w500,
                  )),
                ),
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
                              vertical: size.width * .025,
                              horizontal: size.width * .04),
                          child: Text(item,maxLines:1,style: TextStyle(
                            fontSize: size.width*.04,
                            color: item==_gender
                                ? Colors.white:Colors.grey
                          ),),
                        ),
                      ))
                  ).toList(),
                ),
                SizedBox(height:size.width*.04),

                ///Profession
                Padding(
                  padding: EdgeInsets.only(bottom: size.width*.02),
                  child: Text('Profession',
                      textAlign: TextAlign.start,
                      style:TextStyle(
                        color: Colors.grey,
                        fontSize: size.width*.045,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                GridView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: size.width*.02,
                    mainAxisSpacing: size.width*.02,
                    childAspectRatio: 3.8
                  ),
                  children: Variables.professionList.map((item) =>
                    InkWell(
                    onTap: ()=> setState(()=>_profession=item),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: item==_profession
                              ? PColor.blueColor:Colors.grey),
                          color: item==_profession?PColor.blueColor:Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(size.width*.02))
                      ),
                      child: Text(item,maxLines:1,style: TextStyle(
                          fontSize: size.width*.04,
                          color: item==_profession
                              ? Colors.white:Colors.grey
                      ),),
                    ),
                  )
                  ).toList(),
                ),
                SizedBox(height:size.width*.1),

                ///Remember Password
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Remember your phone and password\n',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: size.width*.04,
                        fontWeight: FontWeight.w400,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'you need to login to a new device.')
                      ],
                    ),
                  ),
                ),
                SizedBox(height:size.width*.04),

                ///Password
                TextFieldBuilder(controller: _password, labelText: 'Make your new password',obscure: true),
                SizedBox(height:size.width*.05),

                ///Button
                GradientButton(
                  onPressed: (){},
                  child: Text('Create Your Profile',
                      style: TextStyle(
                          fontSize: size.width * .06,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: PColor.yellowColor
                      )),
                  height: size.width * .12,
                  width: size.width * .9,
                  gradientColors: [
                    PColor.themeColor,
                    PColor.themeColor
                  ],
                ),
                SizedBox(height:size.width*.05),

                ///Privacy policy
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'By clicking create new profile, you agree to the Legalfriend ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: size.width*.04,
                        fontWeight: FontWeight.w400,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Privacy Policy.\n',
                            style: TextStyle(color: PColor.blueColor,fontWeight: FontWeight.w500),
                        recognizer: TapGestureRecognizer()..onTap = () {
                            print('tapped');
                          }),
                        TextSpan(text: 'You may receive SMS notification from us.')
                      ],
                    ),
                  ),
                ),
                SizedBox(height:size.width*.04),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
