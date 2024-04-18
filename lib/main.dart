import 'package:demo_app/screens/Login_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyA4XaGW-aLOUni1mpSESyD6hlT1RaCLLrg",
        appId: "1:708699575637:android:643d52efe79a9d8b95cbdc",
        messagingSenderId: "708699575637",
        projectId: "demoapp-4d76e"),
  );
  runApp(const ScreenUtilInit(designSize: Size(375, 375), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Demo App',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
