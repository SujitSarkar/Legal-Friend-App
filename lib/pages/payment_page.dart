import 'package:aamarpay/aamarpay.dart';
import 'package:flutter/material.dart';
import 'package:legal_friend/pages/archive_list.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/variables/variables.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    return Scaffold(
      body: _bodyUI(size,publicProvider),
      floatingActionButton: BottomTile(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _bodyUI(Size size,PublicProvider publicProvider){
    isLoading = false;
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

                AamarpayData(
                    returnUrl: (url) {
                      if(url=="https://sandbox.aamarpay.com/confirm"){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchiveList()));
                      }
                    },
                    isLoading: (v) {
                      setState(() {
                        isLoading = v;
                      });
                    },
                    paymentStatus: (status) {
                      print(status);
                    },
                    cancelUrl: "/cancel",
                    successUrl: "/confirm",
                    failUrl: "/fail",
                    customerEmail: "masumbillahsanjid@gmail.com",
                    customerMobile: "01834760591",
                    customerName: "Masum Billah Sanjid",
                    signature: "dbb74894e82415a2f7ff0ec3a97e4183",
                    storeID: "aamarpaytest",
                    transactionAmount: "100",
                    transactionID: "${DateTime.now().microsecondsSinceEpoch.toString()}",
                    description: "Description",
                    url: "https://sandbox.aamarpay.com",
                    child: isLoading
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                        : Container(
                      width: size.width*.8,
                      child: GradientButton(
                        //onPressed: (){},
                        child: Text('wbwðZ Ki“b', style: TextStyle(
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
                    )),
              ],
            ),
            Container(),
            //Container(),
          ],
        ),
      ),
  ),
    );}
}
