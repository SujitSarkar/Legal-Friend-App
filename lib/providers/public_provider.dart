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
  List<BodliKhanaModel> _searchedList = [];


  get noticeBoardImageLink=> _noticeBoardImageLink;
  get bodliKhanaModel=> _bodliKhanaModel;
  get searchedList=> _searchedList;
  get archiveDataList=>_archiveDataList;

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
      if(_searchedList.isNotEmpty) return _searchedList[_searchedList.length-1].boiNo;
      else return '00/0000';
  }

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

  Future<void> getSearchedDataList(String collectionName)async{
    try{
      _searchedList.clear();
      await FirebaseFirestore.instance.collection(collectionName)
          .where('joj_court',isEqualTo: _bodliKhanaModel.jojCourt)
          .where('amoli_adalot',isEqualTo: _bodliKhanaModel.amoliAdalot)
          .where('mamla_no',isEqualTo: _bodliKhanaModel.mamlaNo).get().then((snapshot){
        for (var element in snapshot.docChanges) {
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
          _searchedList.add(bodliKhanaModel);
        }
      });
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

  // Future<void> transferMadokData() async {
  //   //WriteBatch batch = FirebaseFirestore.instance.batch();
  //   try {
  //     showLoadingDialog('Getting');
  //     await FirebaseFirestore.instance.collection('NIAct')
  //         .get().then((snapshot){
  //       _niActDataList.clear();
  //       snapshot.docChanges.forEach((element) {
  //         BodliKhanaModel bodliKhanaModel = BodliKhanaModel(
  //             id: element.doc['id'],
  //             amoliAdalot: element.doc['amoli_adalot'],
  //             bicarikAdalot: element.doc['bicarik_adalot'],
  //             boiNo: element.doc['boi_no'],
  //             dayraNo: element.doc['dayra_no'],
  //             entryDate: element.doc['entry_date'],
  //             mamlaNo: element.doc['mamla_no'],
  //             mamlarDhoron: element.doc['mamlar_dhoron'],
  //             pokkhoDhara: element.doc['pokkho_dhara'],
  //             porobortiTarikh: element.doc['poroborti_tarikh'],
  //             jojCourt: element.doc['joj_court']
  //         );
  //         _niActDataList.add(bodliKhanaModel);
  //       });
  //     });
  //       print(_niActDataList.length);
  //
  //
  //     // _niActDataList.forEach((element) async{
  //     //   await FirebaseFirestore.instance.collection('NIAct').doc(element.id).set({
  //     //           'id': element.id,
  //     //           'dayra_no': element.dayraNo,
  //     //           'mamla_no': element.mamlaNo,
  //     //           'pokkho_dhara': element.pokkhoDhara,
  //     //           'poroborti_tarikh': element.porobortiTarikh,
  //     //           'bicarik_adalot': element.bicarikAdalot,
  //     //           'amoli_adalot': element.amoliAdalot,
  //     //           'joj_court': element.jojCourt,
  //     //           'mamlar_dhoron': element.mamlarDhoron,
  //     //           'boi_no': element.boiNo,
  //     //           'entry_date': element.entryDate
  //     //   });
  //     // });
  //
  //     // showLoadingDialog('Transferring...');
  //     // await FirebaseFirestore.instance.collection('BodliKhana')
  //     //     .where('mamlar_dhoron', isEqualTo: Variables.madokDondobidhi).get().then((snapshot){
  //     //   snapshot.docChanges.forEach((element)async{
  //     //     await FirebaseFirestore.instance.collection('MadokDondobidhi').add(element.doc.data());
  //
  //         // batch.update(FirebaseFirestore.instance.collection('NIACT').doc(element.doc.id),
  //         //     {
  //         //       'id': element.doc['id'],
  //         //       'dayra_no': element.doc['dayra_no'],
  //         //       'mamla_no': element.doc['mamla_no'],
  //         //       'pokkho_dhara': element.doc['pokkho_dhara'],
  //         //       'poroborti_tarikh': element.doc['poroborti_tarikh'],
  //         //       'bicarik_adalot': element.doc['bicarik_adalot'],
  //         //       'amoli_adalot': element.doc['amoli_adalot'],
  //         //       'joj_court': element.doc['joj_court'],
  //         //       'mamlar_dhoron': element.doc['mamlar_dhoron'],
  //         //       'boi_no': element.doc['boi_no'],
  //         //       'entry_date': element.doc['entry_date']
  //         //     });
  //       // });
  //       //return batch.commit();
  //     // });
  //     closeLoadingDialog();
  //     showSuccessMgs('Transfer Success');
  //   } catch (error) {
  //     showErrorMgs(error.toString());
  //     print(error.toString());
  //   }
  // }

  // Future<void> getDistrict() async {
//   final String response = await rootBundle.loadString('assets/bd-districts.json');
//   final data = await json.decode(response);
//   _distList.clear();
//   data['districts'].forEach((element){
//     _distList.add('${element['bn_name']}');
//   });
//   notifyListeners();
// }

}