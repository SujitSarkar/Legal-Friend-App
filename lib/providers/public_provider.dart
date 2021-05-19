import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legal_friend/variables/variables.dart';


class PublicProvider extends ChangeNotifier{
  List<String> _distList=[];

  int _pageValue=0;
  get pageValue => _pageValue;
  get distList => _distList;

  set pageValue(int val){
    _pageValue = val;
    notifyListeners();
  }

  String togglePageName(){
    if(_pageValue==1) return Variables.niAct;
    else if(_pageValue==2) return Variables.madokDondobidhi;
    else if(_pageValue==3) return Variables.bisesTribunal;
    else return '';
  }
  Color toggleHeaderColor(){
    if(_pageValue==1) return Colors.red[500];
    else if(_pageValue==2) return Colors.green[600];
    else if(_pageValue==3) return Colors.yellow[900];
    else return Colors.grey[800];
  }

  String crToggle(){
    if(_pageValue==1) return Variables.crMamlaNo;
    else return Variables.mamlaNo;
  }
  String toggleSign(){
    if(_pageValue==1) return '/';
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
}