import 'package:flutter/material.dart';
import 'package:legal_friend/model_class/bodli_khana_model.dart';
import 'package:legal_friend/pages/payment_page.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/variables/variables.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchListTile extends StatelessWidget {
   int index;
   List<BodliKhanaModel> dataList;
   SearchListTile({this.index,this.dataList});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);

    return Container(
      width: size.width*.8,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.width*.05),
          Text('${publicProvider.crToggle()}${dataList[index].mamlaNo}',style: TextStyle(
              fontSize: size.width * .04,
              color: Colors.grey[900])),
          SizedBox(height: size.width*.01),

          Text('${dataList[index].pokkhoDhara}',style: TextStyle(
              fontSize: size.width * .04,
              color: Colors.grey[900])),
          //SizedBox(height: size.width*.01),

          GradientButton(
            onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage(
                id: dataList[index].id,
                amoliAdalot: dataList[index].amoliAdalot,
                bicarikAdalot: dataList[index].bicarikAdalot,
                boiNo: dataList[index].boiNo,
                dayraNo: dataList[index].dayraNo,
                entryDate: dataList[index].entryDate,
                mamlaNo: dataList[index].mamlaNo,
                mamlarDhoron: dataList[index].mamlarDhoron,
                pokkhoDhara: dataList[index].pokkhoDhara,
                porobortiTarikh: dataList[index].porobortiTarikh,
                jojCourt: dataList[index].jojCourt
            ))),

            child: Text(Variables.archiveRakhun, style: TextStyle(
                fontSize: size.width * .04)),
            height: size.width * .1,
            width: size.width*.5,
            borderRadius: size.width * .03,
            gradientColors: [
              Colors.blue[600],
              Colors.blue[500],
            ],
          ),
          SizedBox(height: size.width*.02),
        ],
      ),
    );
  }
}

