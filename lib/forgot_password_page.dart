import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legal_friend/tiles/loading_widget.dart';
import 'package:legal_friend/tiles/notification_widget.dart';
import 'package:legal_friend/tiles/text_field_tile.dart';
import 'package:pinput/pinput.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final TextEditingController _phoneNumber =TextEditingController(text: '');
  final TextEditingController _newPassword =TextEditingController(text: '');
  String _verificationId;
  Timer _timer;
  int _seconds = 120;
  bool _otpVerified = false;
  String userId= '';
  bool _loading=false;

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Password Reset',
                style: TextStyle(color: Colors.grey.shade900,fontSize: size.width*.045)),
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.grey.shade800),
            backgroundColor: Colors.white,
          ),
          body: _bodyUI(size),
        ),
        if(_loading) LoadingWidget()
      ],
    );
  }

  Widget _bodyUI(Size size)=>SingleChildScrollView(
    padding: EdgeInsets.symmetric(horizontal: size.width*.05),
    child: Column(
      children: [
        Center(
          child: Image.asset('assets/forgot_password.png',height: size.width*.55)),

        ///Instruction
        Text('Forgot Password?',
            style: TextStyle(color: Colors.grey.shade900,
                fontWeight:FontWeight.w500,fontSize: size.width*.048)),
        Text('Don\'t worry! Provide your phone number, we will sent you a OTP to reset your password.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600,
                fontWeight:FontWeight.w500,fontSize: size.width*.038)),
        SizedBox(height: size.width*.06),

        ///Phone Number
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width*.02),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          child: TextFieldBuilder(controller: _phoneNumber,
              textInputType: TextInputType.number,
              readOnly: _verificationId==null?false:true,
              hintText: 'Phone Number'),
        ),
        SizedBox(height: size.width*.06),

        if(_verificationId!=null) Column(
          children: [
            Pinput(
              onCompleted: (value)async{
                _otpVerification(value);
              },
              length: 6,
              showCursor: true,
              defaultPinTheme: StaticDecoration.defaultPinTheme,
              focusedPinTheme: StaticDecoration.focusedPinTheme,
              submittedPinTheme: StaticDecoration.submittedPinTheme,
            ),
            SizedBox(height: size.width*.04),

            Center(
              child: _otpVerified
                  ? Text('Verified',
                  style: TextStyle(fontSize: size.width*.05,color: Colors.green,fontWeight: FontWeight.w500))
                  : Text(
                'OTP will resend after $_seconds sec',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: size.width*.04,color: Colors.grey.shade900),
              ),
            ),
          ]),

        if(_verificationId==null) ElevatedButton(
            onPressed: (){
              if(_phoneNumber.text.isNotEmpty){
                if(_phoneNumber.length==11){
                  _phoneAuth();
                }else {showToast('Invalid phone number');}
              }else {showToast('Provide phone number');}
            },
            child: Text('Get OTP',style: TextStyle(fontSize: size.width*.04))),
        SizedBox(height: size.width*.08),

        if(_otpVerified) Column(
          children: [
            Container(
                padding: EdgeInsets.all(size.width*.01),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child: TextFieldBuilder(controller: _newPassword,hintText: 'New Password')),
            SizedBox(height: size.width*.04),

            ElevatedButton(
                onPressed: ()async{
                  Map<String, dynamic> map = {
                    'id':userId,
                    'password': _newPassword.text
                  };
                }, child: Text('Reset',style: TextStyle(fontSize: size.width*.04)))
          ],
        ),

        SizedBox(height: size.width*.04),
      ],
    ),
  );


  Future<void> _phoneAuth() async {
      setState(()=>_loading=true);
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.verifyPhoneNumber(
        phoneNumber: '+88'+_phoneNumber.text,

        ///Auto Verification
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) {
            if (value.user != null) {
              setState(()=>_loading=false);
              setState(()=> _otpVerified=true);
              showToast('Phone number verified');
            } else {
              setState(()=>_loading=false);
              showToast('Verification Failed! Try again');
            }
          });
        },

        ///Verification Failed
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            setState(()=>_loading=false);
            showToast('The provided phone number is not valid');
          }
        },

        ///Verify with  OTP
        codeSent: (String verificationId, int resendToken) async {
          _loading=false;
          _verificationId = verificationId;
          setState(() {});
          _startTimer();
        },
        timeout: const Duration(seconds: 120),
        codeAutoRetrievalTimeout: (String verificationId) {
          showToast('OTP resend');
          _verificationId = verificationId;
          setState(() {});
        },
      );
    }


  Future<void> _otpVerification(otp)async{
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp);
    setState(()=>_loading=true);
    // Sign the user in (or link) with the credential
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      if (value.user != null) {
        setState(()=>_loading=false);
        setState(()=> _otpVerified=true);
        _timer.cancel();
      } else {
        setState(()=>_loading=false);
        setState(()=> _otpVerified=false);
        showToast('Invalid OTP');
      }
    });
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_seconds < 1) {
            timer.cancel();
          } else {
            if (_seconds >= 0) {
              setState(() => _seconds = _seconds - 1);
            }
            if (_seconds == 0) {
              _timer.cancel();
            }
          }
        },
      ),
    );
  }
}

class StaticDecoration{
  static var defaultPinTheme = PinTheme(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(6),
      )
  );

  static var submittedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.green),
      borderRadius: BorderRadius.circular(10)
  );
  static var focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.blue),
      borderRadius: BorderRadius.circular(10)
  );
}