import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../../widget/app_text_field.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/bg.png"),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Center(child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/logo.png"),
                const SizedBox(height: 20),
                Text("Welcome to Notes", style: Theme.of(context).textTheme.titleLarge!),
                const SizedBox(height: 20),
                AppTextField(
                  hintText: "Enter the mobile number",
                  controller: controller.phoneNumberCtr,
                ),
                const SizedBox(height: 40),
                OTPTextField(
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 45,
                  style: TextStyle(
                      fontSize: 17
                  ),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.box,
                  onChanged: (value){
                    debugPrint(value);
                    controller.otpCtr = value;
                  },
                  onCompleted: (pin) {
                  },
                ),
                const SizedBox(height: 20),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(child: Text("Send OTP", style: TextStyle(color: Colors.black),), onPressed: () {
                      controller.firebasePhoneSignIn();
                    },)),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: CommonCircularButton(
                    child: Icon(Icons.arrow_right_alt_outlined),
                    onPressed: () {
                      controller.submitOTP();
                      // Get.to(()=>HomeScreen());
                    },
                  ),
                )

              ],
            ),
          )),
        ),
      ),
    );
  }
}

class CommonCircularButton extends StatelessWidget {
  const CommonCircularButton({
    super.key,
    required this.child,
    this.radius = 16,
    this.color =  Colors.amber,
    required this.onPressed,
  });
  final Widget child;
  final double radius;
  final Color color;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        elevation: 5.0,
        backgroundColor: color,
        shape: CircleBorder(),
        padding: EdgeInsets.all(radius),
      ),
    );
  }
}
