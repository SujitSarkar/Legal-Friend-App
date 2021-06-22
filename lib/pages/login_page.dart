import 'package:flutter/material.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/form_decoration.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/tiles/notification_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LogInPage extends StatelessWidget {
  TextEditingController _phone = TextEditingController(text: '');
  TextEditingController _name = TextEditingController(text: '');
  TextEditingController _address = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '   লগ ইন করুন',
                style: TextStyle(
                    color: Colors.grey.shade900, fontSize: size.width * .05),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.cancel_outlined, color: Colors.grey),
                splashRadius: 30,
              )
            ],
          ),
        ),
        body: Center(
          child: Container(
            height: size.height * .5,
            width: size.width * .8,
            padding: EdgeInsets.symmetric(
                horizontal: size.width * .05, vertical: size.width * .04),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'আর্কাইভ লিষ্ট দেখতে অথবা ডেটা আর্কাইভ করে রাখতে হলে লগ-ইন করুন ।',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey.shade900, fontSize: size.width * .04),
                ),
                SizedBox(height: size.width * .08),
                _textFieldBuilder('আপনার নাম', size),
                SizedBox(height: size.width * .04),
                _textFieldBuilder('ঠিকানা', size),
                SizedBox(height: size.width * .04),
                TextField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  textCapitalization: TextCapitalization.words,
                  maxLength: 11,
                  decoration: boxFormDecoration(size)
                      .copyWith(hintText: 'মোবাইল নাম্বার'),
                ),
                SizedBox(height: size.width * .04),
                GradientButton(
                  onPressed: () async {
                    if (_phone.text.isNotEmpty &&
                        _name.text.isNotEmpty &&
                        _address.text.isNotEmpty) {
                      showLoadingDialog('অপেক্ষা করো');
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.setString('userPhone', _phone.text);
                      await preferences.setString('address', _address.text);
                      await preferences.setString('name', _name.text);
                      await publicProvider.getArchiveDataList();
                      closeLoadingDialog();
                      Navigator.pop(context);
                    } else
                      showToast('ফর্ম পুরন করুন');
                  },
                  child: Text('লগ ইন',
                      style: TextStyle(fontSize: size.width * .044)),
                  height: size.width * .1,
                  width: size.width * .5,
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

  Widget _textFieldBuilder(String hint, Size size) => TextField(
        controller: hint == 'আপনার নাম' ? _name : _address,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        decoration: boxFormDecoration(size).copyWith(hintText: hint),
      );
}
