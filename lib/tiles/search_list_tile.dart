import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:legal_friend/model_class/archive_data_model.dart';
import 'package:legal_friend/model_class/bodli_khana_model.dart';
import 'package:legal_friend/pages/archive_list.dart';
import 'package:legal_friend/pages/login_page.dart';
import 'package:legal_friend/pages/bodlikhana/payment_page.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/tiles/notification_widget.dart';
import 'package:legal_friend/variables/variables.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchListTile extends StatelessWidget {
  final int index;
  final List<BodliKhanaModel> dataList;
  const SearchListTile({this.index, this.dataList});

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
          Text('${dataList[index].mamlarDhoron==Variables.niAct
              ? Variables.crMamlaNo:Variables.mamlaNo}${dataList[index].mamlaNo}',
              style: TextStyle(
                  fontSize: size.width * .04, color: Colors.grey[900])),
          SizedBox(height: size.width * .01),

          Text('${dataList[index].pokkhoDhara}',
              style: TextStyle(
                  fontSize: size.width * .04, color: Colors.grey[900])),
          //SizedBox(height: size.width*.01),

          GradientButton(
            onPressed: () async {
                showLoadingDialog('অপেক্ষা করুন');
                await publicProvider.getArchiveDataList().then((value) {
                  List<ArchiveDataModel> subList = publicProvider.archiveDataList;
                  List<ArchiveDataModel> lst = subList.where((element) =>
                          (element.dataId.contains(dataList[index].id))).toList();
                  if (lst.isEmpty) {
                    closeLoadingDialog();
                    Navigator.push(context, MaterialPageRoute(
                            builder: (context) => PaymentPage(bodliKhanaModel: dataList[index])));
                  } else {
                    closeLoadingDialog();
                    showAnimatedDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          backgroundColor: Colors.white,
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('এই মামলাটি আপনার আর্কাইভে আছে',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey.shade900,
                                  fontSize: size.width*.05
                                ),
                              ),
                              SizedBox(height: size.width*.04),

                              GradientButton(
                                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchiveList())),
                                child: Text(Variables.archive,style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width*.05
                                ),),
                                height: size.width * .1,
                                width: size.width * .5,
                                //borderRadius: size.width * .03,
                                gradientColors: [
                                  Color(0xFF0D47A1),
                                  Color(0xFF1976D2),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      animationType: DialogTransitionType.slideFromTopFade,
                      curve: Curves.fastOutSlowIn,
                      duration: Duration(milliseconds: 500),
                    );
                  }
                });

            },
            child: Text(Variables.archiveRakhun,
                style: TextStyle(fontSize: size.width * .04)),
            height: size.width * .1,
            width: size.width * .5,
            //borderRadius: size.width * .03,
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
