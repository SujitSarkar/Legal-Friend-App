import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:legal_friend/pages/archive_list.dart';
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
  PaymentPage(
      {this.id,
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
  bool _isLoading = false;
  bool isLoading = false;
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
      resizeToAvoidBottomInset: true,
      body: _isLoading
          ? Center(child: spinCircle())
          : _bodyUI(size, publicProvider),
      bottomNavigationBar: BottomTile(),
    );
  }

  Widget _bodyUI(Size size, PublicProvider publicProvider) {
    _isLoading = false;
    return SafeArea(
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/home_image/bodli_khana.png',
                  height: size.width * .4, width: size.width * .8),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width * .9,
                    padding: EdgeInsets.all(size.width * .04),
                    decoration: BoxDecoration(
                        color: Color(0xffB3E9FA),
                        borderRadius: BorderRadius.all(
                            Radius.circular(size.width * .02))),
                    child: Text(
                      Variables.paymentMgs,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'barkatFontBold',
                          fontSize: size.width * .05),
                    ),
                  ),
                  SizedBox(height: size.width * .1),
                  Container(
                    width: size.width * .8,
                    child: GradientButton(
                      onPressed: () async {
                        _preferences = await SharedPreferences.getInstance();
                        String _userPhone = _preferences.getString('userPhone');
                        if (_userPhone != null) {
                          _startPaymentProcess(publicProvider);
                        } else
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LogInPage()));
                      },
                      child: Text('নিশ্চিত করুন',
                          style: TextStyle(
                              fontSize: size.width * .055,
                              color: Colors.white,
                              fontFamily: 'niladriFontLite')),
                      height: size.width * .12,
                      width: size.width * .8,
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

  Future<void> _startPaymentProcess(PublicProvider publicProvider) async {
    showLoadingDialog('অপেক্ষা করুন');
    final String todayDate = DateFormat("dd-MM-yyyy").format(
        DateTime.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch));
    final uuid = Uuid();
    final String id = uuid.v1();

    final url = Uri.parse('https://epay.walletmix.com/check-server');
    //Get InitUrl
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final _initUrl = jsonData['url'];
      final _bankUrl = jsonData['bank_payment_url'];

      //Bang Payment Request
      var secondResponse = await http.post(Uri.parse(_initUrl), body: {
        'amount': '48.78',
        'currency': 'BDT',
        'options': 'cz1leGFtcGxlLmNvbSxpPTE5Mi4xNjguMTAwLjEwNQ==',
        'callback_url': 'https://legalfriendbd.com',
        'authorization':
            'Basic bGVnYWxmcmllbmRvZmN0Z18xNjYxNzA2NTQ4OmxlZ2FsZnJpZW5kb2ZjdGdfMTk1MDAzOA==',
        'app_name': 'legalfriendbd.com',
        'access_app_key': 'd38b9713157fec41b317e07f43482d9116020d84',
        'wmx_id': 'WMX60d420f681598',
        'merchant_ref_id': id.substring(0, 10),
        'customer_name': 'কামরুল হাসান',
        'customer_email': 'legalfriendbd@gmail.com',
        'customer_add': 'জজ কোর্ট, ঢাকা',
        'customer_phone': _preferences.getString('userPhone'),
        'product_desc': 'Book Product',
        'merchant_order_id': id.substring(0, 10),
        'cart_info': 'WMX1234567891234,http://example.com,MyApp'
      });
      var secondJsonData = jsonDecode(secondResponse.body);
      if (secondResponse.statusCode == 200) {
        String _token = secondJsonData['token'];
        Map<String, String> map = {
          'id': id.substring(0, 10),
          'data_id': widget.id,
          'user_phone': _preferences.getString('userPhone'),
          'user_name': 'কামরুল হাসান',
          'user_address': 'জজ কোর্ট, ঢাকা',
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
        closeLoadingDialog();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StartPaymentProcess(
                      archiveDataMap: map,
                      initUrl: _initUrl,
                      bankUrl: _bankUrl,
                      token: _token,
                      userPhone: _preferences.getString('userPhone'),
                    )));
      } else {
        closeLoadingDialog();
        showErrorMgs('Failed Bank Payment Request !');
      }
    } else {
      closeLoadingDialog();
      showErrorMgs('Error Payment process! Try Again');
    }
  }
}

// ignore: must_be_immutable
class StartPaymentProcess extends StatefulWidget {
  Map<String, String> archiveDataMap;
  String initUrl;
  String bankUrl;
  String token;
  String userPhone;

  StartPaymentProcess(
      {this.archiveDataMap,
      this.initUrl,
      this.bankUrl,
      this.token,
      this.userPhone});

  @override
  _StartPaymentProcessState createState() => _StartPaymentProcessState();
}

class _StartPaymentProcessState extends State<StartPaymentProcess> {
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("  পেমেন্ট সমপন্ন করুন",
                    style:
                        TextStyle(color: Colors.grey.shade800, fontSize: 17)),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.cancel_outlined, color: Colors.grey),
                  splashRadius: 30,
                )
              ],
            ),
          ),
          body: Container(
              child: Column(
                  children: <Widget>[
            if (progress != 1.0)
              LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue)), // Should be removed while showing
            Expanded(
              child: Container(
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                      url: Uri.parse('${widget.bankUrl}/${widget.token}')),
                  onPageCommitVisible:
                      (InAppWebViewController controller, Uri uri) {
                    print(uri);
                    if (uri == Uri.parse('https://legalfriendbd.com/')) {
                      _verifyPayment(publicProvider);
                    }
                    // else if (uri ==
                    //     Uri.parse('https://sandbox.walletmix.com/abort')) {
                    //   showErrorMgs('অসম্পূর্ণ অর্থ প্রদান');
                    //   Navigator.of(context).pop();
                    //   //_verifyPayment(publicProvider);
                    // }
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                ),
              ),
            )
            // ignore: unnecessary_null_comparison
          ].where((Object o) => o != null).toList()))),
    ); //Remove null widgets
  }

  Future<void> _verifyPayment(PublicProvider publicProvider) async {
    showLoadingDialog('পেমেন্ট সম্পূর্ণ করা হচ্ছে');
    var response = await http
        .post(Uri.parse('https://epay.walletmix.com/check-payment'), body: {
      'wmx_id': 'WMX60d420f681598',
      'authorization':
          'Basic bGVnYWxmcmllbmRvZmN0Z18xNjYxNzA2NTQ4OmxlZ2FsZnJpZW5kb2ZjdGdfMTk1MDAzOA==',
      'access_app_key': 'd38b9713157fec41b317e07f43482d9116020d84',
      'token': widget.token
    });
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['statusCode'] == 1000) {
        //payment success code is 1000
        showSuccessMgs('পেমেন্ট সম্পন্ন হয়েছে');
        showLoadingDialog('আর্কাইভ করা হচ্ছে...');
        await publicProvider
            .archiveData(widget.archiveDataMap)
            .then((value) async {
          if (value == true) {
            Map<String, String> paymentInfoMap = {
              'wmx_id': jsonData['wmx_id'],
              'ref_id': jsonData['ref_id'],
              'token': jsonData['token'],
              'user_phone': widget.userPhone,
              'merchant_req_amount': jsonData['merchant_req_amount'],
              'merchant_ref_id': jsonData['merchant_ref_id'],
              'merchant_currency': jsonData['merchant_currency'],
              'merchant_amount_bdt': jsonData['merchant_amount_bdt'],
              'conversion_rate': jsonData['conversion_rate'],
              'service_ratio': jsonData['service_ratio'],
              'wmx_charge_bdt': jsonData['wmx_charge_bdt'],
              'emi_ratio': jsonData['emi_ratio'],
              'emi_charge': jsonData['emi_charge'],
              'bank_amount_bdt': jsonData['bank_amount_bdt'],
              'discount_bdt': jsonData['discount_bdt'],
              'merchant_order_id': jsonData['merchant_order_id'],
              'request_ip': jsonData['request_ip'],
              'card_details': jsonData['card_details'],
              'is_foreign': jsonData['is_foreign'],
              'payment_card': jsonData['payment_card'],
              'card_code': jsonData['card_code'],
              'payment_method': jsonData['payment_method'],
              'init_time': jsonData['init_time'].toString(),
              'txn_time': jsonData['txn_time'].toString(),
            };
            await publicProvider
                .savePaymentInfo(paymentInfoMap)
                .then((value) async {
              await publicProvider.getArchiveDataList().then((value) {
                closeLoadingDialog();
                showSuccessMgs('আর্কাইভ সম্পন্ন হয়েছে');
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchiveList()));
              });
            });
          } else {
            closeLoadingDialog();
            showErrorMgs('আর্কাইভ অসম্পন্ন হয়েছে');
            Navigator.of(context).pop();
          }
        });
      } else if (jsonData['statusCode'] == 1008) {
        //payment not success code is 1000
        showErrorMgs('অসম্পূর্ণ অর্থ প্রদান');
        Navigator.of(context).pop();
      } else {
        showErrorMgs('অসম্পূর্ণ অর্থ প্রদান');
        Navigator.of(context).pop();
      }
    } else {
      showErrorMgs('অসম্পূর্ণ অর্থ প্রদান');
      Navigator.of(context).pop();
    }
  }
}
