import 'package:flutter/material.dart';
import 'package:sms_auto_fill/service_provider/sms_service.dart';
import 'package:sms_auto_fill/sms_verification_page.dart';
import 'package:sms_autofill/sms_autofill.dart';

class SendCodePage extends StatelessWidget {
  SendCodePage({Key? key}) : super(key: key);

  TextEditingController otpCodeTextEditingController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 200,),
                // TextFormField(
                //   controller: otpCodeTextEditingController,
                //   keyboardType: TextInputType.phone,
                //   decoration: const InputDecoration(
                //     border: OutlineInputBorder(),
                //   ),
                // ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      label: const Text("Member ID"),
                      //hintText: "En",
                      fillColor: Colors.white70),
                  validator: (value){
                    if(value!.isEmpty ||RegExp(r'ˆ[0-9]+$').hasMatch(value)||value.length<4){
                      return "Enter Correct MemberId";
                    }else{
                      return  null;
                    }
                  },
                  keyboardType: TextInputType.phone,
                  controller: otpCodeTextEditingController,
                ),
                ElevatedButton(
                  onPressed: () async{
                    var appSignatureID = await SmsAutoFill().getAppSignature;
                    Map sendOtpData = {
                      "mobile_number": "+8801766609988",//mobileNumber.text,
                      "app_signature_id": appSignatureID
                    };
                    print(sendOtpData);
                    /*OTP will comes from server using bulk sms service But
                     here i am using flutter sms for testing otp sms*/
                    await SmsService().sendSmsFromMobile(context,otpCodeTextEditingController.text+" "+appSignatureID.toString());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SmsVerificationPage())
                    );
                  },
                  child: const Text("Send sms"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
