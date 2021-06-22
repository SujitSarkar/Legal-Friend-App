import 'package:flutter/material.dart';
import 'package:legal_friend/model_class/archive_data_model.dart';
import 'package:legal_friend/model_class/bodli_khana_model.dart';
import 'package:legal_friend/pages/login_page.dart';
import 'package:legal_friend/pages/payment_page.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/tiles/notification_widget.dart';
import 'package:legal_friend/variables/variables.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SearchListTile extends StatelessWidget {
  int index;
  List<BodliKhanaModel> dataList;
  SearchListTile({this.index, this.dataList});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    return Container(
      width: size.width * .8,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.width * .05),
          Text('${publicProvider.crToggle()}${dataList[index].mamlaNo}',
              style: TextStyle(
                  fontSize: size.width * .04, color: Colors.grey[900])),
          SizedBox(height: size.width * .01),

          Text('${dataList[index].pokkhoDhara}',
              style: TextStyle(
                  fontSize: size.width * .04, color: Colors.grey[900])),
          //SizedBox(height: size.width*.01),

          GradientButton(
            onPressed: () async {
              SharedPreferences _pref = await SharedPreferences.getInstance();
              if (_pref.getString('userPhone') != null) {
                showLoadingDialog('অপেক্ষা করুন');
                await publicProvider.getArchiveDataList().then((value) {
                  List<ArchiveDataModel> subList =
                      publicProvider.archiveDataList;
                  List<ArchiveDataModel> lst = subList
                      .where((element) =>
                          (element.dataId.contains(dataList[index].id)))
                      .toList();
                  if (lst.isEmpty) {
                    closeLoadingDialog();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentPage(
                                id: dataList[index].id,
                                amoliAdalot: dataList[index].amoliAdalot,
                                bicarikAdalot: dataList[index].bicarikAdalot,
                                boiNo: dataList[index].boiNo,
                                dayraNo: dataList[index].dayraNo,
                                entryDate: dataList[index].entryDate,
                                mamlaNo: dataList[index].mamlaNo,
                                mamlarDhoron: dataList[index].mamlarDhoron,
                                pokkhoDhara: dataList[index].pokkhoDhara,
                                porobortiTarikh:
                                    dataList[index].porobortiTarikh,
                                jojCourt: dataList[index].jojCourt)));
                  } else {
                    closeLoadingDialog();
                    showInfo('এই তথ্যটি আগে থেকেই আপনার আর্কাইভ করা আছে');
                  }
                });
              } else
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogInPage()));
            },
            child: Text(Variables.archiveRakhun,
                style: TextStyle(fontSize: size.width * .04)),
            height: size.width * .1,
            width: size.width * .5,
            borderRadius: size.width * .03,
            gradientColors: [
              Colors.blue.shade600,
              Colors.blue.shade500,
            ],
          ),
          SizedBox(height: size.width * .02),
        ],
      ),
    );
  }
}
