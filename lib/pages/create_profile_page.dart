import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/tiles/text_field_tile.dart';
import 'package:legal_friend/variables/pColor.dart';
import 'package:legal_friend/variables/variables.dart';
import 'package:provider/provider.dart';
import '../providers/api_provider.dart';
import '../tiles/notification_widget.dart';
import 'advocate_page.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({Key key}) : super(key: key);

  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  TextEditingController _fullName=TextEditingController(text: '');
  TextEditingController _phone=TextEditingController(text: '');
  TextEditingController _password=TextEditingController(text: '');
  TextEditingController _workingPlace=TextEditingController(text: '');
  String _gender='';
  String _profession='';
  DateTime _dateOfBirth=DateTime(2000);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ApiProvider apiProvider = Provider.of<ApiProvider>(context);

    return Scaffold(
      backgroundColor: PColor.greyBgColor,
      bottomNavigationBar: BottomTile(),
      body: _bodyUI(size,apiProvider),
    );
  }

  Widget _bodyUI(Size size, ApiProvider apiProvider)=>SafeArea(
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
                TextFieldBuilder(controller: _fullName, labelText: 'Full Name',textCapitalization: TextCapitalization.words),
                SizedBox(height:size.width*.04),
                TextFieldBuilder(controller: _phone, labelText: 'Phone Number',textInputType: TextInputType.number),
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
                ///Date of birth
                InkWell(
                  onTap: ()=>_selectDateOfBirth(),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(
                        vertical: size.width * .03,
                        horizontal: size.width * .04),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(size.width*.02))
                    ),
                    child: Text(DateFormat('dd-MMM-yyyy').format(_dateOfBirth),style: TextStyle(
                        fontSize: size.width*.04,
                        color:Colors.grey
                    )),
                  ),
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
                SizedBox(height:size.width*.04),
                TextFieldBuilder(controller: _workingPlace, labelText: 'Write your working place',
                    textCapitalization: TextCapitalization.words),

                SizedBox(height:size.width*.08),

                ///Remember Password
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Remember your phone and password\n',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: size.width*.032,
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
                  onPressed: ()async{
                    if(_fullName.text.isNotEmpty && _phone.text.isNotEmpty && _password.text.isNotEmpty
                      && _workingPlace.text.isNotEmpty && _dateOfBirth!=null && _gender.isNotEmpty
                      && _profession.isNotEmpty){
                       Map<String, dynamic> map={
                        'name': _fullName.text,
                        'email':'example@gmail.com',
                        'phone': _phone.text,
                        'password': _password.text,
                        'profession': _profession,
                        'company': 'Not define',
                        'address': _workingPlace.text,
                        'gender': _gender,
                        'dob': DateFormat('dd-mm-yyyy').format(_dateOfBirth),
                        'religion': 'Not define',
                        'material_status':'Not define'};
                       print(_dateOfBirth.toString());
                      bool result = await apiProvider.createUser(map);
                      if(result){
                        Navigator.pop(context);
                      }
                    }else{showToast('সঠিক তথ্য দিয়ে পুনরায় চেষ্টা করুন');}
                  },
                  child: Text('Create Your Profile',
                      style: TextStyle(
                          fontSize: size.width * .06,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: PColor.yellowColor
                      )),
                  height: size.width * .12,
                  width: size.width * .9,
                  borderRadius: size.width * .03,
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
                        fontSize: size.width*.032,
                        fontWeight: FontWeight.w400,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Privacy Policy.\n',
                            style: TextStyle(color: PColor.blueColor,fontWeight: FontWeight.w500),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              AdvocatePage(webUrl: 'https://legalfriendbd.com/disclaimer.html',color: Color(0xff00ACA0))));
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

  Future<void> _selectDateOfBirth() async {
    final DateTime selectedDate = await showDatePicker(
        context: context,
        initialDate: _dateOfBirth,
        firstDate: DateTime(1971),
        lastDate: DateTime(DateTime.now().year-5));
    if (selectedDate != null) {
      setState(()=> _dateOfBirth = selectedDate);
    }else{showToast('কোনো তারিখ নির্বাচন করা হয়নি');}
  }
}
