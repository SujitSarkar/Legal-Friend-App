import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legal_friend/model_class/archive_data_model.dart';
import 'package:legal_friend/model_class/bodli_khana_model.dart';
import 'package:legal_friend/tiles/notification_widget.dart';
import 'package:legal_friend/variables/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PublicProvider extends ChangeNotifier{
  SharedPreferences _preferences;
  String _pageValue='';
  BodliKhanaModel _bodliKhanaModel= BodliKhanaModel();
  String _noticeBoardImageLink='';

  List<ArchiveDataModel> _archiveDataList =[];
  List<BodliKhanaModel> _bodliKhanaList = [];
  List<BodliKhanaModel> _niActDataList = [];
  List<BodliKhanaModel> _madokDataList = [];
  List<BodliKhanaModel> _tribunalDataList = [];

  get noticeBoardImageLink=> _noticeBoardImageLink;
  get bodliKhanaModel=> _bodliKhanaModel;
  get bodliKhanaList=> _bodliKhanaList;
  get niActDataList=> _niActDataList;
  get madokDataList=> _madokDataList;
  get tribunalDataList=> _tribunalDataList;
  get archiveDataList=> _archiveDataList;

  set bodliKhanaModel(BodliKhanaModel model){
    model = BodliKhanaModel();
    _bodliKhanaModel = model;
    notifyListeners();
  }
  get pageValue => _pageValue;

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
    if(_pageValue==Variables.niAct) return '৫০১';
    else return 'মতিঝিল';
  }
  String crMamlaHintSecond(){
    if(_pageValue==Variables.niAct) return '২০১৯';
    else return '৪(৮)২১';
  }
  String toggleSign(){
    if(_pageValue==Variables.niAct) return '/';
    else return '-';
  }

  String toggleLastUpdatedBoiNo(){
    if(_pageValue==Variables.niAct){
      if(_niActDataList.isNotEmpty) return _niActDataList[_niActDataList.length-1].boiNo;
      else return '00/0000';
    }
    else if(_pageValue==Variables.madokDondobidhi){
      if(_madokDataList.isNotEmpty) return _madokDataList[_madokDataList.length-1].boiNo;
      else return '00/0000';
    }
    if(_pageValue==Variables.bisesTribunal){
      if(_tribunalDataList.isNotEmpty) return _tribunalDataList[_tribunalDataList.length-1].boiNo;
      else return '00/0000';
    }
    else return '00/0000';
  }

  // Future<void> getDistrict() async {
  //   final String response = await rootBundle.loadString('assets/bd-districts.json');
  //   final data = await json.decode(response);
  //   _distList.clear();
  //   data['districts'].forEach((element){
  //     _distList.add('${element['bn_name']}');
  //   });
  //   notifyListeners();
  // }

  Future<bool> getNoticeBoardImageLink()async{
    try{
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('NoticeBoard').get();
      final List<QueryDocumentSnapshot> image = snapshot.docs;
      if(image.isNotEmpty) _noticeBoardImageLink= image[0].get('image_link');
      notifyListeners();
      return true;
    }catch(error){
      showToast(error.toString());
      return false;
    }
  }

  Future<void> getBodliKhanaDataList()async{
    //final String todayDate = DateFormat("dd-MM-yyyy").format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch));
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

  Future<void> getArchiveDataList() async{
   _preferences = await SharedPreferences.getInstance();
    final String _userPhone = _preferences.getString('userPhone')??'';
    try{
      await FirebaseFirestore.instance.collection('UserArchiveData')
          .where('user_phone', isEqualTo: _userPhone).orderBy('save_date',descending: true)
          .get().then((snapshot){
        _archiveDataList.clear();
        snapshot.docChanges.forEach((element) {
          ArchiveDataModel model = ArchiveDataModel(
              id: element.doc['id'],
              dataId: element.doc['data_id'],
              userPhone: element.doc['user_phone'],
              userName: element.doc['user_name'],
              userAddress: element.doc['user_address'],
              amoliAdalot: element.doc['amoli_adalot'],
              bicarikAdalot: element.doc['bicarik_adalot'],
              boiNo: element.doc['boi_no'],
              dayraNo: element.doc['dayra_no'],
              entryDate: element.doc['entry_date'],
              mamlaNo: element.doc['mamla_no'],
              mamlarDhoron: element.doc['mamlar_dhoron'],
              pokkhoDhara: element.doc['pokkho_dhara'],
              porobortiTarikh: element.doc['poroborti_tarikh'],
              jojCourt: element.doc['joj_court'],
              saveDate: element.doc['save_date'],
          );
          _archiveDataList.add(model);
        });
      });
      notifyListeners();
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<bool> archiveData(Map<String, String> map)async{
    try{
      await FirebaseFirestore.instance.collection('UserArchiveData').doc(map['id']).set(map);
      return true;
    }catch(error){
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> savePaymentInfo(Map<String, String> map)async{
    try{
      await FirebaseFirestore.instance.collection('ArchivePaymentInfo').doc(map['merchant_ref_id']).set(map);
      return true;
    }catch(error){
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> deleteArchiveData(String id)async{
    try{
      await FirebaseFirestore.instance.collection('UserArchiveData').doc(id).delete();
      return true;
    }catch(error){
      showToast('ডিলিট অসম্পন্ন হয়েছে\nআবার চেষ্টা করুন');
          return false;
    }

  }
}