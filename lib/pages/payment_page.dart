import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:legal_friend/pages/login_page.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/tiles/notification_widget.dart';
import 'package:legal_friend/variables/variables.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class PaymentPage extends StatefulWidget {
  String id;
  String amoliAdalot;
  String bicarikAdalot;
  String boiNo;
  String dayraNo;
  String entryDate;
  String mamlaNo;
  String mamlarDhoron;
  String pokkhoDhara;
  String porobortiTarikh;
  String jojCourt;
  PaymentPage({
      this.id,
      this.amoliAdalot,
      this.bicarikAdalot,
      this.boiNo,
      this.dayraNo,
      this.entryDate,
      this.mamlaNo,
      this.mamlarDhoron,
      this.pokkhoDhara,
      this.porobortiTarikh,
      this.jojCourt});
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isLoading=false;
  bool isLoading=false;
  SharedPreferences _preferences;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(child: spinCircle())
          : _bodyUI(size,publicProvider),
      bottomNavigationBar: BottomTile(),

    );
  }

  Widget _bodyUI(Size size,PublicProvider publicProvider){
    _isLoading = false;
    return SafeArea(
      child: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Image.asset('assets/home_image/bodli_khana.png',height: size.width*.4,width: size.width*.8),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  width: size.width*.9,
                  padding: EdgeInsets.all(size.width*.04),
                  decoration: BoxDecoration(
                      color: Color(0xffB3E9FA),
                      borderRadius: BorderRadius.all(Radius.circular(size.width*.02))
                  ),
                  child: Text(
                    Variables.paymentMgs,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'barkatFontBold',fontSize: size.width*.05),),
                ),
                SizedBox(height: size.width*.1),

                Container(
                  width: size.width*.8,
                  child: GradientButton(
                    onPressed: ()async{
                      _preferences = await SharedPreferences.getInstance();
                      String _userPhone = _preferences.getString('userPhone');
                      if(_userPhone!=null){
                        _startPaymentProcess(publicProvider,_userPhone);
                      }else Navigator.push(context, MaterialPageRoute(builder: (context)=>LogInPage()));
                    },
                    child: Text('নিশ্চিত করুন', style: TextStyle(
                        fontSize: size.width * .055,
                        color: Colors.white,
                        fontFamily: 'niladriFontLite')),
                    height: size.width * .12,
                    width: size.width*.8,
                    borderRadius: size.width * .03,
                    gradientColors: [
                      Colors.blue[600],
                      Colors.blue[400],
                    ],
                  ),
                )
              ],
            ),
            Container(),
            //Container(),
          ],
        ),
      ),
  ),
    );
  }

  Future<void> _startPaymentProcess(PublicProvider publicProvider,String userPhone)async{
    showLoadingDialog('অপেক্ষা করুন');
    final String todayDate = DateFormat("dd-MM-yyyy")
        .format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch));
    final uuid = Uuid();
    String id = uuid.v1();
    Map<String, String> map = {
      'id': id,
      'data_id': widget.id,
      'user_phone': userPhone,
      'amoli_adalot': widget.amoliAdalot,
      'bicarik_adalot': widget.bicarikAdalot,
      'boi_no': widget.boiNo,
      'dayra_no': widget.dayraNo,
      'entry_date': widget.entryDate,
      'mamla_no': widget.mamlaNo,
      'mamlar_dhoron': widget.mamlarDhoron,
      'pokkho_dhara': widget.pokkhoDhara,
      'poroborti_tarikh': widget.porobortiTarikh,
      'joj_court': widget.jojCourt,
      'save_date': todayDate
    };

    final url = Uri.parse('https://sandbox.walletmix.com/check-server');
    ///Get InitUrl
    var response = await http.get(url);
    var jsonData= jsonDecode(response.body);
    if(response.statusCode==200){
      final _initUrl = jsonData['url'];
      final _bankUrl = jsonData['bank_payment_url'];

      closeLoadingDialog();
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>StartPaymentProcess(
      //   archiveDataMap: map,
      //   initUrl: _initUrl,
      //   bankUrl: _bankUrl,
      // )));
    }else{
      closeLoadingDialog();
      showErrorMgs('Error Payment process! Try Again');
    }

    // await publicProvider.archiveData(map).then((value)async{
    //   if(value==true){
    //     await publicProvider.getArchiveDataList().then((value){
    //       closeLoadingDialog();
    //       showSuccessMgs('আর্কাইভ সম্পন্ন হয়েছে');
    //     });
    //   }else{
    //     closeLoadingDialog();
    //     showErrorMgs('আর্কাইভ অসম্পন্ন হয়েছে');
    //   }
    // });
  }
}



// ignore: must_be_immutable
class StartPaymentProcess extends StatefulWidget {
  Map<String,String> archiveDataMap;
  String initUrl;
  String bankUrl;

  StartPaymentProcess({this.archiveDataMap, this.initUrl, this.bankUrl});

  @override
  _StartPaymentProcessState createState() => _StartPaymentProcessState();
}

class _StartPaymentProcessState extends State<StartPaymentProcess> {
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("  পেমেন্ট সমপন্ন করুন",style: TextStyle(color: Colors.grey.shade800,fontSize: 16)),
                IconButton(onPressed: ()=>Navigator.pop(context),
                    icon: Icon(Icons.cancel_outlined,color: Colors.grey),
                splashRadius: 30,)
              ],
            ),
          ),
          body: Container(
              child: Column(
                  children: <Widget>[
                    if (progress != 1.0) LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),    // Should be removed while showing
                    Expanded(
                      child: Container(
                        child: InAppWebView(
                          initialUrl: widget.initUrl,
                          onPageCommitVisible: (InAppWebViewController controller, String url){
                              if(url== 'https://glamworlditltd.com/portfolio.php'){
                                Navigator.pop(context);
                              }
                          },
                          onProgressChanged: (InAppWebViewController controller, int progress) {
                            setState(() {
                              this.progress = progress / 100;
                            });
                          },
                        ),
                      ),
                    )
                    // ignore: unnecessary_null_comparison
                  ].where((Object o) => o != null).toList()))),
    );  //Remove null widgets
  }
}

