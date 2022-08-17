import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class SmsService{

  List<String> recipents = ["+8801612525115", "+8801766609988"];
  Future<void> sendSms(String message) async {
    try {
      String _result = await sendSMS(
        message: message,
        recipients: recipents,
        sendDirect: true,
      );
      Fluttertoast.showToast(
        msg: "sms send to +8801766609988",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (error) {
      print(error.toString()+"<<<<<<<<<error>>>>>>>>>");
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  sendSmsFromMobile(BuildContext context,String otpCode)async{
    PermissionStatus sendSmsPermissionStatus = await Permission.sms.request();
    if (sendSmsPermissionStatus == PermissionStatus.granted) {
      await sendSms(
          "Your OTP code is $otpCode");
      // Timer.periodic(Duration(seconds: 60), (timer) async {
      //   //print(DateTime.now());
      //   await .sendSms(
      //       "Dear ${paymentModel.data![0].memberName} please pay ${paymentModel.data![0].totalAmount} TK");
      // }
      // );
    }
    if (sendSmsPermissionStatus == PermissionStatus.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("This permission is recommended")));
    }
    if (sendSmsPermissionStatus == PermissionStatus.permanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("This permission is recommended")));
    }
  }

}