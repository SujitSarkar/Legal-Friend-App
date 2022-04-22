import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:legal_friend/model_class/user_login_model.dart';
import 'package:legal_friend/tiles/notification_widget.dart';
import 'package:http/http.dart' as http;
import 'package:legal_friend/variables/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider extends ChangeNotifier{

  UserLoginModel loginModel = UserLoginModel();

  Future<bool> login(String phone, String password)async{
    showLoadingDialog('Logging in...');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    try{
      http.Response response = await http.get(Uri.parse(Variables.baseURL+'login.php?phone=$phone&password=$password'));
      if(response.statusCode==200){
        final jsonData = jsonDecode(response.body);
        if(jsonData['status'].toLowerCase()=='success'){
          loginModel = userLoginModelFromJson(response.body);
          notifyListeners();
          await pref.setString('phone', phone);
          await pref.setString('password', password);
          closeLoadingDialog();
          showToast(loginModel.message);
          return true;
        }else{
          closeLoadingDialog();
          showToast(jsonData['message']);
          return false;
        }
      }else{
        closeLoadingDialog();
        showToast('Failed try again');
        return false;
      }
    }on SocketException{
      closeLoadingDialog();
      showToast('ইন্টারনেট সনযোগ নেই');
      return false;
    }catch(e){
      closeLoadingDialog();
      showToast(e.toString());
      return false;
    }
  }

  Future<bool> createUser(Map<String, dynamic> map)async{
    showLoadingDialog('Creating profile...');
    try{
      http.Response response = await http.get(Uri.parse(Variables.baseURL
          +'registerUser.php?name=${map['name']}&email=${map['email']}'
              '&phone=${map['phone']}&password=${map['password']}&profession=${map['profession']}'
              '&company=${map['company']}&address=${map['address']}&gender=${map['gender']}&dob=${map['dob']}'
              '&religion=${map['religion']}&material_status=${map['material_status']}'));
      if(response.statusCode==200){
        final jsonData = jsonDecode(response.body);
        if(jsonData['status'].toLowerCase()=='success'){
          closeLoadingDialog();
          showToast(jsonData['message']);
          return true;
        }else{
          closeLoadingDialog();
          showToast(jsonData['message']);
          return false;
        }
      }else{
        closeLoadingDialog();
        showToast('Failed try again');
        return false;
      }
    }on SocketException{
      closeLoadingDialog();
      showToast('ইন্টারনেট সনযোগ নেই');
      return false;
    }catch(e){
      closeLoadingDialog();
      showToast(e.toString());
      return false;
    }
  }
}