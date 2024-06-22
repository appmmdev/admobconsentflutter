import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart';

import '../Helper/intializationhelper.dart';
import '../Provider/themeProvider.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  String loadingStatus = '';
  bool isLoading = false;
  final _initializedHelper = IntializationHelper();
  String appVersionName = '';

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    checkUpdate();

    super.initState();
  }

  Future<void> _initialize() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initializedHelper.intialize();
    });
  }

void checkUpdate()async{

      await _initialize();
    setState(() {});

    // Your Next Plan
}







  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: context.watch<MyThemeProvider>().themeDataPro,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 85,
                child: CircleAvatar(
                    radius: 79,
                    backgroundImage: AssetImage('assets/images/logo.png')),
              ),
              const SizedBox(
                height: 20,
              ),

              Text('App Version : $appVersionName'),
              const SizedBox(
                height: 20,
              ),
              const CircularProgressIndicator.adaptive(),
              const SizedBox(height: 16),
              // // Add some spacing between the CircularProgressIndicator and the Text
              Text(loadingStatus),
            ],
          ),

          // play a loading indicator while the Future is running
        ),
      ),
    );
  }
}
