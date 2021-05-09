import 'package:flutter/material.dart';
import 'package:legal_friend/pages/ni_act_list.dart';
import 'package:legal_friend/tiles/app_bar.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/form_decoration.dart';
import 'package:legal_friend/tiles/gradient_button.dart';

class NIActPage extends StatefulWidget {

  @override
  _NIActPageState createState() => _NIActPageState();
}

class _NIActPageState extends State<NIActPage>{
  String _amoliAdalot;
  String _jojkrot;

  List<String> _amoliAdalotItem = ['wm.Gg.Gg','wm.†R.Gg'];

  List<String> _jojkrotItem = ['XvKv','Lyjbv','cvebv'];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: PublicAppBar(
          pageName: 'Gb.AvB G±',
          bottomText: 'me©‡kl Avc‡WUt eB-6/2020 ch©š—',
          image: 'assets/home_image/bodli_khana.png',
          color: Colors.red[400],
        ),
      ),
      body: _bodyUI(size),
      floatingActionButton: BottomTile(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _bodyUI(Size size)=>SingleChildScrollView(
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.width*.2),
          Container(
            width: size.width*.7,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: size.width * .02,),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[800],width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(size.width*.02)),
            ),
            child: Text('eB bs-9/2021 †_‡K ïi“ n‡q‡Q|',style: TextStyle(
                fontSize: size.width * .04,
                fontFamily: 'barkatFontBold',color: Colors.grey[900])),
          ),
          SizedBox(height: size.width*.08),
          
          _dropDownBuilder(size, 'Avgjx Av`vjZ-'),
          SizedBox(height: size.width*.04),
          _dropDownBuilder(size, 'RR †KvU©,'),
          SizedBox(height: size.width*.04),

          Container(
              width: size.width*.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width*.35,
                    alignment: Alignment.centerRight,
                    child: Text('wmqvi gvgjv bs- ',style: TextStyle(
                        fontSize: size.width * .04,
                        fontFamily: 'barkatFontBold',color: Colors.grey[900])),
                  ),
                  Container(
                    width: size.width*.16,
                    child: TextField(
                      //controller: _maxController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          color: Colors.grey[900], fontSize: size.width * .035,fontFamily: 'barkatFontBold'),
                      decoration: boxFormDecoration(size).copyWith(
                        hintText: '2925',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: size.width * .015,
                            horizontal: size.width * .02),
                        //Change this value to custom as you like
                        isDense: true,
                      ),
                    ),
                  ),
                  Text('/',style: TextStyle(color: Colors.grey[900],fontSize: size.width*.05,fontWeight: FontWeight.bold),),
                  Container(
                    width: size.width*.16,
                    child: TextField(
                      //controller: _maxController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          color: Colors.grey[900], fontSize: size.width * .035,fontFamily: 'barkatFontBold'),
                      decoration: boxFormDecoration(size).copyWith(
                        hintText: '2019',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: size.width * .015,
                            horizontal: size.width * .02),
                        //Change this value to custom as you like
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              )
          ),
          SizedBox(height: size.width*.2),

          GradientButton(
            onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>NIActList())),
            child: Text('AbymÜvb Ki“b', style: TextStyle(
                fontSize: size.width * .04, fontFamily: 'niladriFontLite')),
            height: size.width * .1,
            width: size.width*.5,
            borderRadius: size.width * .03,
            gradientColors: [
              Colors.yellow[900],
              Colors.yellow[800],
            ],
          ),
        ],
      ),
    ),
  );

  Widget _dropDownBuilder(Size size, String name)=>Container(
    width: size.width*.7,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: size.width*.35,
          padding: EdgeInsets.symmetric(horizontal: 10,vertical:size.width * .02,),
          child: Text(name,
            textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: size.width * .04,
                  fontFamily: 'barkatFontBold',color: Colors.grey[900]),
          ),
        ),

        Container(
          width: size.width*.35,
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[800],width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(size.width*.02))
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isDense: true,
              isExpanded: true,
              value: name=='Avgjx Av`vjZ-'?_amoliAdalot:_jojkrot,
              hint: Text("wbe©vPb Ki“b",style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: size.width*.04,
                  fontFamily: 'barkatFontBold')),
              items:name=='Avgjx Av`vjZ-'? _amoliAdalotItem.map((category){
                return DropdownMenuItem(
                  child: Text(category,style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: size.width*.04,
                      fontFamily: 'barkatFontBold')),
                  value: category,
                );
              }).toList()
                  :_jojkrotItem.map((category){
                return DropdownMenuItem(
                  child: Text(category,style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: size.width*.04,
                      fontFamily: 'barkatFontBold')),
                  value: category,
                );
              }).toList(),
              onChanged: (newValue)=> setState(()=>
                name=='Avgjx Av`vjZ-'? _amoliAdalot = newValue: _jojkrot=newValue),
              dropdownColor: Colors.white,
            ),
          ),
        ),

      ],
    ),
  );
}
