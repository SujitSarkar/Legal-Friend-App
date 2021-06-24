import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:legal_friend/model_class/archive_data_model.dart';
import 'package:legal_friend/variables/variables.dart';

// ignore: must_be_immutable
class ArchiveTile extends StatelessWidget {
  int index;
  List<ArchiveDataModel> dataList;
  ArchiveTile({this.index,this.dataList});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    final String todayDate = DateFormat("dd-MM-yyyy")
        .format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch));
    return Container(
      width: size.width*.8,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.width*.02),
          Text('${dataList[index].mamlarDhoron==Variables.niAct
              ? Variables.crMamlaNo:Variables.mamlaNo}${dataList[index].mamlaNo}',style: TextStyle(
              fontSize: size.width * .042,
              fontWeight: FontWeight.bold,
               color: todayDate==dataList[index].saveDate?Theme.of(context).primaryColor: Colors.grey[900])),
          SizedBox(height: size.width*.01),

          Text(dataList[index].pokkhoDhara,style: TextStyle(
              fontSize: size.width * .042,
              fontWeight: FontWeight.bold,
              color: todayDate==dataList[index].saveDate?Theme.of(context).primaryColor: Colors.grey[900])),

          SizedBox(height: size.width*.02),
        ],
      ),
    );
  }
}

