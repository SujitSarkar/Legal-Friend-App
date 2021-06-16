import 'package:flutter/material.dart';
import 'package:legal_friend/tiles/form_decoration.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/tiles/notification_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LogInPage extends StatelessWidget {
  TextEditingController _phone = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('   লগ ইন করুন',style: TextStyle(color: Colors.grey.shade900,fontSize: size.width*.05),),
              IconButton(onPressed: ()=>Navigator.pop(context),
                icon: Icon(Icons.cancel_outlined,color: Colors.grey),
                splashRadius: 30,
              )
            ],
          ),
        ),
        body: Center(
          child: Container(
            height: size.height*.4,
            width: size.width*.8,
            padding: EdgeInsets.symmetric(horizontal: size.width*.05,vertical: size.width*.04),
            decoration: BoxDecoration(
                color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('ডেটা সেভ করে রাখতে হলে আপনার মোবাইল নাম্বার দিয়ে লগ-ইন করুন ।',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade900,fontSize: size.width*.04),),
                SizedBox(height: size.width*.08),
                TextField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  decoration: boxFormDecoration(size).copyWith(
                    hintText: 'মোবাইল নাম্বার'
                  ),
                ),
                SizedBox(height: size.width*.04),

                GradientButton(
                  onPressed: ()async{
                    if(_phone.text.isNotEmpty){
                      showLoadingDialog('অপেক্ষা করো');
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      preferences.setString('userPhone', _phone.toString());
                      closeLoadingDialog();
                      Navigator.pop(context);
                    }else showToast('মোবাইল নাম্বার প্রদান করুন');
                  },
                  child: Text('লগ ইন', style: TextStyle(
                      fontSize: size.width * .044)),
                  height: size.width * .1,
                  width: size.width*.5,
                  borderRadius: size.width * .03,
                  gradientColors: [
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
