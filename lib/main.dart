import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:noteapp/config/app_routes.dart';
import 'package:noteapp/config/app_theme.dart';
import 'package:noteapp/models/note_model.dart';

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:noteapp/webview.dart';
import 'package:url_launcher/url_launcher.dart';


class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver{
  Future<void> getURL() async{
    final access = "3";
    final url = "https://google.com/";
    if(access == "1"){
      Future.delayed(Duration(seconds: 1),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WebViewScreen(initialUrl: url)));
      });
    }
    else{
      Future.delayed(Duration(seconds: 1),(){
        // Change to Home View
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyApp()));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    getURL();
  }
  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
      getURL();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Hình ảnh chính giữa màn hình
          FractionallySizedBox(
            widthFactor: 0.7, // Tỷ lệ chiều rộng của ảnh so với màn hình
            heightFactor: 0.3, // Tỷ lệ chiều cao của ảnh so với màn hình
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Loading circle nằm dưới màn hình
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

Future<void> initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.log('starting services ...');
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>("notes");
  Get.log('All services started...');
}

Future<void> main() async {
  await initServices();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Write Content Notes',
      theme: AppTheme.theme,
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
      defaultTransition: Transition.cupertino,
    );
  }
}
