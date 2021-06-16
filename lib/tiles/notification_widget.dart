import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget spinCircle()=>
    SpinKitCircle(
      color: Colors.green,
      size: 50.0,
    );

void showLoadingDialog(String status)=> EasyLoading.show(status: status);

void closeLoadingDialog()=> EasyLoading.dismiss();

void showSuccessMgs(String status)=> EasyLoading.showSuccess(status);

void showErrorMgs(String status)=> EasyLoading.showError(status);

void showToast(String status)=> EasyLoading.showToast(status);

void showInfo(String status)=> EasyLoading.showInfo(status);
