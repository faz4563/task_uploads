// ignore_for_file: file_names

import 'package:demo_app/mini%20widgets/commonTextFields.dart';
import 'package:demo_app/screens/home_screen.dart';
import 'package:demo_app/services/firebaseLogin.dart';
import 'package:demo_app/utils/common_strings.dart';
import 'package:demo_app/utils/images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final fullWidth = MediaQuery.of(context).size.width;
    final fullHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.blueGrey.shade100,
        body: SingleChildScrollView(
          child: SizedBox(
            width: fullWidth,
            height: fullHeight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: fullWidth,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 100.r,
                              height: 100.r,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 10, color: Colors.grey)
                                  ],
                                  image: DecorationImage(
                                      image: AssetImage(
                                          DemoAppAssetImages.loginImg),
                                      fit: BoxFit.fitWidth)),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              child: Text(CommonStrings.login,
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    decoration: TextDecoration.none,
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 2.h),
                              child: CommonTextFields(
                                controllerValue: emailController,
                                labelName: "Email",
                                obscurePresent: false,
                                obscureEnabled: false,
                                sufficIcon: null,
                                hintText: "Email",
                                prefixIcon: const Icon(Icons.email_outlined),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 2.h),
                              child: CommonTextFields(
                                controllerValue: passwordController,
                                labelName: "Password",
                                obscurePresent: true,
                                obscureEnabled: true,
                                sufficIcon: null,
                                hintText: "Password",
                                prefixIcon: const Icon(Icons.lock_outline),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 5.w),
                                child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Forget Password ?",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w800),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 0.h),
                              child: ElevatedButton(
                                  onPressed: ()  {
                                    signIn(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.r)),
                                      fixedSize: Size(fullWidth, 20.h)),
                                  child: Text(
                                    CommonStrings.login,
                                    style: const TextStyle(color: Colors.white),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Do not have an account?",
                            style:
                                TextStyle(fontSize: 18.sp, color: Colors.grey)),
                        WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18.sp),
                                )))
                      ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signIn(context) async {
    var token = await AppLoginFirebase.signInWithFirebase(
        emailController, passwordController, auth);

    if (token != "") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>   HomeScreen(
              token: token,
            ),
          ));
    }
  }
}
