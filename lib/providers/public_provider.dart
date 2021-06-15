import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:legal_friend/model_class/bodli_khana_model.dart';
import 'package:legal_friend/tiles/notification_widget.dart';
import 'package:legal_friend/variables/variables.dart';


class PublicProvider extends ChangeNotifier{
  List<String> _distList=[];
  String _pageValue='';
  BodliKhanaModel _bodliKhanaModel= BodliKhanaModel();

  List<BodliKhanaModel> _bodliKhanaList = [];
  List<BodliKhanaModel> _niActDataList = [];
  List<BodliKhanaModel> _madokDataList = [];
  List<BodliKhanaModel> _tribunalDataList = [];

  get bodliKhanaModel=> _bodliKhanaModel;
  get bodliKhanaList=> _bodliKhanaList;
  get niActDataList=> _niActDataList;
  get madokDataList=> _madokDataList;
  get tribunalDataList=> _tribunalDataList;

  set bodliKhanaModel(BodliKhanaModel model){
    model = BodliKhanaModel();
    _bodliKhanaModel = model;
    notifyListeners();
  }
  get pageValue => _pageValue;
  get distList => _distList;

  set pageValue(String val){
    _pageValue = val;
    notifyListeners();
  }

  String togglePageName(){
    if(_pageValue.isNotEmpty) return _pageValue;
    else return '';
  }
  Color toggleHeaderColor(){
    if(_pageValue==Variables.niAct) return Colors.red[500];
    else if(_pageValue==Variables.madokDondobidhi) return Colors.green[600];
    else if(_pageValue==Variables.bisesTribunal) return Colors.yellow[900];
    else return Colors.grey[800];
  }

  String crToggle(){
    if(_pageValue==Variables.niAct) return Variables.crMamlaNo;
    else return Variables.mamlaNo;
  }
  String crMamlaHintFirst(){
    if(_pageValue==Variables.niAct) return '২৯২৫';
    else return 'মতিঝিল';
  }
  String crMamlaHintSecond(){
    if(_pageValue==Variables.niAct) return '২০১৯';
    else return '৪(৮)২০২০';
  }
  String toggleSign(){
    if(_pageValue==Variables.niAct) return '/';
    else return '-';
  }

  Future<void> getDistrict() async {
    final String response = await rootBundle.loadString('assets/bd-districts.json');
    final data = await json.decode(response);
    _distList.clear();
    data['districts'].forEach((element){
      _distList.add('${element['bn_name']}');
    });
    notifyListeners();
  }


  Future<void> getBodliKhanaDataList()async{
    final String todayDate = DateFormat("dd-MM-yyyy").format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch));
    try{
      await FirebaseFirestore.instance.collection('BodliKhana').orderBy('boi_no').get().then((snapshot){
        _bodliKhanaList.clear();
        _niActDataList.clear();
        _madokDataList.clear();
        _tribunalDataList.clear();
        snapshot.docChanges.forEach((element) {
          BodliKhanaModel bodliKhanaModel = BodliKhanaModel(
              id: element.doc['id'],
              amoliAdalot: element.doc['amoli_adalot'],
              bicarikAdalot: element.doc['bicarik_adalot'],
              boiNo: element.doc['boi_no'],
              dayraNo: element.doc['dayra_no'],
              entryDate: element.doc['entry_date'],
              mamlaNo: element.doc['mamla_no'],
              mamlarDhoron: element.doc['mamlar_dhoron'],
              pokkhoDhara: element.doc['pokkho_dhara'],
              porobortiTarikh: element.doc['poroborti_tarikh'],
              jojCourt: element.doc['joj_court']
          );
          _bodliKhanaList.add(bodliKhanaModel);
        });
      });
      for(int i=0; i<_bodliKhanaList.length; i++){
        if(_bodliKhanaList[i].mamlarDhoron==Variables.niAct){
          _niActDataList.add(_bodliKhanaList[i]);
        }
        else if(_bodliKhanaList[i].mamlarDhoron==Variables.madokDondobidhi){
          _madokDataList.add(_bodliKhanaList[i]);
        }
        else if(_bodliKhanaList[i].mamlarDhoron==Variables.bisesTribunal){
          _tribunalDataList.add(_bodliKhanaList[i]);
        }
      }
      notifyListeners();
    }catch(error){
      showToast(error.toString());
    }
  }

  String getLastUpdateBoi(){

  }
}