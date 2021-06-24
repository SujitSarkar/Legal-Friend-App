import 'package:flutter/material.dart';
import 'package:legal_friend/pages/bodli_khana.dart';
import 'package:legal_friend/pages/search_page.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/app_bar.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/variables/variables.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ArchiveDetails extends StatefulWidget {
  String id;
  String dataId;
  String userPhone;
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
  String saveDate;
  ArchiveDetails(
      {this.id,
      this.dataId,
      this.userPhone,
      this.amoliAdalot,
      this.bicarikAdalot,
      this.boiNo,
      this.dayraNo,
      this.entryDate,
      this.mamlaNo,
      this.mamlarDhoron,
      this.pokkhoDhara,
      this.porobortiTarikh,
      this.jojCourt,
      this.saveDate});

  @override
  _ArchiveDetailsState createState() => _ArchiveDetailsState();
}

class _ArchiveDetailsState extends State<ArchiveDetails> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: PublicAppBar(
          pageName: '', //Variables.niAct,
          bottomText: '',
          image: 'assets/home_image/bodli_khana.png',
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: _bodyUI(size),
      bottomNavigationBar: BottomTile(),
      // floatingActionButton: BottomTile(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _bodyUI(Size size) => SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.width * .2),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  //text: 'Hello ',
                  style: TextStyle(
                      color: Colors.grey[900], fontSize: size.width * .04),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${widget.mamlarDhoron==Variables.niAct
                            ? Variables.crMamlaNo:Variables.mamlaNo}${widget.mamlaNo}\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * .06,
                        )),
                    TextSpan(
                        text: '${widget.pokkhoDhara}\n',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * .06)),
                    TextSpan(text: '${Variables.dayraNo} ${widget.dayraNo}\n'),
                    TextSpan(
                        text:
                            '${Variables.porobortiTarikh} ${widget.porobortiTarikh} ইং\n'),
                    TextSpan(text: '${Variables.amoliAdalot}\n'),
                    TextSpan(text: '${widget.amoliAdalot}\n'),
                    TextSpan(text: '${Variables.bicaricAdalot}\n'),
                    TextSpan(text: '${widget.bicarikAdalot}\n'),
                    TextSpan(text: '${Variables.boiNo} ${widget.boiNo}\n'),
                    TextSpan(text: 'মামলার ধরন- ${widget.mamlarDhoron}\n'),
                  ],
                ),
              ),
              SizedBox(height: size.width * .2),
              GradientButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BodliKhana())),
                child: Text(Variables.abarOnusondhanKorun,
                    style: TextStyle(fontSize: size.width * .06)),
                height: size.width * .12,
                width: size.width * .8,
                borderRadius: size.width * .03,
                gradientColors: [
                  Colors.purple.shade700,
                  Colors.purple.shade500,
                ],
              ),
            ],
          ),
        ),
      );
}
