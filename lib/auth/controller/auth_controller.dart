
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import '../screens/auth_gate.dart';

class AuthController extends GetxController with StateMixin{
  TextEditingController phoneNumberCtr = TextEditingController();
  String otpCtr = '';

  RxString get verificationId => _verificationId;
  RxBool isRegister = false.obs;

  final RxString _verificationId = "".obs;

  updateVerificationId(String id) {
    _verificationId.value = id;
  }

  firebasePhoneSignIn() {
    // change(null, status: RxStatus.loadingMore());
    String phoneNumber = phoneNumberCtr.text;

   if(phoneNumber.isNotEmpty && phoneNumber.length>12){
     void verificationCompleted(AuthCredential phoneAuthCredential) {
       debugPrint(phoneAuthCredential.toString());
     }

     void verificationFailed(FirebaseAuthException error) {
       change(null, status: RxStatus.success());
       // SnackBarMessageWidget.show(error.message.toString());
     }

     void codeSent(String verificationId, int? code) {
       updateVerificationId(verificationId);
       change(null, status: RxStatus.success());
       // Get.toNamed(OTPVerificationScreen.routeName);
     }

     void codeAutoRetrievalTimeout(String verificationId) {
       updateVerificationId(verificationId);
       change(null, status: RxStatus.success());
     }

     FirebaseAuth auth = FirebaseAuth.instance;
     auth.verifyPhoneNumber(
       phoneNumber: phoneNumber,
       timeout: const Duration(milliseconds: 10000),
       verificationCompleted: verificationCompleted,
       verificationFailed: verificationFailed,
       codeSent: codeSent,
       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
     );
   }
   else{
     Get.snackbar("Please Enter a Valid Phone Number", "",
         backgroundColor: Colors.black);

   }
  }

  submitOTP() async {
    debugPrint(otpCtr);
    change(null, status: RxStatus.loading());
    debugPrint("${otpCtr}verId${verificationId.value}");
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otpCtr,
      );
      FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential userCredential =
          (await auth.signInWithCredential(credential));

      User? user = userCredential.user;

      String token = await user!.getIdToken(true);
      debugPrint("token:$token");
      Get.offAll(()=>const AuthGate());
      return user;
    } on FirebaseAuthException catch (e) {
      Get.snackbar("e.message.toString()","" );
      change(null, status: RxStatus.error(e.message));
      debugPrint("Failed to sign in: $e");
    }
    return null;
  }

  resetData() {
    phoneNumberCtr.clear();

    change(null, status: RxStatus.success());
  }

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }
}
